# library(ranger)

ranger_features <- function(x.train, y.train, x.test, y.test, classes,
                            random_seed = 1000, imp, ...){
  set.seed(random_seed)
  
  if (is.na(imp)) {
    imp <- "permutation"
  }

  ranger_model <- ranger::ranger(x = x.train, y = factor(y.train$Label), importance = imp)
  features <- which(ranger_model$variable.importance != 0)

  x.train <- x.train[, features, drop = FALSE]
  x.test <- x.test[, features, drop = FALSE]
  
  return (list(x.train, y.train, x.test, y.test, c()))
}