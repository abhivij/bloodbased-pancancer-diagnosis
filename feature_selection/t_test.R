library(dplyr)

t_test_features <- function(x.train, y.train, x.test, y.test, classes, p_value_threshold = 0.05, adjust_method = NA, ...){
  #expects y to have column 'Label' containing the class for that sample
  
  ttest_result <- c()
  #obtain t-test p-value for each transcript
  for (i in 1:ncol(x.train)) {
    ttest_result[i] <- t.test(x = x.train[y.train$Label == classes[1], i],
                      y = x.train[y.train$Label == classes[2], i]
                      )$p.value
  }
  if(!is.na(adjust_method)){
    ttest_result <- p.adjust(ttest_result, method = adjust_method)
    p_value_threshold <- p_value_threshold * 2
  }
  ttest_df <- data.frame(ttest_result)
  row.names(ttest_df) <- colnames(x.train)
  
  ttest_df <- ttest_df %>% filter(ttest_result <= p_value_threshold)
  features <- row.names(ttest_df)

  x.train <- x.train[, features, drop = FALSE]
  x.test <- x.test[, features, drop = FALSE]
  
  return (list(x.train, y.train, x.test, y.test, c()))
}
