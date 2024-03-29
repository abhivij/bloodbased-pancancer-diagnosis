# library(phateR)

phate_transformation <- function(x.train, y.train, x.test, y.test, classes, random_seed = 1000, embedding_size, ...){
  if (is.na(embedding_size)) {
    embedding_size <- 2
  }
  
  set.seed(random_seed)
  phate_transform <- phateR::phate(x.train, ndim = embedding_size)
  x.train <- as.data.frame(phate_transform$embedding)
  
  x.test.transformed <- as.data.frame(phate_transform$operator$transform(as.matrix(x.test)))
  colnames(x.test.transformed) <- colnames(x.train)
  rownames(x.test.transformed) <- rownames(x.test)
  x.test <- x.test.transformed
  
  return (list(x.train, y.train, x.test, y.test, c()))
}