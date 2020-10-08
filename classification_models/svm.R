library(e1071)
source("metrics/compute_metrics.R")

svm_model <- function(x.train, y.train, x.test, y.test, features = c(), kernel = "sigmoid", ...){
  if(length(features) > 0) {
    x.train <- x.train[, features]
    x.test <- x.test[, features]
  }

  model <- svm(x.train, y.train$Label, probability = TRUE, kernel = kernel)
  # print(summary(model))
  
  pred <- predict(model, x.test, probability = TRUE)
  pred_prob <- attr(pred, 'probabilities')[,1]
  
  return (compute_metrics(pred = pred, pred_prob = pred_prob, true_label = y.test$Label))
}