write_results <- function(all_results, raw_data_dim, output_labels,
                          dataset_id, classes,
                          dir_path){

  for(i in c(1:length(all_results))){
    results <- all_results[[i]]
    if(i == 1){
      fsm_df <- results[[1]]
      all_fsm_model_df <- results[[2]]
      all_fsm_model_df.train <- results[[3]]
      features_df <- results[[4]]
      all_samplewise_result_df <- results[[5]]
      feature_imp_df <- results[[6]]
    }
    else{
      fsm_df <- rbind(fsm_df, results[[1]])
      all_fsm_model_df <- rbind(all_fsm_model_df, results[[2]])
      all_fsm_model_df.train <- rbind(all_fsm_model_df.train, results[[3]])
      features_df <- rbind(features_df, results[[4]])
      all_samplewise_result_df <- rbind(all_samplewise_result_df, results[[5]])
      feature_imp_df <- rbind(feature_imp_df, results[[6]])
    }
  }

  label_summary <- summary(factor(output_labels$Label))
  data_df <- data.frame(DataSetId = dataset_id, SampleCount = raw_data_dim[2], 
                        PositiveClass = classes[2], PositiveClassCount = label_summary[classes[2]], 
                        NegativeClass = classes[1], NegativeClassCount = label_summary[classes[1]], 
                        RawDataTranscriptCount = raw_data_dim[1])
  fsm_df <- cbind(DataSetId = dataset_id, fsm_df)
  all_fsm_model_df <- cbind(DataSetId = dataset_id, all_fsm_model_df)
  all_fsm_model_df.train <- cbind(DataSetId = dataset_id, all_fsm_model_df.train)
  all_samplewise_result_df <- cbind(DataSetId = dataset_id, all_samplewise_result_df)
  
  if (!dir.exists(dir_path)){
    dir.create(dir_path)
  }  
  
  file_path <- paste(dir_path, "data_info.csv", sep = "/")
  write.table(data_df, file = file_path, quote = FALSE, sep = ",", 
              row.names = FALSE, append = TRUE, col.names = !file.exists(file_path))
  
  file_path <- paste(dir_path, "fsm_info.csv", sep = "/")
  write.table(fsm_df, file = file_path, quote = FALSE, sep = ",", 
              row.names = FALSE, append = TRUE, col.names = !file.exists(file_path))
  
  file_path <- paste(dir_path, "model_results_test.csv", sep = "/")  
  write.table(all_fsm_model_df, file = file_path, quote = FALSE, sep = ",", 
              row.names = FALSE, append = TRUE, col.names = !file.exists(file_path))
  
  file_path <- paste(dir_path, "model_results_train.csv", sep = "/")  
  write.table(all_fsm_model_df.train, file = file_path, quote = FALSE, sep = ",", 
              row.names = FALSE, append = TRUE, col.names = !file.exists(file_path))
  
  file_name <- paste(dataset_id, "features.csv", sep = "_") 
  file_path <- paste(dir_path, file_name, sep = "/")  
  write.table(features_df, file = file_path, quote = FALSE, sep = ",", 
              row.names = FALSE, append = TRUE, col.names = !file.exists(file_path)) 
  
  file_path <- paste(dir_path, "all_samplewise_result_df.csv", sep = "/")  
  write.table(all_samplewise_result_df, file = file_path, quote = FALSE, sep = ",", 
              row.names = FALSE, append = TRUE, col.names = !file.exists(file_path))
  
  if(dim(feature_imp_df)[1] > 0){
    file_name <- paste(dataset_id, "feature_imp.csv", sep = "_") 
    file_path <- paste(dir_path, file_name, sep = "/")  
    write.table(feature_imp_df, file = file_path, quote = FALSE, sep = ",", 
                row.names = FALSE, append = FALSE, col.names = TRUE) 
  }
    
}