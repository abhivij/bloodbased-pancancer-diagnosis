# library(ROCR)
# library(caret)

compute_metrics <- function(pred, pred_prob, true_label, classes){
  
  #default values to handle failure of metric computation
  acc <- 0
  auc <- 0
  aucpr <- 0
  tpr <- 0
  tnr <- 0
  ppv <- 0
  npv <- 0
  f1_score <- 0
  
  acc <- mean(pred == true_label)
  
  try({
    pr <- ROCR::prediction(pred_prob, true_label, label.ordering = classes)
    
    #compute ROC curve, and AUC  
    # prf <- ROCR::performance(pr, measure = "tpr", x.measure = "fpr")
    # plot(prf)
    
    auc <- ROCR::performance(pr, measure = "auc")@y.values[[1]]
    aucpr <- ROCR::performance(pr, measure = "aucpr")@y.values[[1]]    
  })

  
  #note : ROCR while computing non-area metrics, (i.e. those that are dependent on probability cutoffs),
  #     gives a range of values for different thresholds
  #     so using caret to compute such metrics
  # ?ROCR::performance
  # ROCR::performance(pr, measure = "f")@y.values[[1]]
  try({
    tpr <- caret::sensitivity(factor(pred), factor(true_label), positive = classes[2])
  })
  try({
    tnr <- caret::specificity(factor(pred), factor(true_label), negative = classes[1])
  })  
  try({
    ppv <- caret::posPredValue(factor(pred), factor(true_label), positive = classes[2])
  })
  try({
    npv <- caret::negPredValue(factor(pred), factor(true_label), negative = classes[1])
  })
  try({
    f1_score <- caret::F_meas(data = factor(pred), reference = factor(true_label), relevant = as.character(classes[2]))    
  })  


  
  return (c(acc, auc, aucpr,
            tpr, tnr,
            ppv, npv,
            f1_score))
}