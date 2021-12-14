# library(randomForest)
# source("R/metrics/compute_metrics.R")

rf_model <- function(x.train, y.train, x.test, y.test, classes, 
                     random_seed = 1000, classifier_feature_imp = FALSE, ...){
  model_name <- "Random Forest"
  #setting default value for metrics, to handle case where unable to train / execute classification model
  metrics <- c(0, 0)   
  
  feature_imp <- data.frame(matrix(nrow = 0, ncol = 2,
                                   dimnames = list(NULL, c("feature", "meanDecreaseGini"))))
  
  try({
    set.seed(random_seed)
    if(sum(x.train - colMeans(x.train)) != 0){
      #ensure that atleast one column is not a constant vector
      #all columns constant causes the below line to run forever
      model <- randomForest::randomForest(x = x.train, y = factor(y.train$Label, levels = classes))

      if(classifier_feature_imp){
        feature_imp <- data.frame(randomForest::importance(model))
        feature_imp <- cbind(feature = rownames(feature_imp),
                             data.frame(feature_imp, row.names = NULL))
      }

      pred_prob <- predict(model, x.test, type="prob")
      pred_prob <- data.frame(pred_prob)[classes[2]]
      pred <- ifelse(pred_prob > 0.5, classes[2], classes[1])

      metrics <- compute_metrics(pred = pred, pred_prob = pred_prob, true_label = y.test$Label, classes = classes)
    } else{
      print("data to RF : all fields constant!")
      print(dim(x.train))
    }
    
  })
  
  return (list(model_name, metrics, feature_imp))
}