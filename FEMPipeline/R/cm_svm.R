#library(e1071)
# source("R/metrics/compute_metrics.R")

svm_model <- function(x.train, y.train, x.test, y.test, classes, kernel = "sigmoid", ...){

  kernel_name <- paste(toupper(substring(kernel, 1, 1)), substring(kernel, 2), sep = "")
  model_name <- paste(kernel_name, "Kernel SVM")
  #setting default value for metrics, to handle case where unable to train / execute classification model
  metrics.test <- c(0, 0, 0, 0, 0, 0, 0, 0)
  metrics.train <- c(0, 0, 0, 0, 0, 0, 0, 0)
  samplewise_result_df <- data.frame(matrix(ncol = 5, 
                                 dimnames = list(c(), 
                                                 c('Sample', 'TrueLabel', 'PredProb', 
                                                   'PredictedLabel', 'Type'))))
  
  try({
    model <- e1071::svm(x.train, factor(y.train$Label, levels = classes), probability = TRUE, kernel = kernel)

    pred.train <- predict(model, x.train, probability = TRUE)
    pred_prob.train <- data.frame(attr(pred.train, 'probabilities'))[classes[2]]
    metrics.train <- compute_metrics(pred = pred.train, pred_prob = pred_prob.train, true_label = y.train$Label, classes = classes)    
        
    pred.test <- predict(model, x.test, probability = TRUE)
    pred_prob.test <- data.frame(attr(pred.test, 'probabilities'))[classes[2]]
    metrics.test <- compute_metrics(pred = pred.test, pred_prob = pred_prob.test, true_label = y.test$Label, classes = classes)    
  
  
    samplewise_result_df.train <- data.frame("TrueLabel" = y.train$Label,
                                  "PredProb" = pred_prob.train[,1],
                                  "PredictedLabel" = pred.train,
                                  "Type" = "train")
    
    samplewise_result_df.test <- data.frame("TrueLabel" = y.test$Label,
                                 "PredProb" = pred_prob.test[,1],
                                 "PredictedLabel" = pred.test,
                                 "Type" = "test")
    
    samplewise_result_df <- rbind(cbind(Sample = row.names(samplewise_result_df.train), 
                                        samplewise_result_df.train),
                                  cbind(Sample = row.names(samplewise_result_df.test), 
                                        samplewise_result_df.test))
    
    samplewise_result_df <- samplewise_result_df %>%
      dplyr::mutate(PredProb = as.double(PredProb))
      
  })
  
  return (list(model_name, 
               metrics.test,
               metrics.train,
               samplewise_result_df))

}