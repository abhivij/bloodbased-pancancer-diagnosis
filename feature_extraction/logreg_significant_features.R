library(dplyr)
library(glmnet)

logreg_significant_features <- function(x.train, y.train, x.test, y.test, classes, p_value_threshold = 0.05, regularize = NA, ...){

    y.train$Label <- ifelse(y.train$Label == classes[1], 0, 1)
    y.test$Label <- ifelse(y.test$Label == classes[1], 0, 1)
    
    #alpha = 1 => l1 regularization (lasso)
    #alpha = 0 => l2 regularization (ridge)
    if (is.na(regularize)) {
      alpha <- 0 #default ridge
    }
    else if (regularize == 'l1') {
      alpha <- 1
    }
    else {
      alpha <- 0
    }
    
    model <- cv.glmnet(as.matrix(x.train), y.train$Label, alpha = alpha, family = 'binomial', type.measure = 'mse')
      
      lambda_min <- model$lambda.min
      lambda_1se <- model$lambda.1se
      
      pred_prob <- predict(model, newx = as.matrix(x.test), s = lambda_1se, type = 'response')
      pred <- ifelse(pred_prob > 0.5, 1, 0)



  
  # x.train <- x.train[, features, drop = FALSE]
  # x.test <- x.test[, features, drop = FALSE]
  
  return (list(x.train, y.train, x.test, y.test, c()))
}
