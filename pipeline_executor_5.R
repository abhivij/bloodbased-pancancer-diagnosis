setwd("~/bloodbased-pancancer-diagnosis/")
source("pipeline.R")

#TEP2017 NSCLCVsNonCancer
phenotype_file_name <- "phenotype_info/phenotype_TEP2017.txt"
read_count_dir_path <- "data/LungCancer/TEP"
read_count_file_name <- "GSE89843_TEP_Count_Matrix.txt"
skip_row_count <- 0
#filter <- expression(Age > 55 & Sex == 'M')
filter_expression <- expression(TRUE)
dataset_id <- "TEP2017"
classification_criteria <- "NSCLCVsNC"
classes <- c("NonCancer", "NSCLC")
start_time <- Sys.time()
execute_pipeline(phenotype_file_name = phenotype_file_name,
                 read_count_dir_path = read_count_dir_path, read_count_file_name = read_count_file_name,
                 skip_row_count = skip_row_count,
                 classification_criteria = classification_criteria, filter_expression = filter_expression,
                 classes = classes, dataset_id = dataset_id)
end_time <- Sys.time()
print(end_time - start_time)