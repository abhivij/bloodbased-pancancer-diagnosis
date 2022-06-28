ipage_transformation <- function(x.train, y.train, x.test, y.test, 
                                 classes, 
                                 random_seed = 1000,
                                 adj_method = "bonferroni", p_cutoff = 1e-16,  
                                 ...){
  
  
  classes <- c("Control", "GBM")
  x.train <- read.csv("dparg70_xtrain.csv", row.names = 1)
  x.test <- read.csv("dparg70_xtest.csv", row.names = 1)
  y.train <- read.csv("dparg70_ytrain.csv", row.names = 1)
  y.test <- read.csv("dparg70_ytest.csv", row.names = 1)
  
  x.train <- x.train[c(1:3), c(1:10)]
  y.train <- y.train[c(1:3), ]
  
  
  
  result <- array(dim = c(ncol(x.train), ncol(x.train), nrow(x.train)))
  dimnames(result)[[1]] <- colnames(x.train)
  dimnames(result)[[2]] <- colnames(x.train)
  result
  
  for(r in c(1:nrow(x.train))){
    row_result <- apply(combn(colnames(x.train), 2), MARGIN = 2, 
                        FUN = function(c) {
                          c1 <- c[1]
                          c2 <- c[2]
                          return(x.train[r, c1] - x.train[r, c2])  
                        }
    )  
    result[, , r][upper.tri(result[, , r])] <- row_result
  }
  result
  
  
  #determine relevant feature combinations
  for(i in c(1:(ncol(m)-1))){
    for(j in c((i+1):ncol(m))){
      sum(result[1, 2, ])
      
      result[1, 2, ] > 0 & y.train$Label == classes[1]
      result[1, 2, ] < 0 & y.train$Label == classes[1]
      
      result[1, 2, ] > 0 & y.train$Label == classes[2]
      result[1, 2, ] < 0 & y.train$Label == classes[2]
      
      a <- result[i, j, ]
    }
  }
  
  
  
  plsda_transform <- caret::plsda(x.train, factor(y.train$Label), ncomp = 2)
  
  x.train <- as.data.frame(as.matrix(x.train) %*% plsda_transform$projection) 
  x.test <- as.data.frame(as.matrix(x.test) %*% plsda_transform$projection) 
  
  return (list(x.train, y.train, x.test, y.test, c()))
}
