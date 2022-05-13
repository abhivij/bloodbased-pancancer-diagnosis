# library(ROCR)
# library(caret)

compute_metrics <- function(pred, pred_prob, true_label, classes){
  acc <- mean(pred == true_label)
  
  pr <- ROCR::prediction(pred_prob, true_label, label.ordering = classes)
  
  #compute ROC curve, and AUC  
  # prf <- ROCR::performance(pr, measure = "tpr", x.measure = "fpr")
  # plot(prf)
  
  auc <- ROCR::performance(pr, measure = "auc")@y.values[[1]]
  aucpr <- ROCR::performance(pr, measure = "aucpr")@y.values[[1]]
  
  #note : ROCR while computing non-area metrics, (i.e. those that are dependent on probability cutoffs),
  #     gives a range of values for different thresholds
  #     so using caret to compute such metrics
  # ?ROCR::performance
  # ROCR::performance(pr, measure = "f")@y.values[[1]]
  
  caret::confusionMatrix(factor(pred), factor(true_label), positive = as.character(classes[2]))
  caret::confusionMatrix(factor(pred), factor(true_label), positive = as.character(classes[2]),
                         mode = "prec_recall")
  
  caret::confusionMatrix(factor(pred), factor(true_label),
                         mode = "prec_recall")

  tpr <- caret::sensitivity(factor(pred), factor(true_label), positive = classes[2])
  tnr <- caret::specificity(factor(pred), factor(true_label), negative = classes[1])

  ppv <- caret::posPredValue(factor(pred), factor(true_label), positive = classes[2])
  npv <- caret::negPredValue(factor(pred), factor(true_label), negative = classes[1])
  
  caret::F_meas(data = factor(pred), reference = factor(true_label), relevant = as.character(classes[2]))
  
  result_set_for_caret <- data.frame(
    #caret requires class1 to be positive and class2 negative
    #classes argument in this compute_metrics function contains c(negative_class, positive_class)
    "obs" = factor(dplyr::case_when(true_label == classes[2] ~ "Class1",
                      true_label == classes[1] ~ "Class2")),
    "Class1" = pred_prob,
    "Class2" = 1-pred_prob,
    "pred" = factor(dplyr::case_when(pred == classes[2] ~ "Class1",
                       pred == classes[1] ~ "Class2"))
  )
  colnames(result_set_for_caret) <- c("obs", "Class1", "Class2", "pred")
  caret::twoClassSummary(result_set_for_caret, lev = levels(result_set_for_caret$obs))
  caret::prSummary(result_set_for_caret, lev = levels(result_set_for_caret$obs))
  
  return (c(acc, auc, tpr, tnr))
}