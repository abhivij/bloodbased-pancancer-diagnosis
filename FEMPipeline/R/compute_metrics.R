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
  
  
  caret::auc
  
  
  set.seed(144)
  true_class <- factor(sample(paste0("Class", 1:2), 
                              size = 1000,
                              prob = c(.2, .8), replace = TRUE))
  true_class <- sort(true_class)
  class1_probs <- rbeta(sum(true_class == "Class1"), 4, 1)
  class2_probs <- rbeta(sum(true_class == "Class2"), 1, 2.5)
  test_set <- data.frame(obs = true_class,
                         Class1 = c(class1_probs, class2_probs))
  test_set$Class2 <- 1 - test_set$Class1
  test_set$pred <- factor(ifelse(test_set$Class1 >= .5, "Class1", "Class2"))
  
  caret::twoClassSummary(test_set, lev = levels(test_set$obs))
  caret::prSummary(test_set, lev = levels(test_set$obs))
  
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
  
  return (c(acc, auc, tpr, tnr))
}