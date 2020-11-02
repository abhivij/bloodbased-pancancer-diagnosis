setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/")
source("pipeline.R")

#GBM1 GBMVsCont
phenotype_file_name <- "phenotype_info/phenotype_GBM1.txt"
read_count_dir_path <- "data/GBM/1"
read_count_file_name <- "GSE122488_normalized_microRNA_counts.txt"
skip_row_count <- 3
#filter <- expression(Age > 55 & Sex == 'M')
filter_expression <- expression(TRUE)
dataset_id <- "GBM1"
classification_criteria <- "GBMvsCont"
classes <- c("Control", "GBM")
start_time <- Sys.time()
execute_pipeline(phenotype_file_name = phenotype_file_name,
                 read_count_dir_path = read_count_dir_path, read_count_file_name = read_count_file_name,
                 skip_row_count = skip_row_count,
                 classification_criteria = classification_criteria, filter_expression = filter_expression,
                 classes = classes, dataset_id = dataset_id)
end_time <- Sys.time()
print(end_time - start_time)


#GBM1 GBMvsGlioma
phenotype_file_name <- "phenotype_info/phenotype_GBM1.txt"
read_count_dir_path <- "data/GBM/1"
read_count_file_name <- "GSE122488_normalized_microRNA_counts.txt"
skip_row_count <- 3
#filter <- expression(Age > 55 & Sex == 'M')
filter_expression <- expression(TRUE)
dataset_id <- "GBM1"
classification_criteria <- "GBMvsGlioma"
classes <- c("Glioma", "GBM")
start_time <- Sys.time()
execute_pipeline(phenotype_file_name = phenotype_file_name,
                 read_count_dir_path = read_count_dir_path, read_count_file_name = read_count_file_name,
                 skip_row_count = skip_row_count,
                 classification_criteria = classification_criteria, filter_expression = filter_expression,
                 classes = classes, dataset_id = dataset_id)
end_time <- Sys.time()
print(end_time - start_time)


#GBM1 GBMvsGlioma
phenotype_file_name <- "phenotype_info/phenotype_GBM1.txt"
read_count_dir_path <- "data/GBM/1"
read_count_file_name <- "GSE122488_normalized_microRNA_counts.txt"
skip_row_count <- 3
#filter <- expression(Age > 55 & Sex == 'M')
filter_expression <- expression(TRUE)
dataset_id <- "GBM1"
classification_criteria <- "GliomavsCont"
classes <- c("Control", "Glioma")
start_time <- Sys.time()
execute_pipeline(phenotype_file_name = phenotype_file_name,
                 read_count_dir_path = read_count_dir_path, read_count_file_name = read_count_file_name,
                 skip_row_count = skip_row_count,
                 classification_criteria = classification_criteria, filter_expression = filter_expression,
                 classes = classes, dataset_id = dataset_id)
end_time <- Sys.time()
print(end_time - start_time)


#GBM2 GBMVsNC
phenotype_file_name <- "phenotype_info/phenotype_GBM2.txt"
read_count_dir_path <- "data/GBM/2"
read_count_file_name <- "GSE112462.txt"
skip_row_count <- 0
#filter <- expression(Age > 55 & Sex == 'M')
filter_expression <- expression(TRUE)
dataset_id <- "GBM2"
classification_criteria <- "GBMVsNC"
classes <- c("NonCancer", "GBM")
start_time <- Sys.time()
execute_pipeline(phenotype_file_name = phenotype_file_name,
                 read_count_dir_path = read_count_dir_path, read_count_file_name = read_count_file_name,
                 skip_row_count = skip_row_count,
                 classification_criteria = classification_criteria, filter_expression = filter_expression,
                 classes = classes, dataset_id = dataset_id)
end_time <- Sys.time()
print(end_time - start_time)


