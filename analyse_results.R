library(tidyverse)
library(scmamp)
library(synchrony)

setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results/")

data_info <- read.table('till_TEP2015_latest/data_info.csv', sep = ',', header = TRUE)
fsm_info <- read.table('till_TEP2015_latest/fsm_info.csv', sep = ',', header = TRUE)
all_model_results <- read.table('till_TEP2015_latest/model_results.csv', sep = ',', header = TRUE)

all_model_results <- all_model_results %>%
  mutate(FSM = factor(FSM))

pca_all_model_results <- all_model_results %>%
  filter(grepl('PCA', FSM, fixed = TRUE))

t_test_all_model_results <- all_model_results %>%
  filter(grepl('t-test', FSM, fixed = TRUE))

wilcoxon_all_model_results <- all_model_results %>%
  filter(grepl('wilcoxon', FSM, fixed = TRUE))

all_model_results <- all_model_results %>%
  filter(FSM %in% c('all', 't-test', 'wilcoxontest', 'PCA_90', 'RF_RFE')) %>%
  select(DataSetId, FSM, Model, Mean_AUC)

model <- 'Random Forest'
model_results <- all_model_results %>%
  filter(Model == model) %>%
  select(-Model)

model_results_fsm <- pivot_wider(model_results, names_from = FSM, values_from = Mean_AUC)
model_results_fsm <- column_to_rownames(model_results_fsm, var = 'DataSetId')

avg_ranks <- colMeans(rankMatrix(model_results_fsm))

friedman_test <- friedmanTest(model_results_fsm)

corrected_friedman_test <- imanDavenportTest(model_results_fsm)

nemenyi_test <- nemenyiTest(model_results_fsm, alpha=0.05)
print(nemenyi_test$diff.matrix)
plotCD(model_results_fsm)


model_results_dataset <- pivot_wider(model_results, names_from = DataSetId, values_from = Mean_AUC)
model_results_dataset <- column_to_rownames(model_results_dataset, var = 'FSM')
print(kendall.w(model_results_dataset))


