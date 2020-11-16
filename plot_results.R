setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results/")

library(tidyverse)
library(plotly)
library(viridis)

data_info <- read.table('data_info.csv', sep = ',', header = TRUE)
fsm_info <- read.table('fsm_info.csv', sep = ',', header = TRUE)
model_results <- read.table('model_results.csv', sep = ',', header = TRUE)
# model_results_fullPCA <- read.table('fullPCA/model_results.csv', sep = ',', header = TRUE)

# fsm_info_rfrfe <- read.table('rfrfe_withoutLast2Datasets/fsm_info.csv', sep = ',', header = TRUE)
# model_results_rfrfe <- read.table('rfrfe_withoutLast2Datasets/model_results.csv', sep = ',', header = TRUE)

#plots from model_results.csv start

# model_results_fullPCA <- model_results_fullPCA %>%
#   mutate(FSM = sub(" features", "", FSM)) %>%
#   filter(FSM %in% c('PCA')) %>%
#   mutate(FSM = paste(FSM, 'all', sep = '_'))
# 
# model_results <- rbind(model_results, model_results_fullPCA, model_results_rfrfe)
# model_results <- model_results %>%
#   arrange(DataSetId, FSM, Model)
# 
# fsm_info <- rbind(fsm_info, fsm_info_rfrfe)
# fsm_info <- fsm_info %>%
#   arrange(DataSetId, FSM)

model_results <- model_results %>%
  mutate(FSM = factor(FSM))

pca_model_results <- model_results %>%
  filter(grepl('PCA', FSM, fixed = TRUE))

t_test_model_results <- model_results %>%
  filter(grepl('t-test', FSM, fixed = TRUE))

wilcoxon_model_results <- model_results %>%
  filter(grepl('wilcoxon', FSM, fixed = TRUE))

model_results <- model_results %>%
  filter(FSM %in% c('all', 't-test', 'wilcoxontest', 'PCA_75', 'RF_RFE'))

create_heatmap <- function(model_results, heatmap_file_name){
  all_model_heatmap <- ggplot(model_results, aes(x = FSM, y = DataSetId, fill = Mean_AUC, text = Mean_AUC)) +
    geom_tile(color="black", size=0.5) +
    theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1)) +
    scale_fill_viridis() +
    facet_wrap(facets = vars(Model))
  all_model_heatmap
  # ggplotly(all_model_heatmap, tooltip = "text")
  ggsave(heatmap_file_name, all_model_heatmap, width=10, height=10, dpi=300)                        
}

create_heatmap(model_results = model_results, heatmap_file_name = "all_model_heatmap.png")
create_heatmap(model_results = pca_model_results, heatmap_file_name = "all_model_pca_heatmap.png")
create_heatmap(model_results = t_test_model_results, heatmap_file_name = "all_model_ttest_heatmap.png")
create_heatmap(model_results = wilcoxon_model_results, heatmap_file_name = "all_model_wilcoxon_heatmap.png")


all_model_barplot <- ggplot(model_results, aes(x=DataSetId, fill=FSM, y=Mean_AUC)) +
  geom_bar(stat="identity", position="dodge") +
  geom_errorbar( aes(x=DataSetId, ymin=X95.CI_AUC_lower, ymax=X95.CI_AUC_upper), position="dodge") +
  scale_fill_viridis_d() +
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=1)) +
  facet_wrap(facets = vars(Model))  
ggsave("all_model_barplot.png", all_model_barplot, width=15, height=5, dpi=300)


classification_models <- unique(model_results$Model)
for (cm in classification_models) {
  individual_model <- model_results %>%
    filter(Model == cm)
  model_barplot <- ggplot(individual_model, aes(x=DataSetId, fill=FSM, y=Mean_AUC)) +
    geom_bar(stat="identity", position="dodge") +
    geom_errorbar( aes(x=DataSetId, ymin=X95.CI_AUC_lower, ymax=X95.CI_AUC_upper), position="dodge") +
    scale_fill_viridis_d() +
    theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1)) +
    facet_wrap(facets = vars(Model))  
  plotname <- paste(str_replace(cm, " ", ""), "barplot.png", sep = "_")
  ggsave(plotname, model_barplot, width=15, height=5, dpi=300)
}

#plots from model_results.csv end




#plots from fsm_info.csv start

transformation_fsms <- c('PCA_75')
TEP_datasets <- c('TEP2015_GBMVsHC', 'TEP2015_NSCLCVsHC', 'TEP2015_CancerVsHC', 'TEP2017_NSCLCVsNC')

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
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1)) +
  scale_fill_viridis_d()
ggsave("features_count_barplot_TEPS.png", features_barplot_TEPS, width=10, height=10, dpi=300)

features_barplot_nonTEPS <- ggplot(non_TEP_fsm_info, aes(x=DataSetId, fill=FSM, y=Mean_Number.of.features)) +
  geom_bar(stat="identity", position="dodge") +
  geom_errorbar( aes(x=DataSetId, ymin=X95.CI_Number.of.features_lower, ymax=X95.CI_Number.of.features_upper), position="dodge") +
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1)) +
  scale_y_log10() +
  scale_fill_viridis_d()
ggsave("features_count_barplot_non_TEPS.png", features_barplot_nonTEPS, width=10, height=10, dpi=300)


transformation_fsm_info1 <- transformation_fsm_info %>%
  select(-c(starts_with("X")))

