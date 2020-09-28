library(dplyr)

t_test_features <- function(classes, x, y, p_value_threshold = 0.05){
  #expects y to have column 'Label' containing the class for that sample
  
  ttest_result <- c()
  #obtain t-test p-value for each transcript
  for (i in 1:ncol(x)) {
    ttest_result[i] <- t.test(x = x[y$Label == classes[1], i],
                              y = x[y$Label == classes[2], i])$p.value
  }
  ttest_df <- data.frame(ttest_result)
  row.names(ttest_df) <- colnames(x)
  
  ttest_df <- ttest_df %>% filter(ttest_result <= p_value_threshold)
  
  return (row.names(ttest_df))
}
