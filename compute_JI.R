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

get_file_path <- function(file_name, dir_name){
  if (dir_name == "") {
    file_path <- file_name
  }
  else {
    file_path <- paste(dir_name, file_name, sep = "/")
  }
  return (file_path)
}


results_dir <- 'till_TEP2015_latest'
data_info <- read.table(get_file_path('data_info.csv', results_dir), sep = ',', header = TRUE)
fsm_info <- read.table(get_file_path('fsm_info.csv', results_dir), sep = ',', header = TRUE)
model_results <- read.table(get_file_path('model_results.csv', results_dir), sep = ',', header = TRUE)

datasets <- data_info$DataSetId

fsm_vector <- c('all', 't-test', 'wilcoxontest', 'RF_RFE')


# ds <- datasets[1]
# features_file <- paste(ds, "features.csv", sep = "_")
# features_info <- read.table(get_file_path(features_file, results_dir), sep = ',', header = TRUE)
#  
# features_info <- features_info %>%
#     filter(FSM %in% fsm_vector)
# 
# start_time <- Sys.time()
# compute_jaccard_index('all', 'all', features_info)
# compute_jaccard_index('t-test', 't-test', features_info)
# compute_jaccard_index('t-test', 'wilcoxontest', features_info)
# compute_jaccard_index('all', 'wilcoxontest', features_info)
# end_time <- Sys.time()
# print(end_time - start_time)
# 
# 
# start_time <- Sys.time()
# compute_jaccard_index_pairwise('all', 'all', features_info)
# compute_jaccard_index_pairwise('t-test', 't-test', features_info)
# compute_jaccard_index_pairwise('t-test', 'wilcoxontest', features_info)
# compute_jaccard_index_pairwise('all', 'wilcoxontest', features_info)
# end_time <- Sys.time()
# print(end_time - start_time)



start_time <- Sys.time()
all_ji_df <- data.frame()
for (ds in datasets) {
  features_file <- paste(ds, "features.csv", sep = "_")
  features_info <- read.table(get_file_path(features_file, results_dir), sep = ',', header = TRUE)

  features_info <- features_info %>%
    filter(FSM %in% fsm_vector)

  ji_df <- compute_all_jaccard_index(fsm_vector, features_info)

  all_ji_df <- rbind(all_ji_df,
                     cbind(DataSetId = ds, ji_df))
}
end_time <- Sys.time()
print(end_time - start_time)

dir <- 'JI'
ji_data_file_name <- "all_ji.csv"
write.table(all_ji_df, file = paste(dir, ji_data_file_name, sep = "/"),
            quote = FALSE, sep = ",", row.names = FALSE)

ji_heatmap_filename <- "all_ji.png"
create_heatmap(all_ji_df, paste(dir, ji_heatmap_filename, sep = "/"))

