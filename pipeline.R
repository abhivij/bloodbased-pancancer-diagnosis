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
                             read_count_pp_file_name = "preprocessed_read_counts.txt",
                             dataset_id){
  
  extracted_count_file_name <- paste(classification_criteria, extracted_count_file_name, sep = "_")
  output_label_file_name <- paste(classification_criteria, output_label_file_name, sep = "_")
  read_count_pp_file_name <- paste(classification_criteria, read_count_pp_file_name, sep = "_")
  
  data_list <- extract_data(phenotype_file_name, read_count_file_name, read_count_dir_path, 
                            skip_row_count, classification_criteria, filter_expression,
                            extracted_count_file_name, output_label_file_name)
  raw_data_dim <- dim(data_list[[1]])
  data_list <- filter_and_normalize(data_list, read_count_dir_path, read_count_pp_file_name)
  filtered_data_dim <- dim(data_list[[1]])
  
  x <- data_list[[1]]
  x <- as.data.frame(t(as.matrix(x)))
  output_labels <- data_list[[2]]
  
  results <- run_all_models(x = x, output_labels = output_labels, classes = classes)   #with all features
  fsm_df <- results[[1]]
  all_fsm_model_df <- results[[2]]
  
  results <- run_all_models(x = x, output_labels = output_labels, classes = classes,
                 fsm = t_test_features, fsm_name = "t-test")
  fsm_df <- rbind(fsm_df, results[[1]])
  all_fsm_model_df <- rbind(all_fsm_model_df, results[[2]])
  
  dataset_id <- paste(dataset_id, classification_criteria, sep = "_")

  data_df <- data.frame(DataSetId = dataset_id, Samples = raw_data_dim[2], 
                        as.data.frame(t(as.matrix(summary(output_labels$Label)))),
                        RawDataTranscriptCount = raw_data_dim[1],
                        FilteredDataTranscriptCount = filtered_data_dim[1])
  fsm_df <- cbind(DataSetId = dataset_id, fsm_df)
  all_fsm_model_df <- cbind(DataSetId = dataset_id, all_fsm_model_df)
  
  write.table(data_df, file = paste(read_count_dir_path, "results.txt", sep = "/"), 
              quote=FALSE, sep="\t", row.names=FALSE)  
  write.table(fsm_df, file = paste(read_count_dir_path, "results.txt", sep = "/"), 
              quote=FALSE, sep="\t", row.names=FALSE, append = TRUE)
  write.table(all_fsm_model_df, file = paste(read_count_dir_path, "results.txt", sep = "/"), 
              quote=FALSE, sep="\t", row.names=FALSE, append = TRUE)  
  
  return (list(data_df, fsm_df, all_fsm_model_df))
}