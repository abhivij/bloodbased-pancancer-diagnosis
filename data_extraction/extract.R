library(dplyr)

extract_data <- function(phenotype_file, read_count_file, read_count_dir_path, 
                         skip_row_count, classification_criteria, filter,
                         extracted_count_file = "read_counts.txt", output_label_file = "output_labels.txt") {
  read_count_file_path <- paste(read_count_dir_path, read_count_file, sep = "/")
  
  data <- read.table(read_count_file_path, header=TRUE, row.names=1, skip=skip_row_count)
  phenotype <- read.table(phenotype_file, header=TRUE)
  
  extracted_samples <- phenotype %>%
    subset(eval(filter))
  extracted_samples <- extracted_samples[!is.na(extracted_samples[classification_criteria]), ]
  extracted_samples$Sample <- factor(extracted_samples$Sample)
  
  filtered_samples_read_count <- data[, extracted_samples$Sample]
  filtered_samples_output_labels <- extracted_samples[, c('Sample', classification_criteria)]
  colnames(filtered_samples_output_labels) <- c("Sample", "Label")
  
  write.table(filtered_samples_read_count, file = paste(read_count_dir_path, extracted_count_file, sep = "/"), 
              quote=FALSE, sep="\t", row.names=TRUE, col.names=NA)
  write.table(filtered_samples_output_labels, file = paste(read_count_dir_path, output_label_file, sep = "/"),
              quote=FALSE, sep="\t", row.names=FALSE)  
}


