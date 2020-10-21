library(randomForest)
source("metrics/compute_metrics.R")

rf_model <- function(x.train, y.train, x.test, y.test, classes, features = NA, random_seed = 1000, ...){
  set.seed(random_seed)
  if(!is.na(features)) {
    x.train <- x.train[, features]
    x.test <- x.test[, features]
  }
  
  model <- randomForest(x = x.train, y = factor(y.train$Label, levels = classes, ordered = TRUE))
  
  pred_prob <- predict(model, x.test, type="prob")
  pred_prob <- data.frame(pred_prob)[classes[2]]
  pred <- ifelse(pred_prob > 0.5, classes[2], classes[1])
  
  return (compute_metrics(pred = pred, pred_prob = pred_prob, true_label = y.test$Label, classes = classes))
}