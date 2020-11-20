library(caret)
source("preprocessing/preprocessing.R")
source("run_all_models.R")


run_fsm_and_models <- function(x, output_labels, classes, 
                                fsm = NA, fsm_name = "all", transformation = FALSE,
                                random_seed = 1000, folds = 5, sample.total = 30,
                                adjust_method = NA, variance_threshold = NA){
  
  print(paste("FSM :", fsm_name))
  
  set.seed(random_seed)
  train_index <- createMultiFolds(y = output_labels$Label, k = folds, times = sample.total / folds)
  
  features_count <- c()
  
  #providing empty values here, so as to provide default values for fsms where this is not applicable
  #default values are necessary to enable compatibility during rbind in write_results in helper.R
  all_iter_variance_thresholds <- list('0.5' = c(), '0.75' = c(), '0.9' = c(), '0.95' = c(), '0.99' = c())
  
  features_matrix <- matrix(nrow = sample.total, ncol = dim(x)[2]+1)
  colnames(features_matrix) <- c('Iter', colnames(x))
  features_matrix[, 1] <- c(1:sample.total)
  features_matrix[, -1] <- 0
  #Eg features_matrix 
  # Iter  t1  t2  t3  t4  t5
  #   1   0   0   0   0   0
  #   2   0   0   0   0   0
  #   3   0   0   0   0   0
  #   4   0   0   0   0   0
  
  #Eg features_matrix after passing through the loop below
  # Iter  t1  t2  t3  t4  t5
  #   1   0   0   1   1   1
  #   2   1   0   1   1   1
  #   3   0   0   1   1   0
  #   4   0   0   1   1   1

  for (sample.count in 1:sample.total){
    x.train <- x[train_index[[sample.count]], ]
    y.train <- output_labels[train_index[[sample.count]], ]
    
    x.test <- x[-train_index[[sample.count]], ]
    y.test <- output_labels[-train_index[[sample.count]], ]
    
    #preprocess train and test data
    preprocessed_data_list <- filter_and_normalize(x.train, y.train, x.test, y.test)
    x.train <- preprocessed_data_list[[1]]
    y.train <- preprocessed_data_list[[2]]
    x.test <- preprocessed_data_list[[3]]
    y.test <- preprocessed_data_list[[4]]
    #train and test data has been preprocessed
    
    if(fsm_name != "all"){
      fsm_output <- fsm(x.train, y.train, x.test, y.test, classes, 
                        adjust_method = adjust_method, variance_threshold = variance_threshold)
      x.train <- fsm_output[[1]]
      y.train <- fsm_output[[2]]
      x.test <- fsm_output[[3]]
      y.test <- fsm_output[[4]]
      variance_thresholds <- fsm_output[[5]]
      all_iter_variance_thresholds <- get_all_iter_variance_thresholds(all_iter_variance_thresholds, variance_thresholds, sample.count)
    }
    features <- colnames(x.train)
    features_count[sample.count] <- length(features)
    
    if(!transformation){
      #if fsm is a transformation method, features will not be subset of original transcripts - so below step not done
      #Except 1st column, features_matrix remains all 0s for transformation methods 
      features_matrix[sample.count, features] <- 1  
    }
    
    results <- run_all_models(x.train, y.train, x.test, y.test, classes = classes)
    #results eg :
    # [["modelname", [acc, auc, tpr, tnr],
    #  ["SVM", [0.95, 0.89, 0.9, 0.7]]]]
    
    #all_results eg :
    # $lr
        # $lr[[1]]
        # c(0.95, 0.96, 0.85)
        # $lr[[2]]
        # c(0.89, 0.9, 0.84)
        # $lr[[3]]
        # c(0.9, 0.85, 0.96)
        # $lr[[4]]
        # c(0.7, 0.65, 0.6)
    # $svm
        # $svm[[1]]
        # c(0.97, 0.96, 0.85)
        # $svm[[2]]
        # c(0.94, 0.9, 0.84)
        # $svm[[3]]
        # c(0.93, 0.9, 0.88)
        # $svm[[4]]
        # c(0.9, 0.85, 0.9)
    
    if (sample.count == 1) {
      all_results <- list()
      for(result in results){
        model_name <- result[[1]] 
        all_results[[model_name]] <- list(c(), c(), c(), c())
      }
    }
    for(result in results){
      model_name <- result[[1]]
      all_results[[model_name]][[1]][sample.count] <- result[[2]][1]
      all_results[[model_name]][[2]][sample.count] <- result[[2]][2]
      all_results[[model_name]][[3]][sample.count] <- result[[2]][3]
      all_results[[model_name]][[4]][sample.count] <- result[[2]][4]
    }    
  }  
  features_df <- cbind(FSM = fsm_name, as.data.frame(features_matrix))
  
  fsm_df <- data.frame(FSM = fsm_name)
  #compute mean and 95 CI of number of features - ttest is used for this
  fsm_df <- cbind(fsm_df,
                  compute_mean_and_ci(features_count, 'Number of features'))
  #similarly, compute mean and 95 CI for number of PCs required for different values of cumulative variance
  for (vt in names(all_iter_variance_thresholds)) {
    fsm_df <- cbind(  fsm_df, 
                      compute_mean_and_ci(
                        all_iter_variance_thresholds[[vt]], 
                        paste('Number of components for Cum Var', vt)
                      )
                    )
  }
  
  all_fsm_model_df <- data.frame()
  for(model in names(all_results)){
    acc_list <- all_results[[model]][[1]]
    auc_list <- all_results[[model]][[2]]
    tpr_list <- all_results[[model]][[3]]
    tnr_list <- all_results[[model]][[4]]
    
    fsm_model_df <- data.frame(FSM = fsm_name, Model = model)
    fsm_model_df <- cbind(fsm_model_df, 
                          compute_mean_and_ci(acc_list, 'Accuracy'), 
                          compute_mean_and_ci(auc_list, 'AUC'),
                          compute_mean_and_ci(tpr_list, 'TPR'),
                          compute_mean_and_ci(tnr_list, 'TNR'))
    all_fsm_model_df <- rbind(all_fsm_model_df, fsm_model_df)
  }

  return (list(fsm_df, all_fsm_model_df, features_df))
}


compute_mean_and_ci <- function(metric_list, metric_name){
  # qqnorm(metric_list)
  # qqline(metric_list)
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