source("data_extraction/extract.R")
source("run_fsm_and_models.R")
source("feature_selection/t_test.R")
source("feature_selection/wilcoxon_test.R")
source("feature_selection/rfrfe.R")
source("feature_selection/ga.R")
source("feature_selection/pca.R")
source("helper.R")
library(doParallel)

#provide classes argument as c("negativeclassname", "positiveclassname")
execute_pipeline <- function(phenotype_file_name, 
                             read_count_dir_path, read_count_file_name, skip_row_count = 0,
                             classification_criteria, filter_expression, classes,
                             extracted_count_file_name = "read_counts.txt",
                             output_label_file_name = "output_labels.txt",
                             read_count_pp_file_name = "preprocessed_read_counts.txt",
                             dataset_id, cores = 4){
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
  
  all_results <- list(
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes),  #with all features
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                   fsm = t_test_features, fsm_name = "t-test"),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                       fsm = t_test_features, fsm_name = "t-test_holm", adjust_method = 'holm'),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                       fsm = t_test_features, fsm_name = "t-test_bonferroni", adjust_method = 'bonferroni'),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                       fsm = t_test_features, fsm_name = "t-test_BH", adjust_method = 'BH'),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                       fsm = t_test_features, fsm_name = "t-test_BY", adjust_method = 'BY'),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                   fsm = wilcoxon_test_features, fsm_name = "wilcoxontest"),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                       fsm = wilcoxon_test_features, fsm_name = "wilcoxontest_holm", adjust_method = 'holm'),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                       fsm = wilcoxon_test_features, fsm_name = "wilcoxontest_bonferroni", adjust_method = 'bonferroni'),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                       fsm = wilcoxon_test_features, fsm_name = "wilcoxontest_BH", adjust_method = 'BH'),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                       fsm = wilcoxon_test_features, fsm_name = "wilcoxontest_BY", adjust_method = 'BY'),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                       fsm = pca_transformation, fsm_name = "PCA_50", transformation =TRUE, variance_threshold = 0.5),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                       fsm = pca_transformation, fsm_name = "PCA_75", transformation =TRUE, variance_threshold = 0.75),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                       fsm = pca_transformation, fsm_name = "PCA_90", transformation =TRUE, variance_threshold = 0.9),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                   fsm = pca_transformation, fsm_name = "PCA_95", transformation =TRUE, variance_threshold = 0.95),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                       fsm = pca_transformation, fsm_name = "PCA_99", transformation =TRUE, variance_threshold = 0.99),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                       fsm = pca_transformation, fsm_name = "PCA_100", transformation =TRUE),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                   fsm = rfrfe, fsm_name = "RF_RFE"),
    run_fsm_and_models(x = x, output_labels = output_labels, classes = classes,
                      fsm = ga, fsm_name = "Genetic Algorithm")
  )
  
  stopCluster(cl)
  
  dataset_id <- paste(dataset_id, classification_criteria, sep = "_")
  write_results(all_results, raw_data_dim, output_labels, dataset_id, classes)
  
  end_time <- Sys.time()
  print(end_time - start_time)
}