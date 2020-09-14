setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/")
source("data_extraction/extract.R")

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
