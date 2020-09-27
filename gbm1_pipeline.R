setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/")
source("data_extraction/extract.R")
source("preprocessing/preprocessing.R")

#user input start
phenotype_file <- "phenotype_info/phenotype_GBM1.txt"

read_count_dir_path <- "data/GBM/1"
read_count_file <- "GSE122488_normalized_microRNA_counts.txt"
skip_row_count <- 3

classification_criteria <- "GBMvsCont"
#filter <- expression(Age > 55 & Sex == 'M')
filter <- expression(TRUE)
#user input end

extract_data(phenotype_file, read_count_file, read_count_dir_path, skip_row_count, classification_criteria, filter)


read_count_dir_path <- "data/GBM/1"
read_count_file_name <- "read_counts.txt"
read_count_pp_file_name <- "preprocessed_read_counts.txt"
output_label_file_name <- "output_labels.txt"

filter_and_normalize(read_count_dir_path, read_count_file_name, read_count_pp_file_name)


x <- read.table(paste(read_count_dir_path, read_count_pp_file_name, sep="/"), 
                header=TRUE, row.names=1)

output_labels <- read.table(paste(read_count_dir_path, output_label_file_name, sep="/"),
                            header=TRUE, row.names=1)

ttest_result <- c()
for (i in 1:nrow(x)) {
  ttest_result[i] <- t.test(x = x[i, output_labels$Label == 'GBM'],
                            y = x[i, output_labels$Label == 'Control'],
                            var.equal = FALSE)$p.value
}
ttest_result <- data.frame(ttest_result)
row.names(ttest_result) <- rownames(x)
