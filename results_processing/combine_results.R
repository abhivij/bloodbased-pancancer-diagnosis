setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results_processing/")
library(tidyverse)
source("../utils/utils.R")
source("metadata.R")

#ga_with_rf
ga_with_rf.data_info <- read.table('ga_with_rf/data_info.csv', sep = ',', header = TRUE)
ga_with_rf.fsm_info <- read.table('ga_with_rf/fsm_info.csv', sep = ',', header = TRUE)
ga_with_rf.model_results <- read.table('ga_with_rf/model_results.csv', sep = ',', header = TRUE)

#all_datasets_till_rfrfe
all_datasets_till_rfrfe.data_info <- read.table('all_datasets_till_rfrfe/data_info.csv', sep = ',', header = TRUE)
all_datasets_till_rfrfe.fsm_info <- read.table('all_datasets_till_rfrfe/fsm_info.csv', sep = ',', header = TRUE)
all_datasets_till_rfrfe.model_results <- read.table('all_datasets_till_rfrfe/model_results.csv', sep = ',', header = TRUE)

#till_3_transformation
till_3_transformation.data_info <- read.table('till_3_transformation/data_info.csv', sep = ',', header = TRUE)
till_3_transformation.fsm_info <- read.table('till_3_transformation/fsm_info.csv', sep = ',', header = TRUE)
till_3_transformation.model_results <- read.table('till_3_transformation/model_results.csv', sep = ',', header = TRUE)

#umap_plsda
umap_plsda.data_info <- read.table('umap_plsda/data_info.csv', sep = ',', header = TRUE)
umap_plsda.fsm_info <- read.table('umap_plsda/fsm_info.csv', sep = ',', header = TRUE)
umap_plsda.model_results <- read.table('umap_plsda/model_results.csv', sep = ',', header = TRUE)


till_3_transformation.fsm_info <- till_3_transformation.fsm_info %>%
  filter(FSM %in% new_t_vector)
till_3_transformation.model_results <- till_3_transformation.model_results %>%
  filter(FSM %in% new_t_vector)

ga_with_rf.model_results <- ga_with_rf.model_results %>%
  select(c(1:9))
till_3_transformation.model_results <- till_3_transformation.model_results %>%
  select(c(1:9))
umap_plsda.model_results <- umap_plsda.model_results %>%
  select(c(1:9))

model_results <- rbind(ga_with_rf.model_results, 
                       all_datasets_till_rfrfe.model_results, 
                       till_3_transformation.model_results,
                       umap_plsda.model_results)
model_results <- model_results %>%
  arrange(DataSetId, FSM, Model)

fsm_info <- rbind(ga_with_rf.fsm_info, 
                  all_datasets_till_rfrfe.fsm_info,
                  till_3_transformation.fsm_info,
                  umap_plsda.fsm_info)
fsm_info <- fsm_info %>%
  arrange(DataSetId, FSM)

data_info <- all_datasets_till_rfrfe.data_info


#################################
#for comparing ga s

#ga
ga.data_info <- read.table('ga/data_info.csv', sep = ',', header = TRUE)
ga.fsm_info <- read.table('ga/fsm_info.csv', sep = ',', header = TRUE)
ga.model_results <- read.table('ga/model_results.csv', sep = ',', header = TRUE)

#ga_with_rf_with_repeated_cv
ga_with_rf.data_info <- read.table('ga_with_rf/data_info.csv', sep = ',', header = TRUE)
ga_with_rf.fsm_info <- read.table('ga_with_rf/fsm_info.csv', sep = ',', header = TRUE)
ga_with_rf.model_results <- read.table('ga_with_rf/model_results.csv', sep = ',', header = TRUE)

#ga_with_rf_with_cv
ga_rf_and_rfrfe_with_cv.data_info <- read.table('ga_rf_and_rfrfe_with_cv/data_info.csv', sep = ',', header = TRUE)
ga_rf_and_rfrfe_with_cv.fsm_info <- read.table('ga_rf_and_rfrfe_with_cv/fsm_info.csv', sep = ',', header = TRUE)
ga_rf_and_rfrfe_with_cv.model_results <- read.table('ga_rf_and_rfrfe_with_cv/model_results.csv', sep = ',', header = TRUE)

ga_rf_and_rfrfe_with_cv.model_results <- ga_rf_and_rfrfe_with_cv.model_results %>%
  filter(FSM == 'GA_RF') %>%
  mutate(FSM = 'ga_rf_cv') %>%
  filter(! DataSetId %in% TEP_datasets)

