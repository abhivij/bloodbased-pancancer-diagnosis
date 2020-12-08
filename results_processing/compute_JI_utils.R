library(tidyverse)
library(viridis)
source("../utils/utils.R")
source("../dataset_pipeline_arguments.R")
source("metadata.R")

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
    filter(FSM %in% c(fsm1, fsm2)) %>%
    select(-c(1,2))
  if (fsm1 == fsm2) {
    total_ji <- 0
    count <- 0
    for (i in c(1:(total_iter-1))){
      for (j in c((i+1):total_iter)){
        sums <- colSums(features_info_subset[c(i, j), ])
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
      sums <- colSums(features_info_subset[c(i, i+total_iter), ])
      total_ji <- total_ji +
        (sum(sums == 2) / sum(sums != 0))
    }
    ji <- total_ji / total_iter
  }
  return (ji)
}


compute_all_jaccard_index <- function(fsm_vector, features_info){
  ji_df <- data.frame()
  for(i in c(1:length(fsm_vector))){
    for(j in c(i:length(fsm_vector))){
      ji <- compute_jaccard_index_pairwise(fsm_vector[i], fsm_vector[j], features_info)
      ji_df <- rbind(ji_df, 
                     data.frame(FSM1 = fsm_vector[i], FSM2 = fsm_vector[j], JI = ji))
    }
  }
  return (ji_df)
}


create_heatmap <- function(ji_data, heatmap_file_name){
  ji_heatmap <- ggplot(ji_data, aes(x = FSM1, y = FSM2, fill = JI)) +
    geom_tile(color="black", size=0.5) +
    theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1)) +
    scale_fill_viridis() +
    facet_wrap(facets = vars(DataSetId))
  ggsave(heatmap_file_name, ji_heatmap, width=10, height=10, dpi=300)                        
}



