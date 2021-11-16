setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results_processing/")
library(tidyverse)
library(viridis)
library(RColorBrewer)
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

unique(model_results$FSM)

get_missing <- function(model_results, datasetid){
  model_results_datasetid <- model_results %>%
    filter(DataSetId == datasetid)
  print(unique(model_results$FSM)[!unique(model_results$FSM) %in% unique(model_results_datasetid$FSM)])  
}

get_missing(model_results, "TEP2017_NSCLCVsNC")
get_missing(model_results, "GSE71008_CRCVsHC")
get_missing(model_results, "TEP2015_CancerVsHC")
get_missing(model_results, "TEP2015_NSCLCVsHC")
get_missing(model_results, "TEP2015_GBMVsHC")
get_missing(model_results, "GSE44281_caseVsnoncase")
get_missing(model_results, "GSE73002_BCVsNC")

pca_model_results <- model_results %>%
  filter(grepl('PCA', FSM, fixed = TRUE))

t_test_model_results <- model_results %>%
  filter(grepl('t-test', FSM, fixed = TRUE))

wilcoxon_model_results <- model_results %>%
  filter(grepl('wilcoxon', FSM, fixed = TRUE))

ranger_model_results <- model_results %>%
  filter(FSM %in% ranger_fems)
unique(ranger_model_results$FSM)

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
create_heatmap(model_results = model_results, heatmap_file_name = "all_model_heatmap.pdf")
create_heatmap(model_results = pca_model_results, heatmap_file_name = "all_model_pca_heatmap.png")
create_heatmap(model_results = t_test_model_results, heatmap_file_name = "all_model_ttest_heatmap.png")
create_heatmap(model_results = wilcoxon_model_results, heatmap_file_name = "all_model_wilcoxon_heatmap.png")



# heatmap_file_name <- "labelled_AUC_heatmap.pdf"
create_labelled_heatmap <- function(model_results, heatmap_file_name, 
                                    is_ranger = FALSE){
  
  orig_data_info <- read.csv("../data/Datasets-FinalDatasets.csv") %>%
    rename("DataSetName" = "Dataset.Name") %>%
    rename("CancerType" = "Cancer.Type") %>%
    select(DataSetName, CancerType, Tissue, Biomarker, Technology)
  
  extracted_data_info <- read.csv("../data/Datasets-FinalExtractedDatasets.csv") %>%
    rename("DataSetId" = "Extracted.dataset.name") %>%
    select(ID, DataSetId) %>%
    mutate(ID = factor(ID, levels = sapply(X = c(1:23), FUN = toString)))
  
  data_to_plot_all_models <- model_results %>%
    select(DataSetId, Model, FSM, Mean_AUC) 
  
  if(!is_ranger){
    data_to_plot_all_models <- data_to_plot_all_models %>%
      mutate(FSM = gsub("ranger_impu_cor", "ranger", FSM))     
  }
  
  data_to_plot_all_models <- data_to_plot_all_models %>%
    inner_join(extracted_data_info) 
  data_to_plot_all_models <- data_to_plot_all_models %>%
    select(-c(DataSetId)) %>%
    arrange(ID)
  
  h_all <- list()
  for(model in model_vector){
    # model <- "L2 Regularized logistic regression"
    data_to_plot <- data_to_plot_all_models %>%
      filter(Model == model) %>%
      select(-c(Model)) 
    
    data_to_plot <- data_to_plot %>%
      pivot_wider(names_from = FSM, values_from = Mean_AUC) %>%
      column_to_rownames(var = "ID")
    
    data_to_plot <- data.matrix(data_to_plot)
    
    h <- Heatmap(data_to_plot, name = "Mean AUC",
                 column_title = sub("Regularized", "reg", model),
                 col = viridis(10),
                 rect_gp = gpar(col = "black", lwd = 1),
                 border = TRUE,
                 row_names_side = "left", 
                 cluster_rows = FALSE,
                 show_column_dend = FALSE)
                
    h_all[[model]] <- h
  }
  
  
  dataset_meta <- extracted_data_info %>%
    separate(DataSetId, sep = "_", into = c("DataSetName", NA), remove = FALSE, extra = "drop") %>%
    inner_join(orig_data_info) 
  dataset_meta <- dataset_meta %>%
    mutate(Tissue = factor(Tissue, levels = c("EV", "TEP", "Serum", "Blood"))) %>%
    mutate(Technology = factor(Technology))
  col_vec <- brewer.pal(n = 6, name = "Paired")
  row_annotation <- HeatmapAnnotation(
    "id" = anno_text(dataset_meta$ID, location = unit(1, 'npc'), just = "right"),
    "Dataset Tissue Type" = dataset_meta$Tissue,
    "Dataset Technology" = dataset_meta$Technology,
    col = list("Dataset Tissue Type" = setNames(col_vec[3:6], 
                                        levels(dataset_meta$Tissue)),
               "Dataset Technology" = setNames(col_vec[1:2], levels(dataset_meta$Technology))
    ),
    which = "row",
    show_annotation_name = FALSE,
    border = TRUE,
    gp = gpar(col = "black", lwd = 1),
    gap = unit(1, units = "mm")
  )
  
  heatmap_fig <- row_annotation +
    h_all[["Simple logistic regression"]] + 
    h_all[["L1 Regularized logistic regression"]] +
    h_all[["L2 Regularized logistic regression"]] + 
    h_all[["Sigmoid Kernel SVM"]] + 
    h_all[["Radial Kernel SVM"]] +
    h_all[["Random Forest"]]

  draw(heatmap_fig, 
       column_title = "Feature Extraction Methods", column_title_side = "bottom",
       column_title_gp = gpar(fontsize = 18),
       row_title = "Dataset ID",
       row_title_gp = gpar(fontsize = 18),
       heatmap_legend_side = "left")
  
  dev.copy(pdf, heatmap_file_name,
           width = 20, height = 10)
  dev.off()
  
}
create_labelled_heatmap(model_results, "labelled_AUC_heatmap.pdf")
create_labelled_heatmap(pca_model_results, "pca_labelled_AUC_heatmap.pdf")
create_labelled_heatmap(t_test_model_results, "ttest_labelled_AUC_heatmap.pdf")
create_labelled_heatmap(wilcoxon_model_results, "wilcoxon_labelled_AUC_heatmap.pdf")
create_labelled_heatmap(ranger_model_results, "ranger_labelled_AUC_heatmap.pdf", is_ranger = TRUE)