ga_rf_and_rfrfe_with_cv.fsm_info <- ga_rf_and_rfrfe_with_cv.fsm_info %>%
  filter(FSM == 'GA_RF') %>%
  mutate(FSM = 'ga_rf_cv') %>%
  filter(! DataSetId %in% TEP_datasets)

ga_with_rf.model_results <- ga_with_rf.model_results %>%
  mutate(FSM = 'ga_rf_with_repcv') %>%
  filter(! DataSetId %in% TEP_datasets)

ga_with_rf.fsm_info <- ga_with_rf.fsm_info %>%
  mutate(FSM = 'ga_rf_with_repcv') %>%
  filter(! DataSetId %in% TEP_datasets)

ga.model_results <- ga.model_results %>%
  filter(FSM == 'Genetic Algorithm') %>%
  mutate(FSM = 'ga')

ga.fsm_info <- ga.fsm_info %>%
  filter(FSM == 'Genetic Algorithm') %>%
  mutate(FSM = 'ga')

model_results <- rbind(ga.model_results,
                       ga_with_rf.model_results,
                       ga_rf_and_rfrfe_with_cv.model_results)
model_results <- model_results %>%
  arrange(DataSetId, FSM, Model)

fsm_info <- rbind(ga.fsm_info,
                  ga_with_rf.fsm_info,
                  ga_rf_and_rfrfe_with_cv.fsm_info)
fsm_info <- fsm_info %>%
  arrange(DataSetId, FSM)

data_info <- ga.data_info
#################################

#for comparing RF s

#all_datasets_till_rfrfe
all_datasets_till_rfrfe.data_info <- read.table('all_datasets_till_rfrfe/data_info.csv', sep = ',', header = TRUE)
all_datasets_till_rfrfe.fsm_info <- read.table('all_datasets_till_rfrfe/fsm_info.csv', sep = ',', header = TRUE)
all_datasets_till_rfrfe.model_results <- read.table('all_datasets_till_rfrfe/model_results.csv', sep = ',', header = TRUE)

#ga_with_rf_with_cv
ga_rf_and_rfrfe_with_cv.data_info <- read.table('ga_rf_and_rfrfe_with_cv/data_info.csv', sep = ',', header = TRUE)
ga_rf_and_rfrfe_with_cv.fsm_info <- read.table('ga_rf_and_rfrfe_with_cv/fsm_info.csv', sep = ',', header = TRUE)
ga_rf_and_rfrfe_with_cv.model_results <- read.table('ga_rf_and_rfrfe_with_cv/model_results.csv', sep = ',', header = TRUE)


all_datasets_till_rfrfe.model_results <- all_datasets_till_rfrfe.model_results %>%
  filter(FSM == 'RF_RFE') %>%
  mutate(FSM = 'rf_repcv') %>%
  filter(DataSetId != 'TEP2017_NSCLCVsNC')

ga_rf_and_rfrfe_with_cv.model_results <- ga_rf_and_rfrfe_with_cv.model_results %>%
  filter(FSM == 'RF_RFE') %>%
  mutate(FSM = 'rf_cv') %>%
  select(c(1:9))


all_datasets_till_rfrfe.fsm_info <- all_datasets_till_rfrfe.fsm_info %>%
  filter(FSM == 'RF_RFE') %>%
  mutate(FSM = 'rf_repcv') %>%
  filter(DataSetId != 'TEP2017_NSCLCVsNC')

ga_rf_and_rfrfe_with_cv.fsm_info <- ga_rf_and_rfrfe_with_cv.fsm_info %>%
  filter(FSM == 'RF_RFE') %>%
  mutate(FSM = 'rf_cv')


model_results <- rbind(all_datasets_till_rfrfe.model_results,
                       ga_rf_and_rfrfe_with_cv.model_results)
model_results <- model_results %>%
  arrange(DataSetId, FSM, Model)

fsm_info <- rbind(all_datasets_till_rfrfe.fsm_info,
                  ga_rf_and_rfrfe_with_cv.fsm_info)
fsm_info <- fsm_info %>%
  arrange(DataSetId, FSM)

data_info <- ga_rf_and_rfrfe_with_cv.data_info
#################################

#all models till kpca

#ga_with_rf
ga_with_rf.data_info <- read.table('results_ga_with_rf/data_info.csv', sep = ',', header = TRUE)
ga_with_rf.fsm_info <- read.table('results_ga_with_rf/fsm_info.csv', sep = ',', header = TRUE)
ga_with_rf.model_results <- read.table('results_ga_with_rf/model_results.csv', sep = ',', header = TRUE)

