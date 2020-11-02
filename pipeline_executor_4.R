setwd("~/bloodbased-pancancer-diagnosis/")
source("pipeline.R")

#TEP2015 CancerVsHC
phenotype_file_name <- "phenotype_info/phenotype_TEP2015.txt"
read_count_dir_path <- "data/GBM/TEP"
read_count_file_name <- "GSE68086_TEP_data_matrix.txt"
skip_row_count <- 0
#filter <- expression(Age > 55 & Sex == 'M')
filter_expression <- expression(TRUE)
dataset_id <- "TEP2015"
classification_criteria <- "CancerVsHC"
classes <- c("HC", "Cancer")
start_time <- Sys.time()
execute_pipeline(phenotype_file_name = phenotype_file_name,
                 read_count_dir_path = read_count_dir_path, read_count_file_name = read_count_file_name,
                 skip_row_count = skip_row_count,
                 classification_criteria = classification_criteria, filter_expression = filter_expression,
                 classes = classes, dataset_id = dataset_id)
end_time <- Sys.time()
print(end_time - start_time)