all_model_barplot <- ggplot(model_results, aes(x=DataSetId, fill=FSM, y=Mean_AUC)) +
  geom_bar(stat="identity", position="dodge") +
  geom_errorbar( aes(x=DataSetId, ymin=X95.CI_AUC_lower, ymax=X95.CI_AUC_upper), position="dodge") +
  scale_fill_viridis_d() +
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=1)) +
  facet_wrap(facets = vars(Model))  
ggsave("all_model_barplot.pdf", all_model_barplot, width=15, height=5, dpi=300)


classification_models <- unique(model_results$Model)
for (cm in classification_models) {
  individual_model <- model_results %>%
    filter(Model == cm)
  
  extracted_data_info <- read.csv("../data/Datasets-FinalExtractedDatasets.csv") %>%
    rename("DataSetId" = "Extracted.dataset.name") %>%
    select(ID, DataSetId) %>%
    mutate(ID = factor(ID, levels = sapply(X = c(1:23), FUN = toString))) %>%
    arrange(ID)
  
  #if only one ranger method present, name it as just 'ranger'
  if(!"ranger_impu" %in% unique(individual_model$FSM)){
    individual_model <- individual_model %>%
      mutate(FSM = gsub("ranger_impu_cor", "ranger", FSM))
  }
  
  individual_model <- individual_model %>%
    mutate(DataSetId = factor(DataSetId, levels = unique(extracted_data_info$DataSetId)))
  
  ggplot(individual_model, aes(x=DataSetId, fill=FSM, y=Mean_AUC)) +
    geom_bar(stat="identity", position="dodge") +
    geom_errorbar( aes(x=DataSetId, ymin=X95.CI_AUC_lower, ymax=X95.CI_AUC_upper), position="dodge") +
    scale_fill_viridis_d() +
    xlab("Extracted Dataset Name") +
    ylab("Mean AUC") + 
    labs(fill = "Feature Extraction Methods") +
    ggtitle(paste("Mean and 95% Confidence Interval of AUC for", cm)) +
    theme(plot.title = element_text(size=rel(1.4), face = "bold", hjust = 0.5),
          axis.text.x = element_text(size=rel(1.2), hjust=1, vjust=1, angle = 45),
          axis.text.y = element_text(size=rel(1.2), face="italic", hjust=0.95),
          axis.title.x = element_text(size=rel(1.3)),
          axis.title.y = element_text(size=rel(1.3), angle=90)
          )  
  plotname <- paste(gsub(" ", "", cm, fixed = TRUE), "barplot.pdf", sep = "_")
  ggsave(plotname, width=20, height=10, dpi=500)
}

