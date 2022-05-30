source("compute_JI_utils.R")

results_dir <- ''

args = commandArgs(trailingOnly = TRUE)
if (length(args) > 1) {
  print(paste('Evaluating JI on dataset', args[2]))
  ds <- dataset_pipeline_arguments[[strtoi(args[2])]]
  dataset_id <- paste(ds$dataset_id, ds$classification_criteria, sep = "_")
  print(dataset_id)
  
  start_time <- Sys.time()

  features_file <- paste(dataset_id, "features.csv", sep = "_")
  
  if (dataset_id %in% c("GSE71008_CRCVsHC", "GSE73002_BCVsNC")) {
    features_info <- read.table(get_file_path(features_file, results_dir), sep = ',', skip = 1)
    colnames(features_info)[1] <- 'FSM'
    colnames(features_info)[2] <- 'Iter'
  }
  else {
    features_info <- read.table(get_file_path(features_file, results_dir), sep = ',', header = TRUE)
  }

  features_info <- features_info %>%
    map_df(rev) %>%
    distinct(FSM, Iter, .keep_all = TRUE) %>%
    map_df(rev)
  
  features_info <- features_info %>%
    filter(FSM %in% fsm_vector_for_ji_computation)
  
  ji_df <- compute_all_jaccard_index(fsm_vector_for_ji_computation, features_info)
  
  ji_df <- cbind(DataSetId = dataset_id, ji_df)
  
  dir_path <- 'JI'
  if (!dir.exists(dir_path)){
    dir.create(dir_path)
  }
  ji_data_file_name <- "all_ji.csv"
  file_path <- paste(dir_path, ji_data_file_name, sep = "/")
  write.table(ji_df, file = file_path,
              quote = FALSE, sep = ",", row.names = FALSE, append = TRUE,
              col.names = !file.exists(file_path))
  
  end_time <- Sys.time()
  print(end_time - start_time)
}


