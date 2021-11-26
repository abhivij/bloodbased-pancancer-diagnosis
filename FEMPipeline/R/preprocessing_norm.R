#   x.train, x.test format : (transcripts x samples)
#   y.train, y.test format : (2 columns : Sample, Label)
perform_norm <- function(norm, x.train, y.train, x.test, y.test){
  if(length(norm) == 5){
    norm = "norm_log_cpm"
  }
  
  if(norm == "norm_log_cpm"){
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
  } else if(norm == "quantile"){
    norm_data <- preprocessCore::normalize.quantiles(as.matrix(x.train))
    norm_data <- data.frame(norm_data, row.names = rownames(x.train))
    colnames(norm_data) <- colnames(x.train)
    x.train <- norm_data
    
    norm_data <- preprocessCore::normalize.quantiles(as.matrix(x.test))
    norm_data <- data.frame(norm_data, row.names = rownames(x.test))
    colnames(norm_data) <- colnames(x.test)
    x.test <- norm_data
    
    x.train <- as.data.frame(t(as.matrix(x.train)))
    x.test <- as.data.frame(t(as.matrix(x.test)))
  } else if(norm == "norm_quantile"){
    norm_data <- preprocessCore::normalize.quantiles(as.matrix(x.train))
    norm_data <- data.frame(norm_data, row.names = rownames(x.train))
    colnames(norm_data) <- colnames(x.train)
    x.train <- norm_data
    
    norm_data <- preprocessCore::normalize.quantiles(as.matrix(x.test))
    norm_data <- data.frame(norm_data, row.names = rownames(x.test))
    colnames(norm_data) <- colnames(x.test)
    x.test <- norm_data 
    
    x.train <- as.data.frame(t(as.matrix(x.train)))
    x.test <- as.data.frame(t(as.matrix(x.test)))  
    
    #normalizing the data
    normparam <- caret::preProcess(x.train) 
    x.train <- predict(normparam, x.train)
    x.test <- predict(normparam, x.test) #normalizing test data using params from train data

  } else if(norm == "vsn"){
    fit = vsn::vsn2(as.matrix(x.train))
    x.train.norm = vsn::predict(fit, as.matrix(x.train))

    fit = vsn::vsn2(as.matrix(x.test))
    x.test.norm = vsn::predict(fit, as.matrix(x.test))

    x.train <- as.data.frame(t(x.train.norm))
    x.test <- as.data.frame(t(x.test.norm))
  }

  
  return (list(x.train, y.train, x.test, y.test))
  
}