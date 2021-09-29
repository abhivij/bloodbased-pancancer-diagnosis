# library(dplyr)

extract_data <- function(phenotype_file, read_count_file, read_count_dir_path, sep = "",
                         skip_row_count, row_count = -1, na_strings, classification_criteria, filter,
                         extracted_count_file, output_label_file) {
  read_count_file_path <- paste(read_count_dir_path, read_count_file, sep = "/")
  
  data <- read.table(read_count_file_path, header=TRUE, sep=sep, row.names=1, skip=skip_row_count,
                     nrows=row_count, comment.char="", fill=TRUE, na.strings = na_strings)
  data[is.na(data)] <- 0
  phenotype <- read.table(phenotype_file, header=TRUE, sep="\t")
  
  extracted_samples <- phenotype %>% subset(eval(filter))
  extracted_samples <- extracted_samples[!is.na(extracted_samples[classification_criteria]), ]
  extracted_samples$Sample <- factor(extracted_samples$Sample)
  
  filtered_samples_read_count <- data %>% dplyr::select(extracted_samples$Sample)
  
  #from the extracted_samples, select the 'Sample' column and classification_criteria column
  filtered_samples_output_labels <- extracted_samples[, c('Sample', classification_criteria)]
  colnames(filtered_samples_output_labels) <- c("Sample", "Label")
  
  write.table(filtered_samples_read_count, file = paste(read_count_dir_path, extracted_count_file, sep = "/"), 
              quote=FALSE, sep="\t", row.names=TRUE, col.names=NA)
  write.table(filtered_samples_output_labels, file = paste(read_count_dir_path, output_label_file, sep = "/"),
              quote=FALSE, sep="\t", row.names=FALSE) 
  
  extracted_data_list <- list(filtered_samples_read_count, filtered_samples_output_labels)
  return (extracted_data_list)
}


