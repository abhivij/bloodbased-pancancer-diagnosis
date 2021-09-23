# library(ROCR)
# library(caret)

compute_metrics <- function(pred, pred_prob, true_label, classes){
  acc <- mean(pred == true_label)
  
  pr <- ROCR::prediction(pred_prob, true_label, label.ordering = classes)
  
  #compute ROC curve, and AUC  
  # prf <- ROCR::performance(pr, measure = "tpr", x.measure = "fpr")
  # plot(prf)
  
  auc <- ROCR::performance(pr, measure = "auc")@y.values[[1]]

  tpr <- caret::sensitivity(factor(pred), factor(true_label), positive = classes[2])
  tnr <- caret::specificity(factor(pred), factor(true_label), negative = classes[1])

  return (c(acc, auc, tpr, tnr))
}