#GBM2 GBMVsAstro_Oligo
phenotype_file_name <- "phenotype_info/phenotype_GBM2.txt"
read_count_dir_path <- "data/GBM/2"
read_count_file_name <- "GSE112462.txt"
skip_row_count <- 0
#filter <- expression(Age > 55 & Sex == 'M')
filter_expression <- expression(TRUE)
dataset_id <- "GBM2"
classification_criteria <- "GBMVsAstro_Oligo"
classes <- c("Astro_Oligo", "GBM")
start_time <- Sys.time()
execute_pipeline(phenotype_file_name = phenotype_file_name,
                 read_count_dir_path = read_count_dir_path, read_count_file_name = read_count_file_name,
                 skip_row_count = skip_row_count,
                 classification_criteria = classification_criteria, filter_expression = filter_expression,
                 classes = classes, dataset_id = dataset_id)
end_time <- Sys.time()
print(end_time - start_time)

#GBM2 Astro_OligoVsNC
phenotype_file_name <- "phenotype_info/phenotype_GBM2.txt"
read_count_dir_path <- "data/GBM/2"
read_count_file_name <- "GSE112462.txt"
skip_row_count <- 0
#filter <- expression(Age > 55 & Sex == 'M')
filter_expression <- expression(TRUE)
dataset_id <- "GBM2"
classification_criteria <- "Astro_OligoVsNC"
classes <- c("NonCancer", "Astro_Oligo")
start_time <- Sys.time()
execute_pipeline(phenotype_file_name = phenotype_file_name,
                 read_count_dir_path = read_count_dir_path, read_count_file_name = read_count_file_name,
                 skip_row_count = skip_row_count,
                 classification_criteria = classification_criteria, filter_expression = filter_expression,
                 classes = classes, dataset_id = dataset_id)
end_time <- Sys.time()
print(end_time - start_time)


#LungCancer1 LUADVsControl
phenotype_file_name <- "phenotype_info/phenotype_LungCancer1.txt"
read_count_dir_path <- "data/LungCancer/1"
read_count_file_name <- "GSE111803_Readcount_TPM.txt"
skip_row_count <- 0
#filter <- expression(Age > 55 & Sex == 'M')
filter_expression <- expression(TRUE)
dataset_id <- "LungCancer1"
classification_criteria <- "LUADVsControl"
classes <- c("Control", "LUAD")
start_time <- Sys.time()
execute_pipeline(phenotype_file_name = phenotype_file_name,
                 read_count_dir_path = read_count_dir_path, read_count_file_name = read_count_file_name,
                 skip_row_count = skip_row_count,
                 classification_criteria = classification_criteria, filter_expression = filter_expression,
                 classes = classes, dataset_id = dataset_id)
end_time <- Sys.time()
print(end_time - start_time)


#LungCancer3 NSCLCVsCont
phenotype_file_name <- "phenotype_info/phenotype_LungCancer3.txt"
read_count_dir_path <- "data/LungCancer/3"
read_count_file_name <- "GSE114711.txt"
skip_row_count <- 0
#filter <- expression(Age > 55 & Sex == 'M')
filter_expression <- expression(TRUE)
dataset_id <- "LungCancer3"
classification_criteria <- "NSCLCVsCont"
classes <- c("control", "NSCLC")
start_time <- Sys.time()
execute_pipeline(phenotype_file_name = phenotype_file_name,
                 read_count_dir_path = read_count_dir_path, read_count_file_name = read_count_file_name,
                 skip_row_count = skip_row_count,
                 classification_criteria = classification_criteria, filter_expression = filter_expression,
                 classes = classes, dataset_id = dataset_id)
end_time <- Sys.time()
print(end_time - start_time)


#LungCancer3 ENSCLCVsCont
phenotype_file_name <- "phenotype_info/phenotype_LungCancer3.txt"
read_count_dir_path <- "data/LungCancer/3"
read_count_file_name <- "GSE114711.txt"
skip_row_count <- 0
#filter <- expression(Age > 55 & Sex == 'M')
filter_expression <- expression(TRUE)
dataset_id <- "LungCancer3"
classification_criteria <- "ENSCLCVsCont"
classes <- c("control", "earlystageNSCLC")
start_time <- Sys.time()
execute_pipeline(phenotype_file_name = phenotype_file_name,
                 read_count_dir_path = read_count_dir_path, read_count_file_name = read_count_file_name,
                 skip_row_count = skip_row_count,
                 classification_criteria = classification_criteria, filter_expression = filter_expression,
                 classes = classes, dataset_id = dataset_id)
