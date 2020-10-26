setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results/")

library(tidyverse)
library(plotly)
library(viridis)

data_info <- read.table('data_info.csv', sep = ',', header = TRUE)
fsm_info <- read.table('fsm_info.csv', sep = ',', header = TRUE)
model_results <- read.table('model_results.csv', sep = ',', header = TRUE)


#plots from model_results.csv start

model_results <- model_results %>%
  mutate(FSM = sub(" features", "", FSM)) %>%
  mutate(FSM = factor(FSM, levels=c('wilcoxontest',
                                    't-test',
                                    'all',
                                    'PCA')))

all_model_heatmap <- ggplot(model_results, aes(x = FSM, y = DataSetId, fill = Mean_AUC, text = Mean_AUC)) +
  geom_tile(color="black", size=0.5) +
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1)) +
  scale_fill_viridis(option="magma") +
  facet_wrap(facets = vars(Model))
all_model_heatmap
# ggplotly(all_model_heatmap, tooltip = "text")
ggsave("all_model_heatmap.png", all_model_heatmap, width=10, height=10, dpi=300)                        



all_model_barplot <- ggplot(model_results, aes(x=DataSetId, fill=FSM, y=Mean_AUC)) +
  geom_bar(stat="identity", position="dodge") +
  geom_errorbar( aes(x=DataSetId, ymin=X95.CI_AUC_lower, ymax=X95.CI_AUC_upper), position="dodge") +
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1)) +
  facet_wrap(facets = vars(Model))  
ggsave("all_model_barplot.png", all_model_barplot, width=10, height=10, dpi=300)


classification_models <- unique(model_results$Model)
for (cm in classification_models) {
  individual_model <- model_results %>%
    filter(Model == cm)
  model_barplot <- ggplot(individual_model, aes(x=DataSetId, fill=FSM, y=Mean_AUC)) +
    geom_bar(stat="identity", position="dodge") +
    geom_errorbar( aes(x=DataSetId, ymin=X95.CI_AUC_lower, ymax=X95.CI_AUC_upper), position="dodge") +
    theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1)) +
    facet_wrap(facets = vars(Model))  
  plotname <- paste(str_replace(cm, " ", ""), "barplot.png", sep = "_")
  ggsave(plotname, model_barplot, width=10, height=10, dpi=300)
}

#plots from model_results.csv end




#plots from fsm_info.csv start

transformation_fsms <- c('PCA')
TEP_datasets <- c('TEP2015_GBMVsHC', 'TEP2015_NSCLCVsHC', 'TEP2015_CancerVsHC', 'TEP2017_NSCLCVsNC')

fsm_info <- fsm_info %>%
  mutate(FSM = sub(" features", "", FSM))

transformation_fsm_info <- fsm_info %>%
  filter(FSM %in% transformation_fsms) %>%
  select(-c(3,4,5))

fsm_info <- fsm_info %>%
  filter(! FSM %in% transformation_fsms)
TEP_fsm_info <- fsm_info %>%
  filter(DataSetId %in% TEP_datasets)
non_TEP_fsm_info <- fsm_info %>%
  filter(! DataSetId %in% TEP_datasets)

features_barplot_TEPS <- ggplot(TEP_fsm_info, aes(x=DataSetId, fill=FSM, y=Mean_Number.of.features)) +
  geom_bar(stat="identity", position="dodge") +
  geom_errorbar( aes(x=DataSetId, ymin=X95.CI_Number.of.features_lower, ymax=X95.CI_Number.of.features_upper), position="dodge") +
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1))  
ggsave("features_count_barplot_TEPS.png", features_barplot_TEPS, width=10, height=10, dpi=300)

features_barplot_nonTEPS <- ggplot(non_TEP_fsm_info, aes(x=DataSetId, fill=FSM, y=Mean_Number.of.features)) +
  geom_bar(stat="identity", position="dodge") +
  geom_errorbar( aes(x=DataSetId, ymin=X95.CI_Number.of.features_lower, ymax=X95.CI_Number.of.features_upper), position="dodge") +
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1)) +
  scale_y_log10()
ggsave("features_count_barplot_non_TEPS.png", features_barplot_nonTEPS, width=10, height=10, dpi=300)

#plots from fsm_info.csv end