#results till ranger
till_ranger.data_info <- read.table('results_till_ranger/data_info.csv', sep = ',', header = TRUE)
till_ranger.fsm_info <- read.table('results_till_ranger/fsm_info.csv', sep = ',', header = TRUE)
till_ranger.model_results <- read.table('results_till_ranger/model_results.csv', sep = ',', header = TRUE)

#results mrmr, kpca
kpca_mrmr.data_info <- read.table('results_mrmr/data_info.csv', sep = ',', header = TRUE)
kpca_mrmr.fsm_info <- read.table('results_mrmr/fsm_info.csv', sep = ',', header = TRUE)
kpca_mrmr.model_results <- read.table('results_mrmr/model_results.csv', sep = ',', header = TRUE)

model_results <- rbind(ga_with_rf.model_results,
                       till_ranger.model_results,
                       kpca_mrmr.model_results)
model_results <- model_results %>%
  arrange(DataSetId, FSM, Model)

fsm_info <- rbind(ga_with_rf.fsm_info,
                  till_ranger.fsm_info,
                  kpca_mrmr.fsm_info)
fsm_info <- fsm_info %>%
  arrange(DataSetId, FSM)

data_info <- ga_with_rf.data_info
datasets <- data_info$DataSetId
results_dir_vector <- c('results_ga_with_rf', 'results_till_ranger', 'results_mrmr')

#################################

#specify data_info_dir if all datasets are present in only one of the result directories
combine_results <- function(results_dir_vector, data_info_dir = ""){
  all_fsm_info <- data.frame()
  all_model_results <- data.frame()
  for (results_dir in results_dir_vector) {
    if (data_info_dir == "" || data_info_dir == results_dir){
      data_info <- read.table(paste(results_dir, 'data_info.csv', sep = '/'), sep = ',', header = TRUE)
    }
    fsm_info <- read.table(paste(results_dir, 'fsm_info.csv', sep = '/'), sep = ',', header = TRUE)
    model_results <- read.table(paste(results_dir, 'model_results.csv', sep = '/'), sep = ',', header = TRUE)

    if(length(all_fsm_info) == 0){
      all_fsm_info <- fsm_info
    }
    else{
      all_fsm_info <- rbind(all_fsm_info, fsm_info)
    }
    if(length(all_model_results) == 0){
      all_model_results <- model_results
    }
    else{
      all_model_results <- rbind(all_model_results, model_results)
    }
  }

  all_fsm_info <- all_fsm_info %>%
    arrange(DataSetId, FSM)
  all_model_results <- all_model_results %>%
    arrange(DataSetId, FSM, Model)

  file_path <- "data_info.csv"
  write.table(data_info, file = file_path, quote = FALSE, sep = ",",
              row.names = FALSE, append = TRUE)
  file_path <- "fsm_info.csv"
  write.table(all_fsm_info, file = file_path, quote = FALSE, sep = ",",
              row.names = FALSE, append = TRUE)
  file_path <- "model_results.csv"
  write.table(all_model_results, file = file_path, quote = FALSE, sep = ",",
              row.names = FALSE, append = TRUE)

  return (list(data_info, all_fsm_info, all_model_results))
}


combine_features_info <- function(results_dir_vector, datasets){
  for (ds in datasets) {
    features_file <- paste(ds, "features.csv", sep = "_")
    all_features_info <- data.frame()
    for(results_dir in results_dir_vector){
      features_info <- read.table(get_file_path(features_file, results_dir), sep = ',', header = TRUE)
      if(length(all_features_info) == 0){
        all_features_info <- features_info
      }
      else{
        all_features_info <- rbind(all_features_info, features_info)
      }
    }
    all_features_info <- all_features_info %>%
      arrange(FSM, Iter)
    write.table(all_features_info, file = features_file, quote = FALSE, sep = ",",
                row.names = FALSE, append = TRUE)
  }
}


all_results <- combine_results(results_dir_vector =
                                 c('results_ga_with_rf', 'results_till_ranger',
                                 'results_mrmr', 'results_newmethod', 
                                 'results_pcavarcomp', 'results_rf_features',
                                 'results_no_fil'))
data_info <- all_results[[1]]
datasets <- data_info$DataSetId

combine_features_info(results_dir_vector =
                        c('results_ga_with_rf', 'results_till_ranger', 
                          'results_mrmr', 'results_rf_features', 'results_no_fil'),
                      datasets)
