setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/")
source("data_extraction/extract.R")
source("preprocessing/preprocessing.R")
source("feature_selection/t_test.R")
source("classification_models/logistic_regression.R")

library(caret)

#user input start
phenotype_file_name <- "phenotype_info/phenotype_GBM1.txt"

read_count_dir_path <- "data/GBM/1"
read_count_file_name <- "GSE122488_normalized_microRNA_counts.txt"
skip_row_count <- 3

classification_criteria <- "GBMvsCont"
#filter <- expression(Age > 55 & Sex == 'M')
filter <- expression(TRUE)

extracted_count_file_name <- "read_counts.txt"
output_label_file_name <- "output_labels.txt"

read_count_pp_file_name <- "preprocessed_read_counts.txt"
#user input end

extract_data(phenotype_file_name, read_count_file_name, read_count_dir_path, 
             skip_row_count, classification_criteria, filter,
             extracted_count_file_name, output_label_file_name)


filter_and_normalize(read_count_dir_path, extracted_count_file_name, read_count_pp_file_name)


x <- read.table(paste(read_count_dir_path, read_count_pp_file_name, sep="/"), 
                header=TRUE, row.names=1)
x <- as.data.frame(t(as.matrix(x)))
output_labels <- read.table(paste(read_count_dir_path, output_label_file_name, sep="/"),
                            header=TRUE)

set.seed(1000)
sample_iterations <- 3
train_index <- createDataPartition(output_labels$Label, p = 0.8, list = FALSE, times = sample_iterations)

x.train <- x[train_index[, 1], ]
y.train <- output_labels[train_index[, 1], ]

x.test <- x[-train_index[, 1], ]
y.test <- output_labels[-train_index[, 1], ]


classes <- c("GBM", "Control")

t_test_features <- t_test_features(classes, x.train, y.train)

print('With all features')
logistic_regression(x.train, y.train, x.test, y.test, classes)

print('features from t-test')
logistic_regression(x.train, y.train, x.test, y.test, classes, t_test_features)

