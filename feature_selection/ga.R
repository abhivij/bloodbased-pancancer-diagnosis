library(caret)

ga <- function(x.train, y.train, x.test, y.test, classes, random_seed = 1000, ...){
  set.seed(random_seed)
  
  start_time <- Sys.time()
  ctrl <- gafsControl(functions = caretGA, genParallel = TRUE, allowParallel = TRUE)
  ga_fsm <- gafs(x = x.train, y = factor(y.train$Label, levels = classes), gafsControl = ctrl)
  end_time <- Sys.time()
  print(end_time - start_time)
  
  features <- ga_fsm$ga$final
  x.train <- x.train[, features, drop = FALSE]
  x.test <- x.test[, features, drop = FALSE]  
  
  
  return (list(x.train, y.train, x.test, y.test, c()))  
}