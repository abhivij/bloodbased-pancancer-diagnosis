setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results_processing/")
library(tidyverse)
library(viridis)
library(ComplexHeatmap)
source("metadata.R")
source("../utils/utils.R")

data_info <- read.table('data_info.csv', sep = ',', header = TRUE)
fsm_info <- read.table('fsm_info.csv', sep = ',', header = TRUE)
model_results <- read.table('model_results.csv', sep = ',', header = TRUE)

model_results <- model_results %>%
  mutate(FSM = factor(FSM)) %>%
  mutate(Model = factor(Model, levels = model_vector)) %>%
  mutate(DataSetId = factor(DataSetId, levels = datasets))

pca_model_results <- model_results %>%
  filter(grepl('PCA', FSM, fixed = TRUE))

t_test_model_results <- model_results %>%
  filter(grepl('t-test', FSM, fixed = TRUE))

wilcoxon_model_results <- model_results %>%
  filter(grepl('wilcoxon', FSM, fixed = TRUE))

model_results <- model_results %>%
  filter(FSM %in% fem_vector) %>%
  mutate(FSM = factor(FSM, levels = fem_vector))

create_heatmap <- function(model_results, heatmap_file_name){
  all_model_heatmap <- ggplot(model_results, aes(x = DataSetId, y = FSM, fill = Mean_AUC)) +
    geom_tile(color="black", size=0.25) +
    ggtitle("Mean AUC") +
    scale_fill_viridis(name = "Mean AUC") +
    ylab("Feature Extraction Methods") +
    facet_wrap(facets = vars(Model)) +
    theme(axis.text.x = element_text(angle=60, hjust=1, vjust=0.99),
          axis.text.y = element_text(size=rel(1.2), face="italic", hjust=0.95),
          axis.title.x = element_text(size=rel(1.5)),
          axis.title.y = element_text(size=rel(1.5), angle=90),
          plot.title = element_text(size=rel(1.75), face="bold", hjust=0.5),
          strip.text = element_text(size=rel(1.2), face="bold"),
          strip.background = element_rect(fill = "grey"),
          legend.title = element_text(size=rel(1.1)))
  ggsave(heatmap_file_name, all_model_heatmap, width=12, height=12, dpi=500)
}

create_heatmap(model_results = model_results, heatmap_file_name = "all_model_heatmap.svg")
create_heatmap(model_results = pca_model_results, heatmap_file_name = "all_model_pca_heatmap.svg")
create_heatmap(model_results = t_test_model_results, heatmap_file_name = "all_model_ttest_heatmap.svg")
create_heatmap(model_results = wilcoxon_model_results, heatmap_file_name = "all_model_wilcoxon_heatmap.svg")


all_model_barplot <- ggplot(model_results, aes(x=DataSetId, fill=FSM, y=Mean_AUC)) +
  geom_bar(stat="identity", position="dodge") +
  geom_errorbar( aes(x=DataSetId, ymin=X95.CI_AUC_lower, ymax=X95.CI_AUC_upper), position="dodge") +
  scale_fill_viridis_d() +
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=1)) +
  facet_wrap(facets = vars(Model))  
ggsave("all_model_barplot.svg", all_model_barplot, width=15, height=5, dpi=300)


classification_models <- unique(model_results$Model)
for (cm in classification_models) {
  individual_model <- model_results %>%
    filter(Model == cm)
  model_barplot <- ggplot(individual_model, aes(x=DataSetId, fill=FSM, y=Mean_AUC)) +
    geom_bar(stat="identity", position="dodge") +
    geom_errorbar( aes(x=DataSetId, ymin=X95.CI_AUC_lower, ymax=X95.CI_AUC_upper), position="dodge") +
    scale_fill_viridis_d() +
    theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1),
          axis.text.y = element_text(size=rel(1.2), face="italic", hjust=0.95),
          strip.text = element_text(size=rel(1.2), face="bold"),
          legend.title = element_text(size=rel(1.2)),
          legend.text = element_text(size=rel(1.1))
          ) +
    facet_wrap(facets = vars(Model))  
  plotname <- paste(str_replace(cm, " ", ""), "barplot.svg", sep = "_")
  ggsave(plotname, model_barplot, width=15, height=10, dpi=500)
}

#plots from model_results.csv end




#plots from fsm_info.csv start

transformation_fsm_info <- fsm_info %>%
  filter(FSM %in% best_pca_transform_vector) %>%
  select(-c(3,4,5))


