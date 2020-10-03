setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/")
source("data_extraction/extract.R")
source("preprocessing/preprocessing.R")
source("run_fsm_and_model.R")
source("feature_selection/t_test.R")
source("classification_models/logistic_regression.R")
source("classification_models/svm.R")
source("classification_models/rf.R")

execute_pipeline <- function(phenotype_file_name, 
                             read_count_dir_path, read_count_file_name, skip_row_count = 0,
                             classification_criteria, filter_expression, classes,
                             extracted_count_file_name = "read_counts.txt",
                             output_label_file_name = "output_labels.txt",
                             read_count_pp_file_name = "preprocessed_read_counts.txt"){
  
  extract_data(phenotype_file_name, read_count_file_name, read_count_dir_path, 
               skip_row_count, classification_criteria, filter_expression,
               extracted_count_file_name, output_label_file_name)
  
  
  filter_and_normalize(read_count_dir_path, extracted_count_file_name, read_count_pp_file_name)
  
  
  x <- read.table(paste(read_count_dir_path, read_count_pp_file_name, sep="/"), 
                  header=TRUE, row.names=1)
  x <- as.data.frame(t(as.matrix(x)))
  output_labels <- read.table(paste(read_count_dir_path, output_label_file_name, sep="/"),
                              header=TRUE)
  
  print('Simple Logistic Regression with all features')
  run_fsm_and_model(x = x, output_labels = output_labels, classes = classes, 
                    model = logistic_regression)
  
  print('Regularized Logistic Regression with all features')
  run_fsm_and_model(x = x, output_labels = output_labels, classes = classes, 
                    model = logistic_regression, regularize = TRUE)
  
  print('Sigmoid Kernel SVM with all features')
  run_fsm_and_model(x = x, output_labels = output_labels, classes = classes, 
                    model = svm_model)
  
  print('Radial Kernel SVM with all features')
  run_fsm_and_model(x = x, output_labels = output_labels, classes = classes, 
                    model = svm_model, kernel = 'radial')
  
  print('Random Forest with all features')
  run_fsm_and_model(x = x, output_labels = output_labels, classes = classes, 
                    model = rf_model)
  
  print('Simple Logistic Regression with t-test features')
  run_fsm_and_model(x = x, output_labels = output_labels, classes = classes, 
                    model = logistic_regression, fsm = t_test_features)
  
  print('Regularized Logistic Regression with t-test features')
  run_fsm_and_model(x = x, output_labels = output_labels, classes = classes, 
                    model = logistic_regression, regularize = TRUE, fsm = t_test_features)
  
  print('Sigmoid Kernel SVM with t-test features')
  run_fsm_and_model(x = x, output_labels = output_labels, classes = classes, 
                    model = svm_model, fsm = t_test_features)
  
  print('Radial Kernel SVM with t-test features')
  run_fsm_and_model(x = x, output_labels = output_labels, classes = classes, 
                    model = svm_model, kernel = 'radial', fsm = t_test_features)
  
  print('Random Forest with t-test features')
  run_fsm_and_model(x = x, output_labels = output_labels, classes = classes, 
                    model = rf_model, fsm = t_test_features)
  
  
}