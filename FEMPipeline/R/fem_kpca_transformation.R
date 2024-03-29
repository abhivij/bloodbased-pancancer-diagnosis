# library(kernlab)

kpca_transformation <- function(x.train, y.train, x.test, y.test, classes, embedding_size, ...){
  
  if (is.na(embedding_size)) {
    transform.kpca <- kernlab::kpca(~., data = x.train)  
  }
  else {
    transform.kpca <- kernlab::kpca(~., data = x.train, features = embedding_size)
  }
  
  
  x.train <- as.data.frame(kernlab::rotated(transform.kpca))
  x.test <- as.data.frame(kernlab::predict(transform.kpca, x.test))
  

  return (list(x.train, y.train, x.test, y.test, c()))
}
