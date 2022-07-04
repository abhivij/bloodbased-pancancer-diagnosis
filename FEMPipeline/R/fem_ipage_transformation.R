ipage_transformation <- function(x.train, y.train, x.test, y.test, 
                                 classes, 
                                 adjust_method = "bonferroni", p_value_threshold = 0.05,  
                                 ...){
  
  # adjust_method = "bonferroni"
  # p_value_threshold = 1e-16
  # p_value_threshold = 0.5
  # classes <- c("Control", "GBM")
  # x.train <- read.csv("dparg70_xtrain.csv", row.names = 1)
  # x.test <- read.csv("dparg70_xtest.csv", row.names = 1)
  # y.train <- read.csv("dparg70_ytrain.csv", row.names = 1)
  # y.test <- read.csv("dparg70_ytest.csv", row.names = 1)
  # 
  result <- array(dim = c(ncol(x.train), ncol(x.train), nrow(x.train)))
  dimnames(result)[[1]] <- colnames(x.train)
  dimnames(result)[[2]] <- colnames(x.train)
  
  for(r in c(1:nrow(x.train))){
    row_result <- apply(combn(colnames(x.train), 2), MARGIN = 2, 
                        FUN = function(c) {
                          c1 <- c[1]
                          c2 <- c[2]
                          diff <- x.train[r, c1] - x.train[r, c2] 
                          if(diff >= 0){
                            diff <- 1
                          } else{
                            diff <- -1
                          }
                        }
    )  
    result[, , r][upper.tri(result[, , r])] <- row_result
  }
  
  
  #determine relevant feature combinations
  p_val <- apply(combn(colnames(x.train), 2), MARGIN = 2, 
        FUN = function(c) {
          i <- c[1]
          j <- c[2]
          a <- sum(result[i, j, ] > 0 & y.train$Label == classes[1])
          b <- sum(result[i, j, ] < 0 & y.train$Label == classes[1])
          
          c <- sum(result[i, j, ] > 0 & y.train$Label == classes[2])
          d <- sum(result[i, j, ] < 0 & y.train$Label == classes[2])
          
          n <- a + b + c + d
          p <- (factorial(a+b) * factorial(c+d) * factorial(a+c) * factorial(b+d)) / (factorial(a) * factorial(b) * factorial(c) * factorial(d) * factorial(n))

          return(rbind(i, j, p))
        }
  )  

  p_val <- t(p_val)
  p_val[,3] <- p.adjust(p_val[,3], method = adjust_method)
  
  imp_feature_pairs <- p_val[p_val[,3] < p_value_threshold, c(1:2)]

  transf.train <- obtain_pair_diff_transform(data = x.train, imp_feature_pairs = imp_feature_pairs)
  transf.test <- obtain_pair_diff_transform(data = x.test, imp_feature_pairs = imp_feature_pairs)

  return (list(transf.train, y.train, transf.test, y.test, c()))
}


obtain_pair_diff_transform <- function(data, imp_feature_pairs){
  if(dim(imp_feature_pairs)[1] == 0){
    transf <- data[, -c(1:ncol(data))]
  } else{
    transf <- data.frame()
    for(r in c(1:nrow(data))){
      row_transf <- apply(imp_feature_pairs, MARGIN = 1,
                          FUN = function(c){
                            c1 <- c[1]
                            c2 <- c[2]
                            diff <- data[r, c1] - data[r, c2]
                            if(diff >= 0){
                              diff <- 1
                            } else{
                              diff <- -1
                            }
                            return(diff)
                          })
      transf <- rbind(transf, row_transf)
    }  
    colnames(transf) <- paste(imp_feature_pairs[,1], imp_feature_pairs[,2], sep = "_")
    rownames(transf) <- rownames(data)    
  }
  return(transf)
}
