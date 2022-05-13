#library(e1071)
# source("R/metrics/compute_metrics.R")

svm_model <- function(x.train, y.train, x.test, y.test, classes, kernel = "sigmoid", ...){

  kernel_name <- paste(toupper(substring(kernel, 1, 1)), substring(kernel, 2), sep = "")
  model_name <- paste(kernel_name, "Kernel SVM")
  #setting default value for metrics, to handle case where unable to train / execute classification model
  metrics.test <- c(0, 0, 0, 0, 0, 0, 0, 0)
  metrics.train <- c(0, 0, 0, 0, 0, 0, 0, 0)
  
  try({
    model <- e1071::svm(x.train, factor(y.train$Label, levels = classes), probability = TRUE, kernel = kernel)

    pred.train <- predict(model, x.train, probability = TRUE)
    pred_prob.train <- data.frame(attr(pred.train, 'probabilities'))[classes[2]]
    metrics.train <- compute_metrics(pred = pred.train, pred_prob = pred_prob.train, true_label = y.train$Label, classes = classes)    
        
    pred.test <- predict(model, x.test, probability = TRUE)
    pred_prob.test <- data.frame(attr(pred.test, 'probabilities'))[classes[2]]
    metrics.test <- compute_metrics(pred = pred.test, pred_prob = pred_prob.test, true_label = y.test$Label, classes = classes)    
  })
  
  return (list(model_name, 
               metrics.test,
               metrics.train))

}