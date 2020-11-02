source("classification_models/logistic_regression.R")
source("classification_models/svm.R")
source("classification_models/rf.R")

run_all_models <- function(x.train, y.train, x.test, y.test, classes = classes){
  
  results <- list(
    logistic_regression(x.train, y.train, x.test, y.test, classes = classes),
    logistic_regression(x.train, y.train, x.test, y.test, classes = classes, regularize = TRUE),
    svm_model(x.train, y.train, x.test, y.test, classes = classes),
    svm_model(x.train, y.train, x.test, y.test, classes = classes, kernel = 'radial'),
    rf_model(x.train, y.train, x.test, y.test, classes = classes)
  )
  
  return (results)
}