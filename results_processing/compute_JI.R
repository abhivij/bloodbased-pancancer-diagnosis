source("compute_JI_utils.R")

results_dir <- ''
data_info <- read.table('data_info.csv', sep = ',', header = TRUE)
fsm_info <- read.table('fsm_info.csv', sep = ',', header = TRUE)
model_results <- read.table('model_results.csv', sep = ',', header = TRUE)


args = commandArgs(trailingOnly = TRUE)
if (length(args) > 1) {
  print(paste('Evaluating JI on dataset', args[2]))
  ds <- dataset_pipeline_arguments[[strtoi(args[2])]]
  dataset_id <- paste(ds$dataset_id, ds$classification_criteria, sep = "_")
  print(dataset_id)
  
  start_time <- Sys.time()

  features_file <- paste(dataset_id, "features.csv", sep = "_")
  features_info <- read.table(get_file_path(features_file, results_dir), sep = ',', header = TRUE)
  
  features_info <- features_info %>%
    filter(FSM %in% fsm_vector)
  
  ji_df <- compute_all_jaccard_index(fsm_vector, features_info)
  
  ji_df <- cbind(DataSetId = dataset_id, ji_df)
  
  dir <- 'JI'
  ji_data_file_name <- "all_ji.csv"
  write.table(ji_df, file = paste(dir, ji_data_file_name, sep = "/"),
              quote = FALSE, sep = ",", row.names = FALSE, append = TRUE)
  
  end_time <- Sys.time()
  print(end_time - start_time)
}


