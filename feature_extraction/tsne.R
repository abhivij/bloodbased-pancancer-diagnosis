library(Rtsne)

tsne_transformation <- function(x.train, y.train, x.test, y.test, classes, random_seed = 1000){
  set.seed(rrandom_seed)
  
  tsne_result <- Rtsne(x.train, dim=2)
  
  #note cant apply tsne result on test data
  # https://stackoverflow.com/questions/43377941/t-sne-predictions-in-r
  return (list(x.train, y.train, x.test, y.test, c()))  
}  