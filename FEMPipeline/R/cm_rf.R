# library(randomForest)
# source("R/metrics/compute_metrics.R")

rf_model <- function(x.train, y.train, x.test, y.test, classes, 
                     random_seed = 1000, classifier_feature_imp = FALSE, ...){
  model_name <- "Random Forest"
  #setting default value for metrics, to handle case where unable to train / execute classification model
  metrics.test <- c(0, 0, 0, 0, 0, 0, 0, 0)
  metrics.train <- c(0, 0, 0, 0, 0, 0, 0, 0)
  samplewise_result_df <- data.frame(matrix(ncol = 5, 
                                 dimnames = list(c(), 
                                                 c('Sample', 'TrueLabel', 'PredProb', 
                                                   'PredictedLabel', 'Type'))))
  
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

      pred_prob.train <- predict(model, x.train, type="prob")
      pred_prob.train <- data.frame(pred_prob.train)[classes[2]]
      pred.train <- ifelse(pred_prob.train > 0.5, classes[2], classes[1])
      metrics.train <- compute_metrics(pred = pred.train, pred_prob = pred_prob.train, true_label = y.train$Label, classes = classes)      
      
      pred_prob.test <- predict(model, x.test, type="prob")
      pred_prob.test <- data.frame(pred_prob.test)[classes[2]]
      pred.test <- ifelse(pred_prob.test > 0.5, classes[2], classes[1])
      metrics.test <- compute_metrics(pred = pred.test, pred_prob = pred_prob.test, true_label = y.test$Label, classes = classes)
      
      pred_prob.train <- predict(model, data.train, type = "prob")
      pred_prob.train <- data.frame(pred_prob.train)[classes[2]]
      pred.train <- ifelse(pred_prob.train > best_cut_off, classes[2], classes[1])
      
      pred_prob <- predict(model, data.test, type="prob")
      pred_prob <- data.frame(pred_prob)[classes[2]]
      pred <- ifelse(pred_prob > best_cut_off, classes[2], classes[1])
      
      samplewise_result_df.train <- data.frame("TrueLabel" = y.train$Label,
                                    "PredProb" = pred_prob.train[,1],
                                    "PredictedLabel" = pred.train[,1],
                                    "Type" = "train")
      
      samplewise_result_df.test <- data.frame("TrueLabel" = y.test$Label,
                                   "PredProb" = pred_prob.test[,1],
                                   "PredictedLabel" = pred.test[,1],
                                   "Type" = "test")
      
      samplewise_result_df <- rbind(cbind(Sample = row.names(samplewise_result_df.train), 
                                          samplewise_result_df.train),
                                    cbind(Sample = row.names(samplewise_result_df.test), 
                                          samplewise_result_df.test))
      
      samplewise_result_df <- samplewise_result_df %>%
        mutate(PredProb = as.double(PredProb))
    } else{
      print("data to RF : all fields constant!")
      print(dim(x.train))
    }
    
  })
  
  return (list(model_name, metrics.test, metrics.train, 
               samplewise_result_df, feature_imp))
}