library(ranger)

#Random Forest Recursive Feature Elimination 
ranger_features <- function(x.train, y.train, x.test, y.test, classes, random_seed = 1000, ...){
  set.seed(random_seed)
  
  ranger_model <- ranger(x = x.train, y = y.train$Label)
  
  return (list(x.train, y.train, x.test, y.test, c()))
}