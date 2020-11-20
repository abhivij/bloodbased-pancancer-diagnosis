library(caret)

#creates a vector containing powers of 'base' until limit
#eg : generate_powers(limit = 5000, base = 2)
#[1]    2    4    8   16   32   64  128  256  512 1024 2048 4096
generate_powers = function(limit, base = 2){
  vals <- c()
  count <- 1
  while(TRUE) {
    num <- base^count
    if (num > limit) {
      break
    }
    vals[count] <- num
    count <- count + 1
  }  
  return (vals)
} 

#Random Forest Recursive Feature Elimination 
rfrfe <- function(x.train, y.train, x.test, y.test, classes, random_seed = 1000, ...){
  set.seed(random_seed)
  
  ctrl <- rfeControl(functions = rfFuncs, method = "repeatedcv")
  rfe_with_rf <- rfe(x.train, factor(y.train$Label, levels = classes),
                   sizes = generate_powers(dim(x.train)[2]),
                   rfeControl = ctrl)
  
  features <- predictors(rfe_with_rf)
  x.train <- x.train[, features, drop = FALSE]
  x.test <- x.test[, features, drop = FALSE]  
    
  return (list(x.train, y.train, x.test, y.test, c()))
}

