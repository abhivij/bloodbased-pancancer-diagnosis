source("run_fsm_and_model.R")

run_all_models <- function(x = x, output_labels = output_labels, classes = classes, fsm = NA, fsm_name = "all"){
  
  print(paste("Simple Logistic Regression with", fsm_name, "features"))
  results <- run_fsm_and_model(x = x, output_labels = output_labels, classes = classes,
                    model = logistic_regression, fsm = fsm)
  fsm_df <- data.frame(FSM = paste(fsm_name, "features"))
  fsm_df <- cbind(fsm_df, results[[1]])
  fsm_model_df <- data.frame(FSM = paste(fsm_name, "features"), Model = "Simple Logistic Regression")
  fsm_model_df <- cbind(fsm_model_df, results[[2]])
  all_fsm_model_df <- fsm_model_df

  print(paste("Regularized Logistic Regression with", fsm_name, "features"))
  results <- run_fsm_and_model(x = x, output_labels = output_labels, classes = classes,
                    model = logistic_regression, regularize = TRUE, fsm = fsm)
  fsm_model_df <- data.frame(FSM = paste(fsm_name, "features"), Model = "Regularized Logistic Regression")
  fsm_model_df <- cbind(fsm_model_df, results[[2]])
  all_fsm_model_df <- rbind(all_fsm_model_df, fsm_model_df)

  print(paste("Sigmoid Kernel SVM with", fsm_name, "features"))
  results <- run_fsm_and_model(x = x, output_labels = output_labels, classes = classes,
                    model = svm_model, fsm = fsm)
  fsm_model_df <- data.frame(FSM = paste(fsm_name, "features"), Model = "Sigmoid Kernel SVM")
  fsm_model_df <- cbind(fsm_model_df, results[[2]])
  all_fsm_model_df <- rbind(all_fsm_model_df, fsm_model_df)

  print(paste("Radial Kernel SVM with", fsm_name, "features"))
  results <- run_fsm_and_model(x = x, output_labels = output_labels, classes = classes,
                    model = svm_model, kernel = 'radial', fsm = fsm)
  fsm_model_df <- data.frame(FSM = paste(fsm_name, "features"), Model = "Radial Kernel SVM")
  fsm_model_df <- cbind(fsm_model_df, results[[2]])
  all_fsm_model_df <- rbind(all_fsm_model_df, fsm_model_df)

  print(paste("Random Forest with", fsm_name, "features"))
  results <- run_fsm_and_model(x = x, output_labels = output_labels, classes = classes,
                    model = rf_model, fsm = fsm)
  fsm_model_df <- data.frame(FSM = paste(fsm_name, "features"), Model = "Random Forest")
  fsm_model_df <- cbind(fsm_model_df, results[[2]])
  all_fsm_model_df <- rbind(all_fsm_model_df, fsm_model_df)
  
  return (list(fsm_df, all_fsm_model_df))
}