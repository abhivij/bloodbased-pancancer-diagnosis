library(kernlab)

kpca_transformation <- function(x.train, y.train, x.test, y.test, classes, embedding_size, ...){
  
  if (is.na(embedding_size)) {
    transform.kpca <- kpca(~., data = x.train)  
  }
  else {
    transform.kpca <- kpca(~., data = x.train, features = embedding_size)
  }
  
  
  x.train <- as.data.frame(rotated(transform.kpca))
  x.test <- as.data.frame(predict(transform.kpca, x.test))
  

  return (list(x.train, y.train, x.test, y.test, c()))
}
