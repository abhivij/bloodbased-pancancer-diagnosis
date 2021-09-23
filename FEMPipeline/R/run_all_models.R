# source("R/classification_models/logistic_regression.R")
# source("R/classification_models/svm.R")
# source("R/classification_models/rf.R")

run_all_models <- function(x.train, y.train, x.test, y.test, classes = classes){
  
  results <- list(
    logistic_regression(x.train, y.train, x.test, y.test, classes = classes),
    logistic_regression(x.train, y.train, x.test, y.test, classes = classes, regularize = 'l1'),
    logistic_regression(x.train, y.train, x.test, y.test, classes = classes, regularize = 'l2'),
    svm_model(x.train, y.train, x.test, y.test, classes = classes),
    svm_model(x.train, y.train, x.test, y.test, classes = classes, kernel = 'radial'),
    rf_model(x.train, y.train, x.test, y.test, classes = classes)
  )
  
  return (results)
}