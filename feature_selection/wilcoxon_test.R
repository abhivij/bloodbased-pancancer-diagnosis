library(dplyr)

wilcoxon_test_features <- function(x, y, classes, p_value_threshold = 0.05){
  #expects y to have column 'Label' containing the class for that sample
  
  wtest_result <- c()
  #obtain wilcoxon-test p-value for each transcript
  for (i in 1:ncol(x)) {
    wtest_result[i] <- wilcox.test(x = x[y$Label == classes[1], i],
                              y = x[y$Label == classes[2], i])$p.value
  }
  wtest_df <- data.frame(wtest_result)
  row.names(wtest_df) <- colnames(x)
  
  wtest_df <- wtest_df %>% filter(wtest_result <= p_value_threshold)
  
  return (row.names(wtest_df))
}