plot_features_count_barplot <- function(fsm_allowed = fsm_vector, dir_path = "") {
  fsm_info <- fsm_info %>%
    filter(FSM %in% fsm_allowed)
  TEP_fsm_info <- fsm_info %>%
    filter(DataSetId %in% TEP_datasets)
  non_TEP_fsm_info <- fsm_info %>%
    filter(! DataSetId %in% TEP_datasets)
  
  if (dir_path != "" & !dir.exists(dir_path)){
    dir.create(dir_path, recursive = TRUE)
  }
  
  features_barplot_TEPS <- ggplot(TEP_fsm_info, aes(x=DataSetId, fill=FSM, y=Mean_Number.of.features)) +
    geom_bar(stat="identity", position="dodge") +
    geom_errorbar( aes(x=DataSetId, ymin=X95.CI_Number.of.features_lower, ymax=X95.CI_Number.of.features_upper), position="dodge") +
    theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1),
          axis.text.y = element_text(size=rel(1.2), face="italic", hjust=0.95),
          axis.title.x = element_text(size=rel(1.5)),
          axis.title.y = element_text(size=rel(1.5), angle=90),
          legend.title = element_text(size=rel(1.5)),
          legend.text = element_text(size=rel(1.2))) +
    scale_y_log10() +
    scale_fill_viridis_d() +
    ylab("Mean number of features used")
  ggsave(get_file_path("features_count_barplot_TEPS.svg", dir_path),
         features_barplot_TEPS, width=12, height=12, dpi=500)
  
  features_barplot_nonTEPS <- ggplot(non_TEP_fsm_info, aes(x=DataSetId, fill=FSM, y=Mean_Number.of.features)) +
    geom_bar(stat="identity", position="dodge") +
    geom_errorbar( aes(x=DataSetId, ymin=X95.CI_Number.of.features_lower, ymax=X95.CI_Number.of.features_upper), position="dodge") +
    theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1),
          axis.text.y = element_text(size=rel(1.2), face="italic", hjust=0.95),
          axis.title.x = element_text(size=rel(1.5)),
          axis.title.y = element_text(size=rel(1.5), angle=90),
          legend.title = element_text(size=rel(1.5)),
          legend.text = element_text(size=rel(1.2))) +
    scale_y_log10() +
    scale_fill_viridis_d() +
    ylab("Mean number of features used")
  ggsave(get_file_path("features_count_barplot_non_TEPS.svg", dir_path), 
         features_barplot_nonTEPS, width=12, height=12, dpi=500)  
}


plot_features_count_barplot()
plot_features_count_barplot(fsm_allowed = fsm_vector_fil_compare, dir_path = "fil_comp_feature_count")


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
ggsave("transformation_cumvar_barplot.svg", transformation_cumvar_barplot, width=10, height=10, dpi=300)
  

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
ggsave("transformation_cumvar_barplot_TEPS.svg", transformation_cumvar_barplot_TEPS, width=10, height=10, dpi=300)


transformation_cumvar_barplot_non_TEPS <- ggplot(non_TEP_transformation_fsm_info, aes(x=DataSetId, fill=CumVar, y=NumComponents)) +
  geom_bar(stat="identity", position="dodge") +
  geom_errorbar( aes(x=DataSetId, ymin=NumComponents95CIL, ymax=NumComponents95CIU), position="dodge") +
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1)) +
  scale_fill_viridis_d() +
  facet_wrap(facets = vars(FSM))    
ggsave("transformation_cumvar_barplot_non_TEPS.svg", transformation_cumvar_barplot_non_TEPS, width=10, height=10, dpi=300)

#plots from fsm_info.csv end


plot_JI_heatmap <- function(filename = "all_ji.csv", dir = "JI", heatmapfilename = "ji.svg",
                            fsm_allowed = fsm_vector) {
  
  all_ji_df <- read.table(get_file_path(filename, dir), sep = ',', header = TRUE)
  all_ji_df <- all_ji_df %>%
    filter(FSM1 == FSM2) %>%
    select(-c(FSM2)) %>%
    filter(FSM1 %in% fsm_allowed) %>%
    mutate(FSM1 = factor(FSM1, levels = fsm_allowed)) %>%
    pivot_wider(names_from = DataSetId, values_from = JI) %>%
    column_to_rownames(var = "FSM1")
  
  all_ji_mat <- data.matrix(all_ji_df)
  
  row_ha <- rowAnnotation(methods = anno_boxplot(all_ji_mat))
  col_ha <- HeatmapAnnotation(datasets = anno_boxplot(all_ji_mat))
  
  svg(get_file_path(heatmapfilename, dir), 
      width = 8, height = 8)
  ht <- Heatmap(all_ji_mat, name = "Jaccard Index",
                col = viridis(10),
                rect_gp = gpar(col = "white", lwd = 1),
                row_names_side = "left", show_row_dend = FALSE, show_column_dend = FALSE,
                column_names_rot = 45,
                row_names_max_width = max_text_width(rownames(all_ji_mat),
                                                     gp = gpar(fontsize = 12)),
                column_title = "Average pairwise Jaccard Index",
                column_title_gp = gpar(fontsize = 20, fontface = "bold"),
                top_annotation = col_ha, right_annotation = row_ha)
  draw(ht)
  dev.off()
}


plot_JI_heatmap()
plot_JI_heatmap(heatmapfilename = "no_fil_fems_JI.svg", fsm_allowed = fsm_vector_fil_compare)