library(mRMRe)

mrmr_features <- function(x.train, y.train, x.test, y.test, classes, attr_num, ...){
  if (is.na(attr_num)) {
    attr_num <- 30
  }
  data.train <- mRMR.data(data = data.frame(
                                  target = factor(y.train$Label, levels = classes, ordered = TRUE),
                                  x.train))
  filter <- mRMR.classic(data = data.train, target_indices = c(1), feature_count = attr_num)
  
  features <- solutions(filter)[[1]] - 1
  
  x.train <- x.train[, features, drop = FALSE]
  x.test <- x.test[, features, drop = FALSE]
  
  return (list(x.train, y.train, x.test, y.test, c()))
}  