#plots from model_results.csv end




#plots from fsm_info.csv start

transformation_fsm_info <- fsm_info %>%
  filter(FSM %in% best_pca_transform_vector) %>%
  select(-c(3,4,5))

# fsm_allowed = fsm_vector
# dir_path = ""
plot_features_count_barplot <- function(fsm_allowed = fsm_vector, dir_path = "",
                                        colour_name = "Set2") {
  extracted_data_info <- read.csv("../data/Datasets-FinalExtractedDatasets.csv") %>%
    rename("DataSetId" = "Extracted.dataset.name") %>%
    select(ID, DataSetId) %>%
    mutate(ID = factor(ID, levels = sapply(X = c(1:23), FUN = toString))) %>%
    arrange(ID)
  
  unique(extracted_data_info$DataSetId)
  
  fsm_info_to_plot <- fsm_info %>%
    filter(FSM %in% fsm_allowed)
  
  #if only one ranger method present, name it as just 'ranger'
  if(!"ranger_impu" %in% unique(fsm_info_to_plot$FSM)){
    fsm_info_to_plot <- fsm_info_to_plot %>%
      mutate(FSM = gsub("ranger_impu_cor", "ranger", FSM))
  }
  
  fsm_info_to_plot <- fsm_info_to_plot %>%
    mutate(DataSetId = factor(DataSetId, levels = unique(extracted_data_info$DataSetId)))
  
  if (dir_path != "" & !dir.exists(dir_path)){
    dir.create(dir_path, recursive = TRUE)
  }
  
  ylim <- max(fsm_info_to_plot$X95.CI_Number.of.features_upper)
  ggplot(fsm_info_to_plot, aes(x=DataSetId, fill=FSM, y=Mean_Number.of.features)) +
    geom_bar(stat="identity", position="dodge") +
    geom_errorbar( aes(x=DataSetId, ymin=X95.CI_Number.of.features_lower, ymax=X95.CI_Number.of.features_upper), position="dodge") +
    scale_y_log10(limits=c(1, ylim)) +
    #setting lower limit to 1 (log0) because for some datasets almost no features get selected
    #       and 95CI become -ve
    scale_fill_manual(values = brewer.pal(n = length(fsm_allowed), name = colour_name)) +
    xlab("Extracted Dataset Name") +
    ylab("Number of features") + 
    labs(fill = "Feature Selection Methods") +
    ggtitle("Mean and 95% Confidence Interval of features used") +
    theme(plot.title = element_text(size=rel(1.2), face = "bold", hjust = 0.5),
          axis.text.x = element_text(hjust=1, vjust=1, angle = 45),
          axis.text.y = element_text(size=rel(1.2), face="italic", hjust=0.95),
          axis.title.x = element_text(size=rel(1.2)),
          axis.title.y = element_text(size=rel(1.2), angle=90),
          legend.title = element_text(size=rel(1.2)),
          legend.text = element_text(size=rel(1.2)),
          legend.position = "bottom",
          legend.background = element_rect(fill="gray93"))
    
  
  ggsave(get_file_path("features_count_barplot.pdf", dir_path), 
         width=12, height=8, dpi=500)  
}


plot_features_count_barplot()
plot_features_count_barplot(fsm_allowed = fsm_vector_fil_compare, 
                            dir_path = "fil_comp_feature_count",
                            colour_name = "Paired")


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


# filename = "all_ji.csv"
# dir = "JI"
# heatmapfilename = "ji.pdf"
# fsm_allowed = fsm_vector

