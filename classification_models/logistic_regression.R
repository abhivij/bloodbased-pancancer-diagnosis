library(glmnet)
source("metrics/compute_metrics.R")

logistic_regression <- function(x.train, y.train, x.test, y.test, features = c(), regularize = FALSE, ...){
  
  if(length(features) > 0) {
    # print("filtering features")
    # print(dim(x.train))
    # print(dim(x.test))
    x.train <- x.train[, features]
    x.test <- x.test[, features]
    # print(dim(x.train))
    # print(dim(x.test))    
  }
  
  classes <- levels(y.train$Label)
  x.train$Label <- ifelse(y.train$Label == classes[1], 1, 0)
  x.test$Label <- ifelse(y.test$Label == classes[1], 1, 0)
  
  if (regularize) {
    start <- Sys.time()
    
    model_matrix.train <- model.matrix(Label ~., x.train)[, -1]
    
    #alpha = 0 => l2 regularization (ridge)
    cv.out <- cv.glmnet(model_matrix.train, x.train$Label, alpha = 0, family = 'binomial', type.measure = 'mse')
    
    # plot(cv.out)
    
    # print(paste("Time Taken : ", Sys.time() - start))
    
    lambda_min <- cv.out$lambda.min
    lambda_1se <- cv.out$lambda.1se
    
    model_matrix.test <- model.matrix(Label ~., x.test)[, -1] 
    
    pred_prob <- predict(cv.out, newx = model_matrix.test, s = lambda_1se, type = 'response')
    pred <- ifelse(pred_prob > 0.5, 1, 0)
    
    metrics <- compute_metrics(pred = pred, pred_prob = pred_prob, true_label = x.test$Label)
  }
  else {
    glm.fit <- glm(Label ~., data = x.train, family = binomial)
    glm.probs <- predict(glm.fit, newdata = x.test, type = "response")
    glm.labels <- ifelse(glm.probs > 0.5, 1, 0)

    metrics <- compute_metrics(pred = glm.labels, pred_prob = glm.probs, true_label = x.test$Label)    
  }

  return (metrics)
  
}


