# source("R/preprocessing/preprocessing.R")
# source("R/run_all_models.R")
# source("R/feature_extraction/pca.R")

#   x format : (samples x transcripts)
#   output_labels format : (2 columns : Sample, Label)
run_fsm_and_models <- function(x, output_labels, classes, 
                                fsm = NA, fsm_name = "all", transformation = FALSE,
                                random_seed = 1000, folds = 5, sample.total = 30,
                                p_value_threshold = 0.05, adjust_method = NA,
                                variance_threshold = NA,
                                embedding_size = NA, var_embedding = FALSE, use_pca = FALSE,
                                imp = NA, attr_num = NA, perc_attr = NA, filter = TRUE,
                               perform_filter, norm,
                               classifier_feature_imp){
  
  print(paste("FSM :", fsm_name))
  
  start_time <- Sys.time()

  set.seed(random_seed)
  train_index <- caret::createMultiFolds(y = output_labels$Label, k = folds, times = sample.total / folds)
  
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
    x.train <- x[train_index[[sample.count]], , drop = FALSE]
    y.train <- output_labels[train_index[[sample.count]], ]
    
    x.test <- x[-train_index[[sample.count]], , drop = FALSE]
    y.test <- output_labels[-train_index[[sample.count]], ]

    preprocessed_data_list <- filter_and_normalize(x.train, y.train, x.test, y.test, filter = filter,
                                                   perform_filter = perform_filter, norm = norm)
    x.train <- preprocessed_data_list[[1]]
    y.train <- preprocessed_data_list[[2]]
    x.test <- preprocessed_data_list[[3]]
    y.test <- preprocessed_data_list[[4]]
    
    if(fsm_name != "all" & fsm_name != "all_no_fil"){
      iter_start_time <- Sys.time()
      if (var_embedding && use_pca){
        pca_variance_thresholds <- pca_transformation(x.train, y.train, x.test, y.test, classes)[[5]]
        embedding_size <- pca_variance_thresholds[["0.75"]]
      } else if (var_embedding) {
        embedding_size <- dim(x.train)[1] - 1
      }
      fsm_output <- fsm(x.train, y.train, x.test, y.test, classes, p_value_threshold = p_value_threshold,
                        adjust_method = adjust_method, variance_threshold = variance_threshold,
                        embedding_size = embedding_size, imp = imp, attr_num = attr_num, perc_attr = perc_attr)
      iter_end_time <- Sys.time()
      print(iter_end_time - iter_start_time)
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
    
    results <- run_all_models(x.train, y.train, x.test, y.test, classes = classes,
                              classifier_feature_imp = classifier_feature_imp)
    #results eg :
    # [["modelname", [acc, auc, aucpr, tpr, tnr, ppv, npv, f1_score], [acc.train, auc.train, aucpr.train, tpr.train, tnr.train, ppv.train, npv.train, f1_score.train]]
    #  ["SVM", [0.95, 0.89, 0.65, 0.9, 0.7, 0.8, 0.85, 0.78], [0.97, 0.89, 0.68, 0.89, 0.75, 0.81, 0.84, 0.79]]
    # ]
    
    #all_results eg :
    # $lr
        # $lr[[1]]
        # c(0.95, 0.96, 0.85, 0.89, 0.7, 0.8, 0.85, 0.88)
        # $lr[[2]]
        # c(0.89, 0.9, 0.84, 0.91, 0.75, 0.9, 0.95, 0.78)
        # $lr[[3]]
        # c(0.9, 0.85, 0.96, 0.9, 0.7, 0.8, 0.88, 0.9)
        # $lr[[4]]
        # c(0.7, 0.65, 0.6, 0.9, 0.8, 0.8, 0.95, 0.78)
    # $svm
        # $svm[[1]]
        # c(0.97, 0.96, 0.85, 0.9, 0.7, 0.8, 0.75, 0.78)
        # $svm[[2]]
        # c(0.94, 0.9, 0.84, 0.79, 0.9, 0.9, 0.95, 0.9)
        # $svm[[3]]
        # c(0.93, 0.9, 0.88, 0.92, 0.9, 0.8, 0.85, 0.8)
        # $svm[[4]]
        # c(0.9, 0.85, 0.9, 0.92, 0.7, 0.9, 0.95, 0.89)
    
    if (sample.count == 1) {
      all_results <- list()
      all_results.train <- list()
      for(result in results){
        model_name <- result[[1]] 
        all_results[[model_name]] <- list(c(), c(), c(), c(),
                                          c(), c(), c(), c())
        all_results.train[[model_name]] <- list(c(), c(), c(), c(),
                                                c(), c(), c(), c())
      }
      feature_imp_df <- data.frame(matrix(nrow = 0, ncol = 4))
    }
    for(result in results){
      model_name <- result[[1]]
      #currently 8 metrics sent. Including each of those with the loop below
      for(metric_count in c(1:8)){
        all_results[[model_name]][[metric_count]][sample.count] <- result[[2]][metric_count]
        all_results.train[[model_name]][[metric_count]][sample.count] <- result[[3]][metric_count]
      }
    }    
    
    if(classifier_feature_imp){
      #feature importance returned only by rf model - 7th model, as 4th element in result
      feature_imp <- results[[7]][[4]]
      feature_imp_df_per_iter <- cbind(FSM = fsm_name,
                               Iter = sample.count,
                               feature_imp)
      feature_imp_df <- rbind(feature_imp_df,
                              feature_imp_df_per_iter)
    }
    
  }  

  end_time <- Sys.time()
  print(end_time - start_time)

  if(!transformation){
    features_df <- cbind(FSM = fsm_name, as.data.frame(features_matrix))
  } else {
    features_df <- data.frame()
  }

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

  
  all_fsm_model_df <- get_all_fsm_model_df(all_results, fsm_name)
  all_fsm_model_df.train <- get_all_fsm_model_df(all_results.train, fsm_name)

  return (list(fsm_df, all_fsm_model_df, all_fsm_model_df.train, 
               features_df, feature_imp_df))
}


get_all_fsm_model_df <- function(all_results, fsm_name){
  all_fsm_model_df <- data.frame()
  for(model in names(all_results)){
    acc_list <- all_results[[model]][[1]]
    auc_list <- all_results[[model]][[2]]
    aucpr_list <- all_results[[model]][[3]]
    tpr_list <- all_results[[model]][[4]]
    tnr_list <- all_results[[model]][[5]]
    ppv_list <- all_results[[model]][[6]]
    npv_list <- all_results[[model]][[7]]
    f1_list <- all_results[[model]][[8]]
    
    fsm_model_df <- data.frame(FSM = fsm_name, Model = model)
    fsm_model_df <- cbind(fsm_model_df, 
                          compute_mean_and_ci(acc_list, 'Accuracy'), 
                          compute_mean_and_ci(auc_list, 'AUC'),
                          compute_mean_and_ci(aucpr_list, 'AUCPR'),
                          compute_mean_and_ci(tpr_list, 'TPR'),
                          compute_mean_and_ci(tnr_list, 'TNR'),
                          compute_mean_and_ci(ppv_list, 'PPV'),
                          compute_mean_and_ci(npv_list, 'NPV'),
                          compute_mean_and_ci(f1_list, 'F1'))
    all_fsm_model_df <- rbind(all_fsm_model_df, fsm_model_df)
  }
  return (all_fsm_model_df)
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
  } else if(length(metric_list) == 1){
    print('Warning : Not enough observations for t.test')
    metric_mean = metric_ci_lower = metric_ci_upper = metric_list[1]
  } else {
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