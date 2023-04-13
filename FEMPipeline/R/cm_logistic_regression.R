# library(glmnet)
# source("R/metrics/compute_metrics.R")

logistic_regression <- function(x.train, y.train, x.test, y.test, classes, regularize = NA, ...){
  
  model_name <- "logistic regression"
  if (is.na(regularize)) {
    model_name <- paste("Simple", model_name)
  }
  else if(regularize == "el") {
    model_name <- paste("Elastic net", model_name)
  }
  else if(regularize == 'l1') {
    model_name <- paste("L1 Regularized", model_name)
  }
  else {
    model_name <- paste("L2 Regularized", model_name)
  }

  #setting default value for metrics, to handle case where unable to train / execute classification model
  metrics.test <- c(0, 0, 0, 0, 0, 0, 0, 0)
  metrics.train <- c(0, 0, 0, 0, 0, 0, 0, 0)
  samplewise_result_df <- data.frame(matrix(ncol = 5, 
                    dimnames = list(c(), 
                                    c('sample', 'TrueLabel', 'PredProb', 
                                      'PredictedLabel', 'Type'))))
  
  try({
    y.train$Label <- ifelse(y.train$Label == classes[1], 0, 1)
    y.test$Label <- ifelse(y.test$Label == classes[1], 0, 1)
    
    if (!is.na(regularize)) {
      #alpha = 1 => l1 regularization (lasso)
      #alpha = 0 => l2 regularization (ridge)
      #alpha = 0.5 => elastic net regularization (combination of lasso and ridge)
      if(regularize == "el"){
        alpha <- 0.5
      }
      else if(regularize == 'l1') {
        alpha <- 1
      }
      else {
        alpha <- 0
      }

      model <- glmnet::cv.glmnet(as.matrix(x.train), y.train$Label, alpha = alpha, family = 'binomial', type.measure = 'mse')
      # plot(model)
      
      lambda_min <- model$lambda.min
      lambda_1se <- model$lambda.1se
      
      pred_prob.train <- predict(model, newx = as.matrix(x.train), s = lambda_1se, type = 'response')
      pred.train <- ifelse(pred_prob.train > 0.5, 1, 0)
      
      pred_prob.test <- predict(model, newx = as.matrix(x.test), s = lambda_1se, type = 'response')
      pred.test <- ifelse(pred_prob.test > 0.5, 1, 0)
    }
    else {
      model <- glm(y.train$Label ~., data = x.train, family = binomial)
      
      pred_prob.train <- predict(model, newdata = x.train, type = 'response')
      pred.train <- ifelse(pred_prob.train > 0.5, 1, 0)
      
      pred_prob.test <- predict(model, newdata = x.test, type = 'response')
      pred.test <- ifelse(pred_prob.test > 0.5, 1, 0)
    }
    metrics.test <- compute_metrics(pred = pred.test, pred_prob = pred_prob.test, true_label = y.test$Label, classes = c(0, 1))
    metrics.train <- compute_metrics(pred = pred.train, pred_prob = pred_prob.train, true_label = y.train$Label, classes = c(0, 1))
  
    samplewise_result_df.train <- data.frame("TrueLabel" = ifelse(y.train$Label == 0, classes[1], classes[2]),
                                  "PredProb" = pred_prob.train,
                                  "PredictedLabel" = pred.train,
                                  "Type" = "train")
    
    samplewise_result_df.test <- data.frame("TrueLabel" = ifelse(y.test$Label == 0, classes[1], classes[2]),
                                 "PredProb" = pred_prob.test,
                                 "PredictedLabel" = pred.test,
                                 "Type" = "test")
    
    samplewise_result_df <- rbind(samplewise_result_df.train %>%
                         rownames_to_column("Sample"), 
                       samplewise_result_df.test %>%
                         rownames_to_column("Sample"))
    
    samplewise_result_df <- samplewise_result_df %>%
      mutate(PredProb = as.double(PredProb)) %>%
      mutate(PredictedLabel = ifelse(PredictedLabel == 0, classes[1], classes[2]))  
      
  })
  
  return (list(model_name, 
               metrics.test,
               metrics.train, 
               samplewise_result_df))    
}


