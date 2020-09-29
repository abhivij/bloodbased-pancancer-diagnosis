library(randomForest)
source("metrics/compute_acc_and_auc.R")

rf_model <- function(x.train, y.train, x.test, y.test, classes, features = c()){
  if(length(features) > 0) {
    x.train <- x.train[, features]
    x.test <- x.test[, features]
  }
  
  model <- randomForest(x = x.train, y = y.train$Label)
  
  pred_prob <- predict(model, x.test, type="prob")[, classes[1]]
  pred <- ifelse(pred_prob > 0.5, classes[1], classes[2])
  # print(pred_prob)
  # print(pred)
  # print(y.test$Label)
  
  return (compute_acc_and_auc(pred = pred, pred_prob = pred_prob, true_label = y.test$Label))
}