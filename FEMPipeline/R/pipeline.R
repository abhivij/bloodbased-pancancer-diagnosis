# source("R/data_extraction/extract.R")
# source("R/feature_extraction_arguments.R")
# source("R/run_fsm_and_models.R")
# source("R/helper.R")

#' FEM pipeline
#' 
#' Runs the Feature Extraction Method Comparsion pipeline for the given data
#' @param phenotype_file_name Name of the file containing phenotype info - class of each sample
#' 
#' example phenotype file contents given below :
#' 
#' Sample Age Gender Technology    GBMVsControl     GBMVsGlioma
#' 
#' s1     60    M    Microarray    GBM     GBM
#' 
#' s2     65    M   RNASeq        GBM     GBM
#' 
#' s3     59    F    RNASeq        Control NA
#' 
#' s4     55    F    Microarray    NA        Glioma
#' 
#' s5     50    M     RNASeq        Control NA
#' 
#' @param classification_criteria Column in the phenotype file to perform classification on
#' Eg : GBMVsControl 
#' @param filter_expression Filtering to be done on the samples based on a column in the phenotype file 
#' Eg: Age > 55
#' @param classes Classes to be compared : c("negativeclassname", "positiveclassname")
#' @param dataset_id An ID for the data to be written in results
#' @export
execute_pipeline <- function(phenotype_file_name, 
                             read_count_dir_path, 
                             read_count_file_name, 
                             skip_row_count = 0, 
                             row_count = -1,
                             na_strings = "NA",
                             classification_criteria, 
                             filter_expression = expression(TRUE), 
                             classes,
                             extracted_count_file_name = "read_counts.txt",
                             output_label_file_name = "output_labels.txt",
                             dataset_id, 
                             cores = 16,
                             results_dir_path = "results"){
  start_time <- Sys.time()
  print(paste("Pipeline Execution on", dataset_id, classification_criteria))
  
  extracted_count_file_name <- paste(classification_criteria, extracted_count_file_name, sep = "_")
  output_label_file_name <- paste(classification_criteria, output_label_file_name, sep = "_")
  
  data_list <- extract_data(phenotype_file_name, read_count_file_name, read_count_dir_path, 
                            skip_row_count, row_count, na_strings, classification_criteria, filter_expression,
                            extracted_count_file_name, output_label_file_name)
  raw_data_dim <- dim(data_list[[1]])

  x <- data_list[[1]]
  x <- as.data.frame(t(as.matrix(x)))
  output_labels <- data_list[[2]]

  cl <- parallel::makePSOCKcluster(cores)
  doParallel::registerDoParallel(cl)
  
  all_results <- list()
  result_count <- 1
  for (fe_arg in feature_extraction_arguments) {
    all_args <- c(list(x = x, output_labels = output_labels, classes = classes), fe_arg)
    try({
      all_results[[result_count]] <- do.call(run_fsm_and_models, all_args)
      result_count <- result_count + 1
    })
  }
  
  parallel::stopCluster(cl)
  
  dataset_id <- paste(dataset_id, classification_criteria, sep = "_")
  if(length(all_results) != 0){
    write_results(all_results, raw_data_dim,
                  output_labels, dataset_id, classes,
                  results_dir_path)
  }

  
  end_time <- Sys.time()
  print(end_time - start_time)
}