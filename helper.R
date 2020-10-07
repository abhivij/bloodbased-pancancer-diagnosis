write_results <- function(all_results, raw_data_dim, filtered_data_dim, output_labels,
                          dataset_id,
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

  data_df <- data.frame(DataSetId = dataset_id, Samples = raw_data_dim[2], 
                        as.data.frame(t(as.matrix(summary(output_labels$Label)))),
                        RawDataTranscriptCount = raw_data_dim[1],
                        FilteredDataTranscriptCount = filtered_data_dim[1])
  fsm_df <- cbind(DataSetId = dataset_id, fsm_df)
  all_fsm_model_df <- cbind(DataSetId = dataset_id, all_fsm_model_df)
  
  results_file_name <- paste(dataset_id, "results.txt", sep = "_")
  
  if (!dir.exists(dir_path)){
    dir.create(dir_path)
  }  
  
  write.table(data_df, file = paste(dir_path, results_file_name, sep = "/"), 
              quote=FALSE, sep="\t", row.names=FALSE)  
  write.table(fsm_df, file = paste(dir_path, results_file_name, sep = "/"), 
              quote=FALSE, sep="\t", row.names=FALSE, append = TRUE)
  write.table(all_fsm_model_df, file = paste(dir_path, results_file_name, sep = "/"), 
              quote=FALSE, sep="\t", row.names=FALSE, append = TRUE)  
  
}