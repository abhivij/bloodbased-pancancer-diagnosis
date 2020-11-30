setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results_processing/")
library(tidyverse)
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

################################
file_path <- "data_info.csv"
write.table(data_info, file = file_path, quote = FALSE, sep = ",", 
            row.names = FALSE, append = TRUE)
file_path <- "fsm_info.csv"
write.table(fsm_info, file = file_path, quote = FALSE, sep = ",", 
            row.names = FALSE, append = TRUE)
file_path <- "model_results.csv"  
write.table(model_results, file = file_path, quote = FALSE, sep = ",", 
            row.names = FALSE, append = TRUE)  