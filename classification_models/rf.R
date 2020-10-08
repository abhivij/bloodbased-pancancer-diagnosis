library(randomForest)
source("metrics/compute_metrics.R")

rf_model <- function(x.train, y.train, x.test, y.test, features = c(), random_seed = 1000, ...){
  set.seed(random_seed)
  if(length(features) > 0) {
    x.train <- x.train[, features]
    x.test <- x.test[, features]
  }
  classes <- levels(y.train$Label)
  
  model <- randomForest(x = x.train, y = y.train$Label)
  
  pred_prob <- predict(model, x.test, type="prob")
  pred_prob <- pred_prob[, 2]
  pred <- ifelse(pred_prob > 0.5, classes[2], classes[1])
  
  return (compute_metrics(pred = pred, pred_prob = pred_prob, true_label = y.test$Label))
}