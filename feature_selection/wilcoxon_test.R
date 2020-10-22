library(dplyr)

wilcoxon_test_features <- function(x.train, y.train, x.test, y.test, classes, p_value_threshold = 0.05){
  #expects y to have column 'Label' containing the class for that sample
  
  wtest_result <- c()
  #obtain wilcoxon-test p-value for each transcript
  for (i in 1:ncol(x.train)) {
    wtest_result[i] <- wilcox.test(x = x.train[y.train$Label == classes[1], i],
                                   y = x.train[y.train$Label == classes[2], i])$p.value
  }
  wtest_df <- data.frame(wtest_result)
  row.names(wtest_df) <- colnames(x.train)
  
  wtest_df <- wtest_df %>% filter(wtest_result <= p_value_threshold)
  features <- row.names(wtest_df)
  
  x.train <- x.train[, features]
  x.test <- x.test[, features]
  
  return (list(x.train, y.train, x.test, y.test, c()))
}
