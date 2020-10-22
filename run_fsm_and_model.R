library(caret)
source("preprocessing/preprocessing.R")

compute_mean_and_ci <- function(metric_list, metric_name){
  # qqnorm(metric_list)
  # qqline(metric_list)
  print(metric_name)
  if(length(metric_list) > 1){
    metric_mean <- round(mean(metric_list), 4)
    metric_ci_lower = metric_ci_upper = metric_list[1]
    #t.test throws error if constant data is sent
    #using try block to avoid execution halt and default to values in previous line
    try({
      result <- t.test(metric_list)
      metric_ci_lower <- round(result$conf.int[1], 4)
      metric_ci_upper <- round(result$conf.int[2], 4)  
    })
  }
  else if(length(metric_list) == 1){
    print('Warning : Not enough observations for t.test')
    metric_mean = metric_ci_lower = metric_ci_upper = metric_list[1]
  }
  else{
    metric_mean <- NA
    metric_ci_lower <- NA
    metric_ci_upper <- NA
  }
  
  print(paste('Mean : ', metric_mean))
  print(paste('95 CI :', metric_ci_lower, metric_ci_upper))  
  
  metric_mean_field_name <- paste("Mean", metric_name, sep = "_")
  metric_ci_lower_field_name <- paste("95 CI", metric_name, "lower", sep = "_")
  metric_ci_upper_field_name <- paste("95 CI", metric_name, "upper", sep = "_")
  
  result_df <- data.frame(matrix(ncol = 3, nrow = 1))
  colnames(result_df) <- c(metric_mean_field_name, metric_ci_lower_field_name, metric_ci_upper_field_name)
  result_df[metric_mean_field_name] <- metric_mean
  result_df[metric_ci_lower_field_name] <- metric_ci_lower
  result_df[metric_ci_upper_field_name] <- metric_ci_upper
  
  return (result_df)
}

get_all_iter_variance_thresholds <- function(all_iter_variance_thresholds, variance_thresholds, sample.count){
  for (vt in names(variance_thresholds)) {
    all_iter_variance_thresholds[[vt]][sample.count] <- variance_thresholds[vt]  
  }  
  return (all_iter_variance_thresholds)
}


run_fsm_and_model <- function(x, output_labels, classes = classes, fsm = NA, model,
                              random_seed = 1000, train_ratio = 0.8, sample.total = 30, 
                              regularize = NA, kernel = NA){
  set.seed(random_seed)
  
  train_index <- createDataPartition(output_labels$Label, p = train_ratio, list = FALSE, times = sample.total)
  
  acc_list <- c()
  auc_list <- c()
  features_count <- c()
  
  #providing empty values here, so as to provide default values for fsms where this is not applicable
  #default values are necessary to enable compatibility during rbind in write_results in helper.R
  all_iter_variance_thresholds <- list('0.5' = c(), '0.75' = c(), '0.9' = c(), '0.95' = c(), '0.99' = c())
  for (sample.count in 1:sample.total){
    x.train <- x[train_index[, sample.count], ]
    y.train <- output_labels[train_index[, sample.count], ]
    
    x.test <- x[-train_index[, sample.count], ]
    y.test <- output_labels[-train_index[, sample.count], ]
    
    #obtain preprocessed train and test data
    preprocessed_data_list <- filter_and_normalize(x.train, y.train, x.test, y.test)
    x.train <- preprocessed_data_list[[1]]
    y.train <- preprocessed_data_list[[2]]
    x.test <- preprocessed_data_list[[3]]
    y.test <- preprocessed_data_list[[4]]
    #train and test data has been preprocessed
    
    if(!is.na(fsm)){
      fsm_output <- fsm(x.train, y.train, x.test, y.test, classes)
      x.train <- fsm_output[[1]]
      y.train <- fsm_output[[2]]
      x.test <- fsm_output[[3]]
      y.test <- fsm_output[[4]]
      variance_thresholds <- fsm_output[[5]]
      features <- colnames(x.train)
      features_count[sample.count] <- length(features)
      all_iter_variance_thresholds <- get_all_iter_variance_thresholds(all_iter_variance_thresholds, variance_thresholds, sample.count)
    }
    else{
      features <- NA
      features_count[sample.count] <- dim(x.train)[2]
    }
    
    if(!is.na(regularize)){
      result <- model(x.train, y.train, x.test, y.test, classes = classes, regularize = regularize)  
    }
    else if(!is.na(kernel)){
      result <- model(x.train, y.train, x.test, y.test, classes = classes, kernel = kernel)  
    }
    else{
      result <- model(x.train, y.train, x.test, y.test, classes = classes)  
    }
    
    acc_list[sample.count] <- result[1]
    auc_list[sample.count] <- result[2]
  }  
  
  #compute mean and 95 CI of number of features - ttest is used for this
  fsm_df <- compute_mean_and_ci(features_count, 'Number of features')
  #similarly, compute mean and 95 CI for number of PCs required for different values of cumulative variance
  for (vt in names(all_iter_variance_thresholds)) {
    fsm_df <- cbind(  fsm_df, 
                      compute_mean_and_ci(
                        all_iter_variance_thresholds[[vt]], 
                        paste('Number of components for Cum Var', vt)
                      )
                    )
  }
  
  #compute mean and 95 CI for all metrics
  model_df <- compute_mean_and_ci(acc_list, 'Accuracy')
  model_df <- cbind(model_df, compute_mean_and_ci(auc_list, 'AUC'))
  
  return (list(fsm_df, model_df))
}