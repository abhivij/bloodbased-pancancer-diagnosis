library(glmnet)
library(ROCR)

logistic_regression <- function(x.train, y.train, x.test, y.test, classes, features = NA){
  if(! is.na(features)) {
    print("filtering features")
  }
  
  start <- Sys.time()
  x.train$Label <- ifelse(y.train$Label == classes[1], 1, 0)
  x.test$Label <- ifelse(y.test$Label == classes[1], 1, 0)
  
  model_matrix.train <- model.matrix(Label ~., x.train)[, -1]
  
  #alpha = 0 => l2 regularization (ridge)
  cv.out <- cv.glmnet(model_matrix.train, x.train$Label, alpha = 0, family = 'binomial', type.measure = 'mse')
  
  plot(cv.out)
  
  print(paste("Time Taken : ", Sys.time() - start))
  
  lambda_min <- cv.out$lambda.min
  lambda_1se <- cv.out$lambda.1se
  
  model_matrix.test <- model.matrix(Label ~., x.test)[, -1] 
  
  l2_prob <- predict(cv.out, newx = model_matrix.test, s = lambda_1se, type = 'response')
  l2_labels <- ifelse(l2_prob > 0.5, 1, 0)
  
  acc <- mean(l2_labels == x.test$Label)
  print(paste('Accuracy : ', acc))
  
  coef(cv.out, cv.out$lambda.1se)

  
  #compute ROC curve, and AUC  
  pr <- prediction(l2_prob, x.test$Label)
  prf <- performance(pr, measure = "tpr", x.measure = "fpr")
  plot(prf)
  
  auc <- performance(pr, measure = "auc")
  auc <- auc@y.values[[1]]
  print(paste('AUC : ', auc))  
}


