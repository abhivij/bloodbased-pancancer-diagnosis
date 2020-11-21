write_results <- function(all_results, raw_data_dim, output_labels,
                          dataset_id, classes,
                          dir_path = "results_ga_rf"){

  for(i in c(1:length(all_results))){
    results <- all_results[[i]]
    if(i == 1){
      fsm_df <- results[[1]]
      all_fsm_model_df <- results[[2]]
      features_df <- results[[3]]
    }
    else{
      fsm_df <- rbind(fsm_df, results[[1]])
      all_fsm_model_df <- rbind(all_fsm_model_df, results[[2]])
      features_df <- rbind(features_df, results[[3]])
    }
  }

  label_summary <- summary(output_labels$Label)
  data_df <- data.frame(DataSetId = dataset_id, SampleCount = raw_data_dim[2], 
                        PositiveClass = classes[2], PositiveClassCount = label_summary[classes[2]], 
                        NegativeClass = classes[1], NegativeClassCount = label_summary[classes[1]], 
                        RawDataTranscriptCount = raw_data_dim[1])
  fsm_df <- cbind(DataSetId = dataset_id, fsm_df)
  all_fsm_model_df <- cbind(DataSetId = dataset_id, all_fsm_model_df)
  
  if (!dir.exists(dir_path)){
    dir.create(dir_path)
  }  
  
  file_path <- paste(dir_path, "data_info.csv", sep = "/")
  write.table(data_df, file = file_path, quote = FALSE, sep = ",", 
              row.names = FALSE, append = TRUE, col.names = !file.exists(file_path))
  file_path <- paste(dir_path, "fsm_info.csv", sep = "/")
  write.table(fsm_df, file = file_path, quote = FALSE, sep = ",", 
              row.names = FALSE, append = TRUE, col.names = !file.exists(file_path))
  file_path <- paste(dir_path, "model_results.csv", sep = "/")  
  write.table(all_fsm_model_df, file = file_path, quote = FALSE, sep = ",", 
              row.names = FALSE, append = TRUE, col.names = !file.exists(file_path))  
  file_name <- paste(dataset_id, "features.csv", sep = "_") 
  file_path <- paste(dir_path, file_name, sep = "/")  
  write.table(features_df, file = file_path, quote = FALSE, sep = ",", 
              row.names = FALSE, append = TRUE, col.names = !file.exists(file_path))  
    
}