transformation_fsm_info_long1 <- gather_(data = transformation_fsm_info1,
                                        key_col = 'CumVar', 
                                        value_col = 'NumComponents',
                                        gather_cols = c('Mean_Number.of.components.for.Cum.Var.0.5', 
                                                        'Mean_Number.of.components.for.Cum.Var.0.75', 
                                                        'Mean_Number.of.components.for.Cum.Var.0.9',  
                                                        'Mean_Number.of.components.for.Cum.Var.0.95', 
                                                        'Mean_Number.of.components.for.Cum.Var.0.99'))
transformation_fsm_info_long1 <- transformation_fsm_info_long1 %>%
  mutate(CumVar = sub("Mean_Number.of.components.for.Cum.Var.", "", CumVar)) %>%
  mutate(CumVar = factor(CumVar)) %>%
  arrange(DataSetId, FSM)


transformation_fsm_info2 <- transformation_fsm_info %>%
  select(-c(starts_with("Mean"), ends_with("lower")))
transformation_fsm_info_long2 <- gather_(data = transformation_fsm_info2,
                                        key_col = 'CumVar', 
                                        value_col = 'NumComponents95CIU',
                                        gather_cols = c('X95.CI_Number.of.components.for.Cum.Var.0.5_upper', 
                                                        'X95.CI_Number.of.components.for.Cum.Var.0.75_upper', 
                                                        'X95.CI_Number.of.components.for.Cum.Var.0.9_upper',  
                                                        'X95.CI_Number.of.components.for.Cum.Var.0.95_upper', 
                                                        'X95.CI_Number.of.components.for.Cum.Var.0.99_upper'))
transformation_fsm_info_long2 <- transformation_fsm_info_long2 %>%
  mutate(CumVar = sub("X95.CI_Number.of.components.for.Cum.Var.", "", CumVar)) %>%
  mutate(CumVar = sub("_upper", "", CumVar)) %>%
  mutate(CumVar = factor(CumVar)) %>%
  arrange(DataSetId, FSM)
  

  
transformation_fsm_info3 <- transformation_fsm_info %>%
  select(-c(starts_with("Mean"), ends_with("upper")))
transformation_fsm_info_long3 <- gather_(data = transformation_fsm_info3,
                                         key_col = 'CumVar', 
                                         value_col = 'NumComponents95CIL',
                                         gather_cols = c('X95.CI_Number.of.components.for.Cum.Var.0.5_lower', 
                                                         'X95.CI_Number.of.components.for.Cum.Var.0.75_lower', 
                                                         'X95.CI_Number.of.components.for.Cum.Var.0.9_lower',  
                                                         'X95.CI_Number.of.components.for.Cum.Var.0.95_lower', 
                                                         'X95.CI_Number.of.components.for.Cum.Var.0.99_lower'))
transformation_fsm_info_long3 <- transformation_fsm_info_long3 %>%
  mutate(CumVar = sub("X95.CI_Number.of.components.for.Cum.Var.", "", CumVar)) %>%
  mutate(CumVar = sub("_lower", "", CumVar)) %>%
  mutate(CumVar = factor(CumVar)) %>%
  arrange(DataSetId, FSM)

transformation_fsm_info <- transformation_fsm_info_long1 %>%
  inner_join(transformation_fsm_info_long2, by = c("DataSetId", "FSM", "CumVar")) %>%
  inner_join(transformation_fsm_info_long3, by = c("DataSetId", "FSM", "CumVar"))

transformation_cumvar_barplot <- ggplot(transformation_fsm_info, aes(x=DataSetId, fill=CumVar, y=NumComponents)) +
  geom_bar(stat="identity", position="dodge") +
  geom_errorbar( aes(x=DataSetId, ymin=NumComponents95CIL, ymax=NumComponents95CIU), position="dodge") +
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1)) +
  scale_y_log10() +
  scale_fill_viridis_d() +
  facet_wrap(facets = vars(FSM))    
ggsave("transformation_cumvar_barplot.png", transformation_cumvar_barplot, width=10, height=10, dpi=300)
  

TEP_transformation_fsm_info <- transformation_fsm_info %>%
  filter(DataSetId %in% TEP_datasets)
non_TEP_transformation_fsm_info <- transformation_fsm_info %>%
  filter(! DataSetId %in% TEP_datasets)

transformation_cumvar_barplot_TEPS <- ggplot(TEP_transformation_fsm_info, aes(x=DataSetId, fill=CumVar, y=NumComponents)) +
  geom_bar(stat="identity", position="dodge") +
  geom_errorbar( aes(x=DataSetId, ymin=NumComponents95CIL, ymax=NumComponents95CIU), position="dodge") +
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1)) +
  scale_fill_viridis_d() +
  facet_wrap(facets = vars(FSM))    
ggsave("transformation_cumvar_barplot_TEPS.png", transformation_cumvar_barplot_TEPS, width=10, height=10, dpi=300)


transformation_cumvar_barplot_non_TEPS <- ggplot(non_TEP_transformation_fsm_info, aes(x=DataSetId, fill=CumVar, y=NumComponents)) +
  geom_bar(stat="identity", position="dodge") +
  geom_errorbar( aes(x=DataSetId, ymin=NumComponents95CIL, ymax=NumComponents95CIU), position="dodge") +
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1)) +
  scale_fill_viridis_d() +
  facet_wrap(facets = vars(FSM))    
ggsave("transformation_cumvar_barplot_non_TEPS.png", transformation_cumvar_barplot_non_TEPS, width=10, height=10, dpi=300)

#plots from fsm_info.csv end