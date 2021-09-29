perform_filter <- function(x.train, y.train, x.test, y.test){
  keep <- edgeR::filterByExpr(x.train, group = y.train$Label)
  x.train <- x.train[keep, ]
  x.test <- x.test[keep, ]  
  return (list(x.train, y.train, x.test, y.test))
}