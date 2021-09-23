# library(randomForest)
# source("R/metrics/compute_metrics.R")

rf_model <- function(x.train, y.train, x.test, y.test, classes, random_seed = 1000, ...){
  model_name <- "Random Forest"
  #setting default value for metrics, to handle case where unable to train / execute classification model
  metrics <- c(0, 0)   
  
  try({
    set.seed(random_seed)
    
    model <- randomForest::randomForest(x = x.train, y = factor(y.train$Label, levels = classes))
    
    pred_prob <- predict(model, x.test, type="prob")
    pred_prob <- data.frame(pred_prob)[classes[2]]
    pred <- ifelse(pred_prob > 0.5, classes[2], classes[1])
    
    metrics <- compute_metrics(pred = pred, pred_prob = pred_prob, true_label = y.test$Label, classes = classes)    
  })
  
  return (list(model_name, metrics))
}