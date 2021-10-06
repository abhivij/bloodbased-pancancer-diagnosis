# library(caret)
# library(mRMRe)

mrmr_plsda_transformation <- function(x.train, y.train, x.test, y.test, classes, embedding_size, attr_num, ...){
  if (is.na(embedding_size)) {
    embedding_size <- 5
  }
  if (is.na(attr_num)) {
    attr_num <- 50
  }
  data.train <- mRMRe::mRMR.data(data = data.frame(
                                target = factor(y.train$Label, levels = classes, ordered = TRUE),
                                x.train))
  filter <- mRMRe::mRMR.classic(data = data.train, target_indices = c(1), feature_count = attr_num)
  
  features <- mRMRe::solutions(filter)[[1]] - 1
  
  x.train <- x.train[, features, drop = FALSE]
  x.test <- x.test[, features, drop = FALSE]
  
  
  plsda_transform <- caret::plsda(x.train, factor(y.train$Label), ncomp = embedding_size)
  
  x.train <- as.data.frame(as.matrix(x.train) %*% plsda_transform$projection) 
  x.test <- as.data.frame(as.matrix(x.test) %*% plsda_transform$projection) 
  
  return (list(x.train, y.train, x.test, y.test, c()))
}