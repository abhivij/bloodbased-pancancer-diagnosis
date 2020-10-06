setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/")
source("data_extraction/extract.R")
source("preprocessing/preprocessing.R")
source("run_all_models.R")
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
  
  extracted_data_list <- extract_data(phenotype_file_name, read_count_file_name, read_count_dir_path, 
                            skip_row_count, classification_criteria, filter_expression,
                            extracted_count_file_name, output_label_file_name)
  
  filter_and_normalize(read_count_dir_path, extracted_count_file_name, read_count_pp_file_name,
                       extracted_data_list = extracted_data_list)
  
  x <- read.table(paste(read_count_dir_path, read_count_pp_file_name, sep="/"), 
                  header=TRUE, row.names=1)
  x <- as.data.frame(t(as.matrix(x)))
  output_labels <- read.table(paste(read_count_dir_path, output_label_file_name, sep="/"),
                              header=TRUE)
  
  run_all_models(x = x, output_labels = output_labels, classes = classes)   #with all features
  
  run_all_models(x = x, output_labels = output_labels, classes = classes,
                 fsm = t_test_features, fsm_name = "t-test")
  
}