plot_JI_heatmap <- function(filename = "all_ji.csv", dir = "JI", heatmapfilename = "ji.pdf",
                            fsm_allowed = fsm_vector) {
  
  all_ji_df <- read.table(get_file_path(filename, dir), sep = ',', header = TRUE)
  all_ji_df <- all_ji_df %>%
    filter(FSM1 == FSM2) %>%
    select(-c(FSM2)) %>%
    filter(FSM1 %in% fsm_allowed) 
  
  #if only one ranger method present, name it as just 'ranger'
  if(!"ranger_impu" %in% unique(fsm_info_to_plot$FSM)){
    all_ji_df <- all_ji_df %>%
      mutate(FSM1 = gsub("ranger_impu_cor", "ranger", FSM1))
  }
  
  all_ji_df <- all_ji_df %>%
    mutate(FSM1 = factor(FSM1)) %>%
    pivot_wider(names_from = DataSetId, values_from = JI) %>%
    column_to_rownames(var = "FSM1")
  
  
  
  all_ji_mat <- data.matrix(all_ji_df)
  
  
  # commented code below is to add dataset annotation 
  # does not seem to add much value in this plot - so avoiding
  
  # orig_data_info <- read.csv("../data/Datasets-FinalDatasets.csv") %>%
  #   rename("DataSetName" = "Dataset.Name") %>%
  #   rename("CancerType" = "Cancer.Type") %>%
  #   select(DataSetName, CancerType, Tissue, Biomarker, Technology)
  # extracted_data_info <- read.csv("../data/Datasets-FinalExtractedDatasets.csv") %>%
  #   rename("DataSetId" = "Extracted.dataset.name") %>%
  #   select(ID, DataSetId) %>%
  #   mutate(ID = factor(ID, levels = sapply(X = c(1:23), FUN = toString))) %>%
  #   arrange(ID)
  # dataset_meta <- extracted_data_info %>%
  #   separate(DataSetId, sep = "_", into = c("DataSetName", NA), remove = FALSE, extra = "drop") %>%
  #   inner_join(orig_data_info)
  # dataset_meta <- dataset_meta %>%
  #   mutate(Tissue = factor(Tissue, levels = c("EV", "TEP", "Serum", "Blood"))) %>%
  #   mutate(Technology = factor(Technology))
  # col_vec <- brewer.pal(n = 6, name = "Paired")
  # col_ha_2 <- HeatmapAnnotation(
  #   "Dataset Tissue Type" = dataset_meta$Tissue,
  #   "Dataset Technology" = dataset_meta$Technology,
  #   col = list("Dataset Tissue Type" = setNames(col_vec[3:6],
  #                                               levels(dataset_meta$Tissue)),
  #              "Dataset Technology" = setNames(col_vec[1:2], levels(dataset_meta$Technology))
  #   ),
  #   which = "column",
  #   show_annotation_name = FALSE,
  #   border = TRUE,
  #   gp = gpar(col = "black", lwd = 1),
  #   gap = unit(1, units = "mm")
  # )
  
  row_ha <- rowAnnotation(methods = anno_boxplot(all_ji_mat), 
                          show_annotation_name = FALSE)
  col_ha <- HeatmapAnnotation(datasets = anno_boxplot(all_ji_mat), 
                          show_annotation_name = FALSE)
  
  ht <- Heatmap(all_ji_mat, name = "Jaccard Index",
                col = viridis(10),
                rect_gp = gpar(col = "white", lwd = 1),
                row_names_side = "left", show_row_dend = FALSE, show_column_dend = FALSE,
                column_names_rot = 45,
                row_names_max_width = max_text_width(rownames(all_ji_mat),
                                                     gp = gpar(fontsize = 12)),
                row_title = "Feature Selection Method",
                row_title_gp = gpar(fontsize = 15),
                column_title = "Extracted Dataset Name",
                column_title_gp = gpar(fontsize = 15),
                column_title_side = "bottom",
                top_annotation = col_ha, right_annotation = row_ha)
  draw(ht,
       column_title = "Average pairwise Jaccard Index",
       column_title_gp = gpar(fontsize = 20, fontface = "bold"))
  
  dev.copy(pdf, get_file_path(heatmapfilename, dir),
           width = 10, height = 8)
  dev.off()
}


plot_JI_heatmap()
plot_JI_heatmap(heatmapfilename = "no_fil_fems_JI.pdf", fsm_allowed = fsm_vector_fil_compare)
