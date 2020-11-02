library(e1071)
source("metrics/compute_metrics.R")

svm_model <- function(x.train, y.train, x.test, y.test, classes, kernel = "sigmoid", ...){

  kernel_name <- paste(toupper(substring(kernel, 1, 1)), substring(kernel, 2), sep = "")
  model_name <- paste(kernel_name, "Kernel SVM")
  
  model <- svm(x.train, factor(y.train$Label, levels = classes, ordered = TRUE), probability = TRUE, kernel = kernel)
  
  pred <- predict(model, x.test, probability = TRUE)
  pred_prob <- data.frame(attr(pred, 'probabilities'))[classes[2]]
  
  return (
    list(model_name,
      compute_metrics(pred = pred, pred_prob = pred_prob, true_label = y.test$Label, classes = classes)
    )
  )  
}