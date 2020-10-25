setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results/90PCA/")

library(tidyverse)

data_info <- read.table('data_info.csv', sep = ',', header = TRUE)
fsm_info <- read.table('fsm_info.csv', sep = ',', header = TRUE)
model_results <- read.table('model_results.csv', sep = ',', header = TRUE)


fsm_info <- fsm_info %>%
            select(-starts_with('X'))

model_results <- model_results %>%
  select(-starts_with('X'))

RF_AUC <- model_results %>%
  filter(Model == 'Random Forest') %>%
  select(-c('Model', 'Mean_Accuracy'))

# datasets <- unique(model_results$DataSetId)
# fsms <- unique(model_results$FSM)

ggplot(RF_AUC, aes(x = FSM, y = DataSetId, fill = Mean_AUC)) +
  geom_tile(color="black", size=0.5) +
  scale_fill_gradient(limits=c(0, 1), breaks=seq(0,1,by=0.05)) +
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1), legend.key.height = unit(3, "cm"))

                        