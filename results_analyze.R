setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results/")

library(tidyverse)

data_info <- read.table('till_TEP2015_latest/data_info.csv', sep = ',', header = TRUE)
fsm_info <- read.table('till_TEP2015_latest/fsm_info.csv', sep = ',', header = TRUE)
model_results <- read.table('till_TEP2015_latest/model_results.csv', sep = ',', header = TRUE)

datasets <- data_info$DataSetId


ds <- datasets[1]
features_file <- paste(ds, "features.csv", sep = "_")
features_file_path <- paste("till_TEP2015_latest", features_file, sep = "/")

features_info <- read.table(features_file_path, sep = ',', header = TRUE)

features_info <- features_info %>%
  filter(FSM %in% c('all', 't-test', 'wilcoxontest', 'RF_RFE'))

compute_jaccard_index <- function(fsm1, fsm2, features_info, total_iter = 30){
  features_info_subset <- features_info %>%
    filter(FSM %in% c(fsm1, fsm2)) %>%
    select(-c(1,2))
  sums <- colSums(features_info_subset)
  if (fsm1 == fsm2) {
    ji <- sum(sums == total_iter) / sum(sums != 0)
  }
  else {
    ji <- sum(sums == (total_iter*2)) / sum(sums != 0)
  }
  return (ji)
}

compute_jaccard_index_pairwise <- function(fsm1, fsm2, features_info, total_iter = 30){
  features_info_subset <- features_info %>%
    filter(FSM %in% c(fsm1, fsm2))
  if (fsm1 == fsm2) {
    total_ji <- 0
    count <- 0
    for (i in c(1:total_iter-1)){
      for (j in c(i+1:total_iter)){
        sums <- colSums(features_info_subset %>%
                          filter(Iter %in% c(i, j)) %>%
                          select(-c(1,2))
                        )
        total_ji <- total_ji +
          (sum(sums == 2) / sum(sums != 0))
        count <- count + 1
      }
    } 
    ji <- total_ji / count
  }
  else {
    total_ji <- 0
    for (i in c(1:total_iter)){
      sums <- colSums(features_info_subset %>%
                filter(Iter == i) %>%
                select(-c(1,2)))
      total_ji <- total_ji +
        (sum(sums == 2) / sum(sums != 0))
    }
    ji <- total_ji / total_iter
  }
  return (ji)
}

compute_jaccard_index('t-test', 't-test', features_info)
compute_jaccard_index('t-test', 'wilcoxontest', features_info)

compute_jaccard_index_pairwise('t-test', 't-test', features_info)
compute_jaccard_index_pairwise('t-test', 'wilcoxontest', features_info)
