library(reticulate)
source_python('psd.py')

fft_transformation <- function(x.train, y.train, x.test, y.test, classes, random_seed = 1000, ...){
  
  x.train <- psd(x.train)
  x.test <- psd(x.test)
  # fft_result <- x.train
  # for(i in c(1 : dim(x.train)[2])) {
  #   fft_result[, i] <- abs(fft(x.train[, i]))
  # }
  
  
  return (list(x.train, y.train, x.test, y.test, c()))  
}  