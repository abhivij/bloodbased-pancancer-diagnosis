# source("R/data_extraction/extract.R")
# source("R/feature_extraction_arguments.R")
# source("R/run_fsm_and_models.R")
# source("R/helper.R")

#' FEM pipeline
#' 
#' Runs the Feature Extraction Method comparison pipeline for the given data
#' @param phenotype_file_name Name of the file containing phenotype info - class of each sample.
#' 
#' - should be a tab separated file 
#' 
#' - should have one field named "Sample" and contain sample names as in the read count file
#' 
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
#' @param read_count_dir_path directory path for read count file
#' @param read_count_file_name filename of the read count file. Should be in (transcripts x samples) format.
#' Other biomarkers can also be used.
#' In general case : (biomarkers x samples) : biomarkers along rows, samples along columns
#'
#' @param sep field separator character in read count file
#' @param classification_criteria Column in the phenotype file to perform classification on
#' Eg : GBMVsControl 
#' @param filter_expression Filtering to be done on the samples based on a column in the phenotype file 
#' Eg: Age > 55
#' @param classes Classes to be compared : c("negativeclassname", "positiveclassname")
#' @param extracted_count_file_name name of the file to output the read count file after filtering for classification_criteria and filter_expression.
#' File data format : (transcripts x samples)
#' @param output_label_file_name name of the file with labels for filtered samples as in extracted_count_file.
#' File data format : (2 columns : Sample, Label)
#' @param dataset_id An ID for the data to be written in results
#' @param cores Number of cores to be used for parallel processing
#' @param fems_to_run Vector of names of FEMs to run  Eg: c("t-test", "mrmr30", "mrmr50"). Empty vector value runs pipeline on all FEMs
#' @param fems_to_ignore Vector of names of FEMs to not run from the list of all allowed FEMs  Eg: c("t-test_holm", "ga_rf")
#' 
#'  To see all allowed FEMs use show_allowed_fems()
#' 
#' @param perform_filter Should filtering for low expressed transcripts be performed
#' @param norm Normalization method to be used
#' @param classifier_feature_imp Should feature importance by the classifier be written to a file. 
#' Applicable only for Random Forest
#' @param random_seed random seed value set before train test k-fold split
#' @export 
execute_pipeline <- function(phenotype_file_name, 
                             read_count_dir_path, 
                             read_count_file_name,
                             sep = "",
                             skip_row_count = 0, 
                             row_count = -1,
                             na_strings = "NA",
                             classification_criteria, 
                             filter_expression = expression(TRUE), 
                             classes,
                             extracted_count_file_name = "read_counts.txt",
                             output_label_file_name = "output_labels.txt",
                             dataset_id, 
                             cores = 3,
                             results_dir_path = "results",
                             fems_to_run = c(),
                             fems_to_ignore = c(),
                             perform_filter = TRUE,
                             norm = c("norm_log_cpm", "norm_log_cpm_simple",
                                      "quantile", "norm_quantile", 
                                      "vsn", "norm_log_tmm", FALSE),
                             classifier_feature_imp = FALSE,
                             random_seed = 1000){
  start_time <- Sys.time()
  print(paste("Pipeline Execution on", dataset_id, classification_criteria))
  
  extracted_count_file_name <- paste(classification_criteria, extracted_count_file_name, sep = "_")
  output_label_file_name <- paste(classification_criteria, output_label_file_name, sep = "_")
  
  data_list <- extract_data(phenotype_file_name, read_count_file_name, read_count_dir_path, 
                            sep, skip_row_count, row_count, na_strings,
                            classification_criteria, filter_expression,
                            extracted_count_file_name, output_label_file_name)
  raw_data_dim <- dim(data_list[[1]])

  x <- data_list[[1]]                   #format : (transcripts x samples)
  x <- as.data.frame(t(as.matrix(x)))   #format : (samples x transcripts)
  output_labels <- data_list[[2]]       #format : (2 columns : Sample, Label)

  cl <- parallel::makePSOCKcluster(cores)
  doParallel::registerDoParallel(cl)
  
  all_results <- list()
  result_count <- 1

  for (fe_arg in feature_extraction_arguments) {
    if( (!fe_arg[["fsm_name"]] %in% fems_to_ignore) &&
        (  length(fems_to_run) == 0 ||
          (length(fems_to_run) > 0 && fe_arg[["fsm_name"]] %in% fems_to_run) )
      ){
      all_args <- c(list(x = x, output_labels = output_labels, classes = classes,
                         perform_filter = perform_filter, norm = norm,
                         classifier_feature_imp = classifier_feature_imp,
                         random_seed = random_seed),
                    fe_arg)
      try({
        all_results[[result_count]] <- do.call(run_fsm_and_models, all_args)
        result_count <- result_count + 1
      })
    }
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