# library(umap)

umap_transformation <- function(x.train, y.train, x.test, y.test, classes, random_seed = 1000, embedding_size, ...){
  if (is.na(embedding_size)) {
    embedding_size <- 2
  }
  n <- 15
  if (dim(x.train)[1] < n) {
    n <- floor(dim(x.train)[1] / 2)
  }
  
  set.seed(random_seed)
  umap_transform = umap::umap(x.train, n_neighbors = n, n_components = embedding_size)

  x.train <- as.data.frame(umap_transform$layout)
  x.test <- as.data.frame(predict(umap_transform, x.test))
  
  return (list(x.train, y.train, x.test, y.test, c()))
}