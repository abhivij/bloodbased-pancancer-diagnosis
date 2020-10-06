source("run_fsm_and_model.R")

run_all_models <- function(x = x, output_labels = output_labels, classes = classes, 
                           fsm = NA, fsm_name = "all"){
  
  print(paste("Simple Logistic Regression with", fsm_name, "features"))
  run_fsm_and_model(x = x, output_labels = output_labels, classes = classes, 
                    model = logistic_regression, fsm = fsm)
  
  print(paste("Regularized Logistic Regression with", fsm_name, "features"))  
  run_fsm_and_model(x = x, output_labels = output_labels, classes = classes,
                    model = logistic_regression, regularize = TRUE, fsm = fsm)
  
  print(paste("Sigmoid Kernel SVM with", fsm_name, "features"))  
  run_fsm_and_model(x = x, output_labels = output_labels, classes = classes,
                    model = svm_model, fsm = fsm)
  
  print(paste("Radial Kernel SVM with", fsm_name, "features"))
  run_fsm_and_model(x = x, output_labels = output_labels, classes = classes,
                    model = svm_model, kernel = 'radial', fsm = fsm)
  
  print(paste("Random Forest with", fsm_name, "features"))
  run_fsm_and_model(x = x, output_labels = output_labels, classes = classes,
                    model = rf_model, fsm = fsm)
}