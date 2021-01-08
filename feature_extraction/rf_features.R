library(randomForest)

rf_features <- function(x.train, y.train, x.test, y.test, classes,
                            random_seed = 1000, ...){
  set.seed(random_seed)
  
  model <- randomForest(x = x.train, y = factor(y.train$Label, levels = classes))
  features <- which(model$importance != 0) 
  
  x.train <- x.train[, features, drop = FALSE]
  x.test <- x.test[, features, drop = FALSE]  
  
  return (list(x.train, y.train, x.test, y.test, c()))
}