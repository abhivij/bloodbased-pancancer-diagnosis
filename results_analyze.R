setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results/")

library(tidyverse)
library(viridis)

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


compute_all_jaccard_index <- function(fsm_vector, features_info){
  ji_df <- data.frame()
  for(i in c(1:length(fsm_vector))){
    for(j in c(i:length(fsm_vector))){
      ji <- compute_jaccard_index(fsm_vector[i], fsm_vector[j], features_info)
      ji_df <- rbind(ji_df, 
                     data.frame(FSM1 = fsm_vector[i], FSM2 = fsm_vector[j], JI = ji))
    }
  }
  return (ji_df)
}


compute_jaccard_index_pairwise <- function(fsm1, fsm2, features_info, total_iter = 30){
  features_info_subset <- features_info %>%
    filter(FSM %in% c(fsm1, fsm2))
  if (fsm1 == fsm2) {
    total_ji <- 0
    count <- 0
    for (i in c(1:(total_iter-1))){
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

create_heatmap <- function(ji_data, heatmap_file_name){
  ji_heatmap <- ggplot(ji_data, aes(x = FSM1, y = FSM2, fill = JI)) +
    geom_tile(color="black", size=0.5) +
    theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1)) +
    scale_fill_viridis()
  ji_heatmap
  ggsave(heatmap_file_name, ji_heatmap, width=10, height=10, dpi=300)                        
}


data_info <- read.table('till_TEP2015_latest/data_info.csv', sep = ',', header = TRUE)
fsm_info <- read.table('till_TEP2015_latest/fsm_info.csv', sep = ',', header = TRUE)
model_results <- read.table('till_TEP2015_latest/model_results.csv', sep = ',', header = TRUE)

datasets <- data_info$DataSetId


# ds <- datasets[1]
# features_file <- paste(ds, "features.csv", sep = "_")
# features_file_path <- paste("till_TEP2015_latest", features_file, sep = "/")
# 
# features_info <- read.table(features_file_path, sep = ',', header = TRUE)
# 
# fsm_vector <- c('all', 't-test', 'wilcoxontest', 'RF_RFE')
# 
# features_info <- features_info %>%
#   filter(FSM %in% fsm_vector)

# compute_jaccard_index('t-test', 't-test', features_info)
# compute_jaccard_index('t-test', 'wilcoxontest', features_info)
# 
# compute_jaccard_index_pairwise('t-test', 't-test', features_info)
# compute_jaccard_index_pairwise('t-test', 'wilcoxontest', features_info)

for (ds in datasets) {
  features_file <- paste(ds, "features.csv", sep = "_")
  features_file_path <- paste("till_TEP2015_latest", features_file, sep = "/")
  
  features_info <- read.table(features_file_path, sep = ',', header = TRUE)
  
  fsm_vector <- c('all', 't-test', 'wilcoxontest', 'RF_RFE')
  
  features_info <- features_info %>%
    filter(FSM %in% fsm_vector)
  
  ji_df <- compute_all_jaccard_index(fsm_vector, features_info)
  write.table(ji_df, file = paste("ji", features_file, sep = "_"), 
              quote = FALSE, sep = ",", row.names = FALSE)
  
  heatmap_filename <- paste(paste(ds, "features", "heatmap", sep = "_"), "png", sep = ".")
  create_heatmap(ji_df, heatmap_filename)  
}


