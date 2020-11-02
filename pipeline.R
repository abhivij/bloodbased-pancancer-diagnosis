setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/")
source("data_extraction/extract.R")
source("run_fsm_and_models.R")
source("feature_selection/t_test.R")
source("feature_selection/wilcoxon_test.R")
source("feature_selection/rfrfe.R")
source("feature_selection/pca.R")
source("classification_models/logistic_regression.R")
source("classification_models/svm.R")
source("classification_models/rf.R")
source("helper.R")

#provide classes argument as c("negativeclassname", "positiveclassname")
execute_pipeline <- function(phenotype_file_name, 
                             read_count_dir_path, read_count_file_name, skip_row_count = 0,
                             classification_criteria, filter_expression, classes,
                             extracted_count_file_name = "read_counts.txt",
                             output_label_file_name = "output_labels.txt",
                             read_count_pp_file_name = "preprocessed_read_counts.txt",
                             dataset_id){
  
  extracted_count_file_name <- paste(classification_criteria, extracted_count_file_name, sep = "_")
  output_label_file_name <- paste(classification_criteria, output_label_file_name, sep = "_")
  read_count_pp_file_name <- paste(classification_criteria, read_count_pp_file_name, sep = "_")
  
  data_list <- extract_data(phenotype_file_name, read_count_file_name, read_count_dir_path, 
                            skip_row_count, classification_criteria, filter_expression,
                            extracted_count_file_name, output_label_file_name)
  raw_data_dim <- dim(data_list[[1]])

  x <- data_list[[1]]
  x <- as.data.frame(t(as.matrix(x)))
  output_labels <- data_list[[2]]

  all_results <- list(
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes),  #with all features
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                   fsm = t_test_features, fsm_name = "t-test"),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                   fsm = wilcoxon_test_features, fsm_name = "wilcoxontest"),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                   fsm = pca_transformation, fsm_name = "PCA"),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                   fsm = rfrfe, fsm_name = "RF_RFE")    
  )

  dataset_id <- paste(dataset_id, classification_criteria, sep = "_")
  write_results(all_results, raw_data_dim, output_labels, dataset_id, classes)
}