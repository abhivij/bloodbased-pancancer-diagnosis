library(glmnet)
source("metrics/compute_metrics.R")

logistic_regression <- function(x.train, y.train, x.test, y.test, classes, regularize = NA, ...){
  
  model_name <- "logistic regression"
  if (is.na(regularize)) {
    model_name <- paste("Simple", model_name)
  }
  else if(regularize == 'l1') {
    model_name <- paste("L1 Regularized", model_name)
  }
  else {
    model_name <- paste("L2 Regularized", model_name)
  }

  #setting default value for metrics, to handle case where unable to train / execute classification model
  metrics <- c(0, 0) 
  
  try({
    y.train$Label <- ifelse(y.train$Label == classes[1], 0, 1)
    y.test$Label <- ifelse(y.test$Label == classes[1], 0, 1)
    
    if (!is.na(regularize)) {
      #alpha = 1 => l1 regularization (lasso)
      #alpha = 0 => l2 regularization (ridge)
      if(regularize == 'l1') {
        alpha <- 1
      }
      else {
        alpha <- 0
      }

      model <- cv.glmnet(as.matrix(x.train), y.train$Label, alpha = alpha, family = 'binomial', type.measure = 'mse')
      # plot(model)
      
      lambda_min <- model$lambda.min
      lambda_1se <- model$lambda.1se
      
      pred_prob <- predict(model, newx = as.matrix(x.test), s = lambda_1se, type = 'response')
      pred <- ifelse(pred_prob > 0.5, 1, 0)
    }
    else {
      model <- glm(y.train$Label ~., data = x.train, family = binomial)
      pred_prob <- predict(model, newdata = x.test, type = 'response')
      pred <- ifelse(pred_prob > 0.5, 1, 0)
    }
    metrics <- compute_metrics(pred = pred, pred_prob = pred_prob, true_label = y.test$Label, classes = c(0, 1))  
  })
  
  return (list(model_name, metrics))    
}


