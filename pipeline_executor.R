setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/")
source("pipeline.R")

#GBM1 GBMVsCont
phenotype_file_name <- "phenotype_info/phenotype_GBM1.txt"
read_count_dir_path <- "data/GBM/1"
read_count_file_name <- "GSE122488_normalized_microRNA_counts.txt"
skip_row_count <- 3
classification_criteria <- "GBMvsCont"
#filter <- expression(Age > 55 & Sex == 'M')
filter_expression <- expression(TRUE)
dataset_id <- "GBM1"

execute_pipeline(phenotype_file_name = phenotype_file_name,
                 read_count_dir_path = read_count_dir_path, read_count_file_name = read_count_file_name,
                 skip_row_count = skip_row_count,
                 classification_criteria = classification_criteria, filter_expression = filter_expression,
                 dataset_id = dataset_id)


#GBM1 GBMvsGlioma
classification_criteria <- "GBMvsGlioma"
execute_pipeline(phenotype_file_name = phenotype_file_name,
                 read_count_dir_path = read_count_dir_path, read_count_file_name = read_count_file_name,
                 skip_row_count = skip_row_count,
                 classification_criteria = classification_criteria, filter_expression = filter_expression,
                 dataset_id = dataset_id)


