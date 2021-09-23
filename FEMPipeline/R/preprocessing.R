# library(edgeR)
# library(caret)

filter_and_normalize <- function(x.train, y.train, x.test, y.test, filter = TRUE){
  
  x.train <- as.data.frame(t(as.matrix(x.train)))
  x.test <- as.data.frame(t(as.matrix(x.test)))
  
  if (filter) {
    keep <- edgeR::filterByExpr(x.train, group = y.train$Label)
    x.train <- x.train[keep, ]
    x.test <- x.test[keep, ]
  }
  
  #calculating norm log cpm
  x.train <- edgeR::cpm(x.train, log=TRUE)
  x.train <- scale(x.train)
  
  x.test <- edgeR::cpm(x.test, log=TRUE)
  x.test <- scale(x.test) #not using normalizing params from train data, since normalization is done for each sample here

  x.train <- as.data.frame(t(as.matrix(x.train)))
  x.test <- as.data.frame(t(as.matrix(x.test)))  

  #normalizing the data
  normparam <- caret::preProcess(x.train) 
  x.train <- predict(normparam, x.train)
  x.test <- predict(normparam, x.test) #normalizing test data using params from train data
  
  preprocessed_data_list <- list(x.train, y.train, x.test, y.test)
  return (preprocessed_data_list)
}

