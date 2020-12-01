library(doParallel)
source("data_extraction/extract.R")
source("feature_extraction_arguments.R")
source("run_fsm_and_models.R")
source("helper.R")

#provide classes argument as c("negativeclassname", "positiveclassname")
execute_pipeline <- function(phenotype_file_name, 
                             read_count_dir_path, read_count_file_name, skip_row_count = 0,
                             classification_criteria, filter_expression, classes,
                             extracted_count_file_name = "read_counts.txt",
                             output_label_file_name = "output_labels.txt",
                             read_count_pp_file_name = "preprocessed_read_counts.txt",
                             dataset_id, cores = 16,
                             results_dir_path = "results"){
  start_time <- Sys.time()
  print(paste("Pipeline Execution on", dataset_id, classification_criteria))
  
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

  cl <- makePSOCKcluster(cores)
  registerDoParallel(cl)
  
  all_results <- list()
  result_count <- 1
  for (fe_arg in feature_extraction_arguments) {
    all_args <- c(list(x = x, output_labels = output_labels, classes = classes), fe_arg)
    try({
      all_results[[result_count]] <- do.call(run_fsm_and_models, all_args)
      result_count <- result_count + 1
    })
  }
  
  stopCluster(cl)
  
  dataset_id <- paste(dataset_id, classification_criteria, sep = "_")
  write_results(all_results, raw_data_dim, output_labels, dataset_id, classes, results_dir_path)
  
  end_time <- Sys.time()
  print(end_time - start_time)
}