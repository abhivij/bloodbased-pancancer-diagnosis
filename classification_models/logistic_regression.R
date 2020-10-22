library(glmnet)
source("metrics/compute_metrics.R")

logistic_regression <- function(x.train, y.train, x.test, y.test, classes, regularize = FALSE, ...){
  
  y.train$Label <- ifelse(y.train$Label == classes[1], 0, 1)
  y.test$Label <- ifelse(y.test$Label == classes[1], 0, 1)
  
  if (regularize) {
    #alpha = 0 => l2 regularization (ridge)
    model <- cv.glmnet(as.matrix(x.train), y.train$Label, alpha = 0, family = 'binomial', type.measure = 'mse')
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
  return (metrics)
}


