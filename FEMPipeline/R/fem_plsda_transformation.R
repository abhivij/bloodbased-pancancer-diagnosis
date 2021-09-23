# library(caret)

plsda_transformation <- function(x.train, y.train, x.test, y.test, classes, embedding_size, ...){
  if (is.na(embedding_size)) {
    embedding_size <- 2
  }
  
  plsda_transform <- caret::plsda(x.train, factor(y.train$Label), ncomp = embedding_size)
  
  x.train <- as.data.frame(as.matrix(x.train) %*% plsda_transform$projection) 
  x.test <- as.data.frame(as.matrix(x.test) %*% plsda_transform$projection) 
  
  return (list(x.train, y.train, x.test, y.test, c()))
}