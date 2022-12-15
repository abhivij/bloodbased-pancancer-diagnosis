#   x.train, x.test format : (transcripts x samples)
#   y.train, y.test format : (2 columns : Sample, Label)
perform_norm <- function(norm, x.train, y.train, x.test, y.test){
  if(length(norm) == 11){
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
    
  } else if(norm == "norm_log_cpm_simple"){
    #calculating norm log cpm
    x.train <- edgeR::cpm(x.train, log=TRUE)
    
    x.test <- edgeR::cpm(x.test, log=TRUE)

    x.train <- as.data.frame(t(as.matrix(x.train)))
    x.test <- as.data.frame(t(as.matrix(x.test)))  
    
    #normalizing the data
    normparam <- caret::preProcess(x.train) 
    x.train <- predict(normparam, x.train)
    x.test <- predict(normparam, x.test) #normalizing test data using params from train data   
    
  } else if(norm == "log_cpm"){
    #calculating norm log cpm
    x.train <- edgeR::cpm(x.train, log=TRUE)
    
    x.test <- edgeR::cpm(x.test, log=TRUE)
    
    x.train <- as.data.frame(t(as.matrix(x.train)))
    x.test <- as.data.frame(t(as.matrix(x.test)))  

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

  } else if(norm == "quantile_train_param"){
    #adapted from https://davetang.org/muse/2014/07/07/quantile-normalisation-in-r/
    x.train.rank <- apply(x.train, 2, rank, ties.method="average")
    x.train.sorted <- data.frame(apply(x.train, 2, sort))
    x.train.mean <- apply(x.train.sorted, 1, mean)
    index_to_mean <- function(index, data_mean){
      #index can be int or int+0.5
      #if int+0.5, take average of the numbers in those positions
      int.result <- data_mean[index]
      index.int <- floor(index)
      #some of the values in point5.result might be NA
      #but they won't be chosen
      point5.result <- (data_mean[index.int] + data_mean[index.int+1])/2
      point5.indices <- index%%1 != 0
      result <- int.result
      result[point5.indices] <- point5.result[point5.indices]
      return (result)
    }
    x.train.norm <- apply(x.train.rank, 2, index_to_mean, data_mean = x.train.mean)
    rownames(x.train.norm) <- rownames(x.train)
    x.train <- x.train.norm
    
    x.test.rank <- apply(x.test, 2, rank, ties.method="average")
    #use params i.e. mean values of rows, from training data
    x.test.norm <- apply(x.test.rank, 2, index_to_mean, data_mean = x.train.mean)
    rownames(x.test.norm) <- rownames(x.test)
    x.test <- x.test.norm
    
    x.train <- as.data.frame(t(as.matrix(x.train)))
    x.test <- as.data.frame(t(as.matrix(x.test))) 
  }
  else if(norm == "vsn"){
    fit = vsn::vsn2(as.matrix(x.train))
    x.train.norm = vsn::predict(fit, as.matrix(x.train))

    fit = vsn::vsn2(as.matrix(x.test))
    x.test.norm = vsn::predict(fit, as.matrix(x.test))

    x.train <- as.data.frame(t(x.train.norm))
    x.test <- as.data.frame(t(x.test.norm))
    
  } else if(norm == "norm_log_tmm"){
    #calculating norm log tmm
    
    dge <- edgeR::DGEList(counts = x.train, group = y.train$Label)
    dge <- edgeR::calcNormFactors(dge, method = "TMM")
    tmm <- edgeR::cpm(dge, log = TRUE)
    x.train <- tmm
    
    dge <- edgeR::DGEList(counts = x.test, group = y.test$Label)
    dge <- edgeR::calcNormFactors(dge, method = "TMM")
    tmm <- edgeR::cpm(dge, log = TRUE)
    x.test <- tmm
    
    x.train <- as.data.frame(t(as.matrix(x.train)))
    x.test <- as.data.frame(t(as.matrix(x.test)))  
    
    #normalizing the data
    normparam <- caret::preProcess(x.train) 
    x.train <- predict(normparam, x.train)
    x.test <- predict(normparam, x.test) #normalizing test data using params from train data  
    
  } else if(norm == "log_tmm"){
    #calculating norm log tmm
    
    dge <- edgeR::DGEList(counts = x.train, group = y.train$Label)
    dge <- edgeR::calcNormFactors(dge, method = "TMM")
    tmm <- edgeR::cpm(dge, log = TRUE)
    x.train <- tmm
    
    dge <- edgeR::DGEList(counts = x.test, group = y.test$Label)
    dge <- edgeR::calcNormFactors(dge, method = "TMM")
    tmm <- edgeR::cpm(dge, log = TRUE)
    x.test <- tmm
    
    x.train <- as.data.frame(t(as.matrix(x.train)))
    x.test <- as.data.frame(t(as.matrix(x.test))) 
    
  } else if(norm == "log"){
    
    x.train[x.train == 0] <- 2^-30
    x.train <- log2(x.train)
    
    x.test[x.test == 0] <- 2^-30
    x.test <- log2(x.test)
    
    x.train <- as.data.frame(t(as.matrix(x.train)))
    x.test <- as.data.frame(t(as.matrix(x.test))) 
    
  } else if(norm == "none"){
    x.train <- as.data.frame(t(as.matrix(x.train)))
    x.test <- as.data.frame(t(as.matrix(x.test))) 
  }

  
  return (list(x.train, y.train, x.test, y.test))
  
}