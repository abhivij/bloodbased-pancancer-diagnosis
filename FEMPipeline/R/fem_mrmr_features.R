# library(mRMRe)

#attr_num : number of features to be selected by MRMR
#perc_attr : specify number of features to be selected by MRMR in terms of percentage of total number of features
#   perc_attr overrides value computed by attr_num

mrmr_features <- function(x.train, y.train, x.test, y.test, classes, attr_num, perc_attr, ...){
  if (is.na(attr_num)) {
    attr_num <- 30
  }
  
  if(!is.na(perc_attr)){
    attr_num <- round(dim(x.train)[2] * perc_attr / 100)
  }
  
  data.train <- mRMRe::mRMR.data(data = data.frame(
                                  target = factor(y.train$Label, levels = classes, ordered = TRUE),
                                  x.train))
  filter <- mRMRe::mRMR.classic(data = data.train, target_indices = c(1), feature_count = attr_num)
  
  features <- mRMRe::solutions(filter)[[1]] - 1
  
  x.train <- x.train[, features, drop = FALSE]
  x.test <- x.test[, features, drop = FALSE]
  
  return (list(x.train, y.train, x.test, y.test, c()))
}  