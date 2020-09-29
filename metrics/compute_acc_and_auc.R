library(ROCR)

compute_acc_and_auc <- function(pred, pred_prob, true_label){
  acc <- mean(pred == true_label)
  
  pr <- prediction(pred_prob, true_label)
  
  #compute ROC curve, and AUC  
  # prf <- performance(pr, measure = "tpr", x.measure = "fpr")
  # plot(prf)
  
  auc <- performance(pr, measure = "auc")
  auc <- auc@y.values[[1]]
  
  return (c(acc, auc))  
}