library(reticulate)
source_python('psd.py')

fft_transformation <- function(x.train, y.train, x.test, y.test, classes, random_seed = 1000, ...){
  
  train_size <- dim(x.train)[1]
  data <- rbind(x.train, x.test)
  full_data_size <- dim(data)[1]
  
  data <- as.data.frame(psd(data))
  x.train <- data[1:train_size,]
  x.test <- data[(train_size+1):full_data_size,]
  
  # fft_result <- x.train
  # for(i in c(1 : dim(x.train)[2])) {
  #   fft_result[, i] <- abs(fft(x.train[, i]))
  # }
  
  
  return (list(x.train, y.train, x.test, y.test, c()))  
}  