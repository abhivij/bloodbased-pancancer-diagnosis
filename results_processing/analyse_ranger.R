setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis")
library(tidyverse)
library(caret)
library(stringr)
source("utils/utils.R")
source("preprocessing/preprocessing.R")
source("results_processing/metadata.R")

fsm_vector_ranger_analyze <- c('all', 'ranger_impu_cor')
results_dir <- ""
left_out_features_count_df <- data.frame()
random_seed <- 1000
folds <- 5
sample.total <- 30
extracted_count_file_suffix <- "read_counts.txt"
output_label_file_suffix <- "output_labels.txt"

for (ds in dataset_pipeline_arguments) {
  dataset_id <- paste(ds$dataset_id, ds$classification_criteria, sep = "_")
  
  features_file <- paste(dataset_id, "features.csv", sep = "_")
  features_info <- read.table(get_file_path(features_file, results_dir), 
                              sep = ',', header = TRUE)

  features_info <- features_info %>%
    filter(FSM %in% fsm_vector_ranger_analyze)
  
  read_count_dir_path <- paste("..", ds$read_count_dir_path, sep = "/")
  
  extracted_count_file_name <- paste(ds$classification_criteria, 
                                     extracted_count_file_suffix, sep = "_")
  output_label_file_name <- paste(ds$classification_criteria, 
                                  output_label_file_suffix, sep = "_")
  
  x <- read.table(get_file_path(extracted_count_file_name, read_count_dir_path), 
                     header=TRUE)
  x <- as.data.frame(t(as.matrix(x)))
  output_labels <- read.table(get_file_path(output_label_file_name, read_count_dir_path), 
                              header=TRUE)                 
  
  
  set.seed(random_seed)
  train_index <- createMultiFolds(y = output_labels$Label, k = folds, times = sample.total / folds)
  
  for (sample.count in 1:sample.total){
    iter <- sample.count

    x.train <- x[train_index[[sample.count]], ]
    y.train <- output_labels[train_index[[sample.count]], ]

    x.test <- x[-train_index[[sample.count]], ]
    y.test <- output_labels[-train_index[[sample.count]], ]

    preprocessed_data_list <- filter_and_normalize(x.train, y.train, x.test, y.test)
    x.train <- preprocessed_data_list[[1]]
    y.train <- preprocessed_data_list[[2]]
    x.test <- preprocessed_data_list[[3]]
    y.test <- preprocessed_data_list[[4]]

    #use x.train to identify properties of the specific features selected below


    sums <- colSums(features_info %>%
                      filter(Iter == iter) %>%
                      select(-c(1,2)))
    
    ranger_selected_features_count <- length(which(sums == 2))
    ranger_non_selected_features_count <- length(which(sums == 1))
    
    non_selected_features_by_ranger_percent <- 
        (ranger_non_selected_features_count * 100) / 
        (ranger_selected_features_count + ranger_non_selected_features_count)
    
    left_out_features_count_df <- 
      rbind(left_out_features_count_df,
            data.frame(dataset = dataset_id,
                       iter = iter,
                       ranger_left_out_percent = non_selected_features_by_ranger_percent))    
    
    #below 4 lines of code was an attempt to identify a pattern in features not selected by ranger
    #to be improved as future work
    # ranger_selected_features <- str_replace_all(names(which(sums == 2)), fixed('.'), '-')
    # ranger_non_selected_features <- str_replace_all(names(which(sums == 1)), fixed('.'), '-')
    # ranger_col_sum <- colSums(x.train[, ranger_selected_features])
    # non_ranger_col_sum <- colSums(x.train[, ranger_non_selected_features])
  }
  
}

write.table(left_out_features_count_df, 
            file = get_file_path("left_out_features_count.csv", results_dir), 
            quote = FALSE, sep = ",", 
            row.names = FALSE, append = FALSE, col.names = TRUE)