end_time <- Sys.time()
print(end_time - start_time)


#LungCancer3 LNSCLCVsCont
phenotype_file_name <- "phenotype_info/phenotype_LungCancer3.txt"
read_count_dir_path <- "data/LungCancer/3"
read_count_file_name <- "GSE114711.txt"
skip_row_count <- 0
#filter <- expression(Age > 55 & Sex == 'M')
filter_expression <- expression(TRUE)
dataset_id <- "LungCancer3"
classification_criteria <- "LNSCLCVsCont"
classes <- c("control", "latestageNSCLC")
start_time <- Sys.time()
execute_pipeline(phenotype_file_name = phenotype_file_name,
                 read_count_dir_path = read_count_dir_path, read_count_file_name = read_count_file_name,
                 skip_row_count = skip_row_count,
                 classification_criteria = classification_criteria, filter_expression = filter_expression,
                 classes = classes, dataset_id = dataset_id)
end_time <- Sys.time()
print(end_time - start_time)


#LungCancer3 LNSCLCVsENSCLC
phenotype_file_name <- "phenotype_info/phenotype_LungCancer3.txt"
read_count_dir_path <- "data/LungCancer/3"
read_count_file_name <- "GSE114711.txt"
skip_row_count <- 0
#filter <- expression(Age > 55 & Sex == 'M')
filter_expression <- expression(TRUE)
dataset_id <- "LungCancer3"
classification_criteria <- "LNSCLCVsENSCLC"
classes <- c("earlystageNSCLC", "latestageNSCLC")
start_time <- Sys.time()
execute_pipeline(phenotype_file_name = phenotype_file_name,
                 read_count_dir_path = read_count_dir_path, read_count_file_name = read_count_file_name,
                 skip_row_count = skip_row_count,
                 classification_criteria = classification_criteria, filter_expression = filter_expression,
                 classes = classes, dataset_id = dataset_id)
end_time <- Sys.time()
print(end_time - start_time)


#TEP2015 GBMVsHC
phenotype_file_name <- "phenotype_info/phenotype_TEP2015.txt"
read_count_dir_path <- "data/GBM/TEP"
read_count_file_name <- "GSE68086_TEP_data_matrix.txt"
skip_row_count <- 0
#filter <- expression(Age > 55 & Sex == 'M')
filter_expression <- expression(TRUE)
dataset_id <- "TEP2015"
classification_criteria <- "GBMVsHC"
classes <- c("HC", "GBM")
start_time <- Sys.time()
execute_pipeline(phenotype_file_name = phenotype_file_name,
                 read_count_dir_path = read_count_dir_path, read_count_file_name = read_count_file_name,
                 skip_row_count = skip_row_count,
                 classification_criteria = classification_criteria, filter_expression = filter_expression,
                 classes = classes, dataset_id = dataset_id)
end_time <- Sys.time()
print(end_time - start_time)


#TEP2015 NSCLCVsHC
phenotype_file_name <- "phenotype_info/phenotype_TEP2015.txt"
read_count_dir_path <- "data/GBM/TEP"
read_count_file_name <- "GSE68086_TEP_data_matrix.txt"
skip_row_count <- 0
#filter <- expression(Age > 55 & Sex == 'M')
filter_expression <- expression(TRUE)
dataset_id <- "TEP2015"
classification_criteria <- "NSCLCVsHC"
classes <- c("HC", "NSCLC")
start_time <- Sys.time()
execute_pipeline(phenotype_file_name = phenotype_file_name,
                 read_count_dir_path = read_count_dir_path, read_count_file_name = read_count_file_name,
                 skip_row_count = skip_row_count,
                 classification_criteria = classification_criteria, filter_expression = filter_expression,
                 classes = classes, dataset_id = dataset_id)
end_time <- Sys.time()
print(end_time - start_time)


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
