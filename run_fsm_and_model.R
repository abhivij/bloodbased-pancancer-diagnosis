library(caret)

show_results <- function(metric_list, metric_name){
  # qqnorm(metric_list)
  # qqline(metric_list)
  
  result <- t.test(metric_list)
  print(metric_name)
  print(paste('Mean : ', round(mean(metric_list), 4)))
  print(paste('95 CI :', round(result$conf.int[1], 4), round(result$conf.int[2], 4)))  
}


run_fsm_and_model <- function(x, output_labels, classes, fsm = NA, model,
                              random_seed = 1000, train_ratio = 0.8, sample.total = 30, regularize = FALSE){
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
      features <- fsm(classes, x.train, y.train)
      features_count[sample.count] <- length(features)
    }
    else{
      features <- c()
    }
    
    result <- model(x.train, y.train, x.test, y.test, classes, features = features, regularize = regularize)
    
    acc_list[sample.count] <- result[1]
    auc_list[sample.count] <- result[2]
  }  
  
  if(!is.na(fsm)){
    show_results(features_count, 'Number of features')
  }
  
  show_results(acc_list, 'Accuracy')
  show_results(auc_list, 'AUC')
}