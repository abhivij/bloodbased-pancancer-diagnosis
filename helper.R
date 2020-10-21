write_results <- function(all_results, raw_data_dim, filtered_data_dim, output_labels,
                          dataset_id, classes,
                          dir_path = "results"){
  fsm_df <- NA
  all_fsm_model_df <- NA
  for(i in c(1:length(all_results))){
    results <- all_results[[i]]
    if(is.na(fsm_df)){
      fsm_df <- results[[1]]
    }
    else{
      fsm_df <- rbind(fsm_df, results[[1]])
    }
    if(is.na(all_fsm_model_df)){
      all_fsm_model_df <- results[[2]]
    }
    else{
      all_fsm_model_df <- rbind(all_fsm_model_df, results[[2]])
    }
  }

  label_summary <- summary(output_labels$Label)
  data_df <- data.frame(DataSetId = dataset_id, SampleCount = raw_data_dim[2], 
                        PositiveClass = classes[2], PositiveClassCount = label_summary[classes[2]], 
                        NegativeClass = classes[1], NegativeClassCount = label_summary[classes[1]], 
                        RawDataTranscriptCount = raw_data_dim[1], FilteredDataTranscriptCount = filtered_data_dim[1])
  fsm_df <- cbind(DataSetId = dataset_id, fsm_df)
  all_fsm_model_df <- cbind(DataSetId = dataset_id, all_fsm_model_df)
  
  if (!dir.exists(dir_path)){
    dir.create(dir_path)
  }  
  
  file_path = paste(dir_path, "data_info.csv", sep = "/")
  write.table(data_df, file = file_path, quote = FALSE, sep = ",", 
              row.names = FALSE, append = TRUE, col.names = !file.exists(file_path))
  file_path = paste(dir_path, "fsm_info.csv", sep = "/")
  write.table(fsm_df, file = file_path, quote = FALSE, sep = ",", 
              row.names = FALSE, append = TRUE, col.names = !file.exists(file_path))
  file_path = paste(dir_path, "model_results.csv", sep = "/")  
  write.table(all_fsm_model_df, file = file_path, quote = FALSE, sep = ",", 
              row.names = FALSE, append = TRUE, col.names = !file.exists(file_path))  
  
}