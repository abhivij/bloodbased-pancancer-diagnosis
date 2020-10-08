library(caret)

compute_mean_and_ci <- function(metric_list, metric_name){
  # qqnorm(metric_list)
  # qqline(metric_list)
  print(metric_name)
  if(length(metric_list) > 1){
    result <- t.test(metric_list)
    metric_mean <- round(mean(metric_list), 4)
    metric_ci_lower <- round(result$conf.int[1], 4)
    metric_ci_upper <- round(result$conf.int[2], 4)    
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


run_fsm_and_model <- function(x, output_labels, fsm = NA, model,
                              random_seed = 1000, train_ratio = 0.8, sample.total = 30, 
                              regularize = NA, kernel = NA){
  set.seed(random_seed)
  
  train_index <- createDataPartition(output_labels$Label, p = train_ratio, list = FALSE, times = sample.total)
  
  acc_list <- c()
  auc_list <- c()
  features_count <- c()
  for (sample.count in 1:sample.total){
    x.train <- x[train_index[, sample.count], ]
    y.train <- output_labels[train_index[, sample.count], ]
    
    x.test <- x[-train_index[, sample.count], ]
    y.test <- output_labels[-train_index[, sample.count], ]
    
    if(!is.na(fsm)){
      features <- fsm(x.train, y.train)
      features_count[sample.count] <- length(features)
    }
    else{
      features <- c()
    }
    
    if(!is.na(regularize)){
      result <- model(x.train, y.train, x.test, y.test, features = features, regularize = regularize)  
    }
    else if(!is.na(kernel)){
      result <- model(x.train, y.train, x.test, y.test, features = features, kernel = kernel)  
    }
    else{
      result <- model(x.train, y.train, x.test, y.test, features = features)  
    }
    
    acc_list[sample.count] <- result[1]
    auc_list[sample.count] <- result[2]
  }  
  
  fsm_df <- compute_mean_and_ci(features_count, 'Number of features')
  model_df <- compute_mean_and_ci(acc_list, 'Accuracy')
  model_df <- cbind(model_df, compute_mean_and_ci(auc_list, 'AUC'))
  
  return (list(fsm_df, model_df))
}