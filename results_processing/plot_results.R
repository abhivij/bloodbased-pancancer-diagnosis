setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results_processing/")
library(tidyverse)
library(viridis)
library(RColorBrewer)
library(ComplexHeatmap)
source("metadata.R")
source("../utils/utils.R")

data_info <- read.table('data_info.csv', sep = ',', header = TRUE)
fsm_info <- read.table('fsm_info.csv', sep = ',', header = TRUE)
# model_results <- read.table('model_results.csv', sep = ',', header = TRUE)

# model_results <- read.table('model_results.csv', sep = ',', header = TRUE)
model_results <- read.table('model_results_test.csv', sep = ',', header = TRUE)

# fsm_info <- fsm_info %>%
#   distinct(DataSetId, FSM, .keep_all = TRUE)
# 
# model_results <- model_results %>%
#   distinct(DataSetId, FSM, Model, .keep_all = TRUE)


#get last occurrence - since in many cases, there have been reruns and last one is most reliable

data_info <- data_info %>%
  distinct()

fsm_info <- fsm_info %>%
  map_df(rev) %>%
  distinct(DataSetId, FSM, .keep_all = TRUE) %>%
  map_df(rev)

model_results <- model_results %>%
  map_df(rev) %>%
  distinct(DataSetId, FSM, Model, .keep_all = TRUE) %>%
  map_df(rev)

data_info$DataSetId[!data_info$DataSetId %in% datasets]

model_results <- model_results %>%
  mutate(FSM = factor(FSM)) %>%
  mutate(Model = factor(Model, levels = model_vector)) %>%
  mutate(DataSetId = factor(DataSetId, levels = datasets))

summary(model_results$Mean_AUCPR)
model_results <- model_results %>%
  mutate(Mean_AUCPR = case_when(Mean_AUCPR > 1.0 ~ 1.0,
                                TRUE ~ Mean_AUCPR))

summary(model_results$Mean_AUCPR)


# GSM44281fems <- model_results %>%
#   filter(DataSetId == "GSE44281_caseVsnoncase") %>%
#   select(FSM) %>%
#   unique()
# 
# gbm1fems <- model_results %>%
#   filter(DataSetId == "GBM1_GBMvsCont") %>%
#   select(FSM) %>%
#   unique()
# 
# gbm1fems$FSM[!gbm1fems$FSM %in% GSM44281fems$FSM]

unique(model_results$FSM)
summary(model_results$FSM)
summary(model_results$Model)
summary(model_results$DataSetId)

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

# mrmr_model_results <- model_results %>%
#   filter(grepl("mrmr", FSM, fixed = TRUE))
# unique(mrmr_model_results$FSM)
# using only 9

mrmr_model_results <- model_results %>%
    filter(FSM %in% c("mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100",
                      "mrmr_perc25", "mrmr_perc50", "mrmr_perc75"))
unique(mrmr_model_results$FSM)


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
unique(model_results$FSM)

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

#create extracted dataset table
orig_data_info <- read.csv("../data/Datasets - FinalDatasets.csv") %>%
  rename("DataSetName" = "Dataset.Name") %>%
  rename("CancerType" = "Cancer.Type") %>%
  select(DataSetName, CancerType, Tissue, Biomarker, Technology)
data_info_to_write <- data_info %>%
  separate(DataSetId, into = c("DataSetName", "ClassificationCriteria"), remove = FALSE) %>%
  arrange(DataSetId)
data_info_to_write <- orig_data_info %>%
  select(DataSetName) %>%
  inner_join(data_info_to_write)
data_info_to_write <- data_info_to_write %>%
  select(-c(DataSetName, ClassificationCriteria)) %>%
  rownames_to_column("ID")
colnames(data_info_to_write) <- c("ID", "Extracted dataset name",
                                  "Number of samples", 
                                  "Positive class", "Number of samples from positive class",
                                  "Negative class", "Number of samples from negative class",
                                  "Number of transcripts")
write.csv(data_info_to_write, "../data/Datasets-FinalExtractedDatasets.csv", row.names = FALSE)


####### end of create extracted dataset table


# heatmap_file_name <- "labelled_AUC_heatmap.pdf"
metric = "Mean_AUC"
is_ranger = FALSE
create_labelled_heatmap <- function(model_results, heatmap_file_name, metric = "Mean_AUC",
                                    is_ranger = FALSE){
  orig_data_info <- read.csv("../data/Datasets - FinalDatasets.csv") %>%
    rename("DataSetName" = "Dataset.Name") %>%
    rename("CancerType" = "Cancer.Type") %>%
    select(DataSetName, CancerType, Tissue, Biomarker, Technology)
  
  extracted_data_info <- read.csv("../data/Datasets-FinalExtractedDatasets.csv") %>%
    rename("DataSetId" = "Extracted.dataset.name") %>%
    select(ID, DataSetId) %>%
    mutate(ID = factor(ID))
  
  # %>%
  #   mutate(ID = factor(ID, levels = sapply(X = c(1:23), FUN = toString)))

  # model_results[["Mean_PPV"]] <- mean(model_results[["X95.CI_PPV_lower"]], model_results[["X95.CI_PPV_upper"]], trim = 0)
  # model_results[["Mean_NPV"]] <- mean(model_results[["X95.CI_NPV_lower"]], model_results[["X95.CI_NPV_upper"]], trim = 0)
  # model_results[["Mean_F1"]] <- mean(model_results[["X95.CI_F1_lower"]], model_results[["X95.CI_F1_upper"]], trim = 0)
  # 
  data_to_plot_all_models <- model_results %>%
    select(DataSetId, Model, FSM, all_of(metric)) 
  
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
      pivot_wider(names_from = FSM, values_from = all_of(metric)) %>%
      column_to_rownames(var = "ID")
    
    data_to_plot <- data.matrix(data_to_plot)
    # if(metric %in% c("Mean_PPV", "Mean_NPV", "Mean_F1")){
    #   metric <- paste("95CI", metric, sep = "_")
    # }
    
    h <- Heatmap(data_to_plot, name = metric,
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
    h_all[["Elastic net logistic regression"]] + 
    h_all[["Sigmoid Kernel SVM"]] + 
    h_all[["Radial Kernel SVM"]] +
    h_all[["Random Forest"]]

  draw(heatmap_fig, 
       column_title = "Feature Extraction Methods", column_title_side = "bottom",
       column_title_gp = gpar(fontsize = 18),
       row_title = "Dataset ID",
       row_title_gp = gpar(fontsize = 18),
       heatmap_legend_side = "left")
  
  dev.copy2eps(file = heatmap_file_name,
           width = 20, height = 10)
  dev.off()
  
}
create_labelled_heatmap(model_results, "labelled_AUC_heatmap.eps")
create_labelled_heatmap(pca_model_results, "pca_labelled_AUC_heatmap.eps")
create_labelled_heatmap(t_test_model_results, "ttest_labelled_AUC_heatmap.eps")
create_labelled_heatmap(wilcoxon_model_results, "wilcoxon_labelled_AUC_heatmap.eps")
create_labelled_heatmap(ranger_model_results, "ranger_labelled_AUC_heatmap.eps", is_ranger = TRUE)

create_labelled_heatmap(mrmr_model_results, "mrmr_labelled_AUC_heatmap.eps")

create_labelled_heatmap(model_results, "labelled_Accuracy_heatmap.eps", metric = "Mean_Accuracy")
create_labelled_heatmap(model_results, "labelled_AUCPR_heatmap.eps", metric = "Mean_AUCPR")
create_labelled_heatmap(model_results, "labelled_F1_heatmap.eps", metric = "Mean_F1")
# create_labelled_heatmap(model_results, "labelled_F1_lower_heatmap.eps", metric = "X95.CI_F1_lower")

create_labelled_heatmap(model_results, "labelled_TPR_heatmap.eps", metric = "Mean_TPR")
create_labelled_heatmap(model_results, "labelled_TNR_heatmap.eps", metric = "Mean_TNR")

# create_labelled_heatmap(model_results, "labelled_PPV_heatmap.eps", metric = "Mean_PPV")
# create_labelled_heatmap(model_results, "labelled_NPV_heatmap.eps", metric = "Mean_NPV")

summary(model_results$Mean_AUCPR)

subset <- model_results %>% 
  filter(Model != "Simple logistic regression")
summary(subset$Mean_AUCPR)

problem <- subset %>%
  filter(Mean_AUCPR > 1)

problem <- model_results %>%
  filter(Mean_AUCPR > 1)


summary(model_results$Mean_AUC)
summary(model_results$Mean_Accuracy)
summary(model_results$Mean_TPR)
summary(model_results$Mean_TNR)
summary(model_results$Mean_PPV)
summary(model_results$Mean_NPV)
summary(model_results$Mean_F1)
summary(model_results$X95.CI_F1_lower)
summary(model_results$X95.CI_F1_upper)

problem <- model_results %>%
  filter(is.na(Mean_F1))


all_model_barplot <- ggplot(model_results, aes(x=DataSetId, fill=FSM, y=Mean_AUC)) +
  geom_bar(stat="identity", position="dodge") +
  geom_errorbar( aes(x=DataSetId, ymin=X95.CI_AUC_lower, ymax=X95.CI_AUC_upper), position="dodge") +
  scale_fill_viridis_d() +
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=1)) +
  facet_wrap(facets = vars(Model))  
all_model_barplot

ggsave("all_model_barplot.pdf", all_model_barplot, width=15, height=5, dpi=300)


classification_models <- unique(model_results$Model)
for (cm in classification_models) {
  # cm <- classification_models[3]
  
  individual_model <- model_results %>%
    filter(Model == cm)
  
  orig_data_info <- read.csv("../data/Datasets - FinalDatasets.csv") %>%
    rename("DataSetName" = "Dataset.Name") %>%
    rename("CancerType" = "Cancer.Type") %>%
    select(DataSetName, CancerType, Tissue, Biomarker, Technology)
  
  extracted_data_info <- read.csv("../data/Datasets-FinalExtractedDatasets.csv") %>%
    rename("DataSetId" = "Extracted.dataset.name") %>%
    select(ID, DataSetId) %>%
    # mutate(ID = factor(ID, levels = sapply(X = c(1:23), FUN = toString))) %>%
    mutate(ID = factor(ID)) %>%
    arrange(ID)
  
  dataset_meta <- extracted_data_info %>%
    separate(DataSetId, sep = "_", into = c("DataSetName", NA), remove = FALSE, extra = "drop") %>%
    inner_join(orig_data_info) 
  dataset_meta <- dataset_meta %>%
    mutate(Tissue = factor(Tissue, levels = c("EV", "TEP", "Serum", "Blood"))) %>%
    mutate(Technology = factor(Technology))
  
  #if only one ranger method present, name it as just 'ranger'
  if(!"ranger_impu" %in% unique(individual_model$FSM)){
    individual_model <- individual_model %>%
      mutate(FSM = gsub("ranger_impu_cor", "ranger", FSM))
  }
  
  individual_model <- individual_model %>%
    mutate(DataSetId = factor(DataSetId, levels = unique(extracted_data_info$DataSetId)))
  
  for(t in list("EV", "TEP", c("Serum", "Blood"))){
  
    # t <- c("Serum", "Blood")
    print(t)
    t_datasets <- dataset_meta %>%
      filter(Tissue %in% t)
    
    if(length(t) == 1){
      t_lab <- t
    } else{
      t_lab <- paste(t[1], "and", t[2])
    }
    
    for(method_type in c("Feature selection methods", "Transformation methods")){
      # method_type = "Feature selection methods"
      
      if(method_type == "Feature selection methods"){
        methods <- fsm_vector
      } else{
        methods <- dr_vector
      }
      individual_model_tm <- individual_model %>%
        filter(DataSetId %in% unique(t_datasets$DataSetId),
               FSM %in% methods) 
      
      ggplot(individual_model_tm, aes(x=DataSetId, fill=FSM, y=Mean_AUC)) +
        geom_bar(stat="identity", 
                 width = 0.6,
                 position=position_dodge(width = 0.9)) +
        geom_errorbar( aes(x=DataSetId, ymin=X95.CI_AUC_lower, ymax=X95.CI_AUC_upper), 
                       position=position_dodge(width = 0.9), width = 0.6) +
        scale_fill_viridis_d() +
        xlab("Extracted Dataset Name") +
        ylab("Mean AUC") + 
        labs(fill = "Feature Extraction Methods") +
        ggtitle(paste("Mean and 95% Confidence Interval of AUC for", cm, 
                      "in", t_lab, "datasets")) +
        theme(plot.title = element_text(size=rel(1.3), face = "bold", hjust = 0.5),
              axis.text.x = element_text(size=rel(1.2), hjust=1, vjust=1, angle = 45),
              axis.text.y = element_text(size=rel(1.2), face="italic", hjust=0.95),
              axis.title.x = element_text(size=rel(1.3)),
              axis.title.y = element_text(size=rel(1.3), angle=90)
        )  
      plotname <- paste("results_Mean_AUC",
                        gsub(" ", "", cm, fixed = TRUE), 
                        gsub(" ", "", method_type, fixed = TRUE),
                        gsub(" ", "", t_lab, fixed = TRUE),
                        "barplot.eps", sep = "_")
      ggsave(plotname, width=20, height=10, dpi=500)
    }
  }
}

#plots from model_results.csv end




#plots from fsm_info.csv start

transformation_fsm_info <- fsm_info %>%
  filter(FSM %in% best_pca_transform_vector) %>%
  select(-c(3,4,5))

# fsm_allowed = fsm_vector
# dir_path = ""
plot_features_count_barplot <- function(fsm_allowed = fsm_vector, dir_path = "",
                                        colour_name = "Set1") {
  extracted_data_info <- read.csv("../data/Datasets-FinalExtractedDatasets.csv") %>%
    rename("DataSetId" = "Extracted.dataset.name") %>%
    select(ID, DataSetId) %>%
    mutate(ID = factor(ID)) %>%
    # mutate(ID = factor(ID, levels = sapply(X = c(1:23), FUN = toString))) %>%
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
    
  
  ggsave(get_file_path("features_count_barplot.eps", dir_path), 
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

plot_JI_heatmap <- function(filename = "all_ji.csv", dir = "JI", heatmapfilename = "ji.eps",
                            fsm_allowed = fsm_vector) {
  
  all_ji_df <- read.table(get_file_path(filename, dir), sep = ',', header = TRUE)
  all_ji_df <- all_ji_df %>%
    filter(FSM1 == FSM2) %>%
    select(-c(FSM2)) %>%
    filter(FSM1 %in% fsm_allowed) 
  
  #if only one ranger method present, name it as just 'ranger'
  
  # if(!"ranger_impu" %in% unique(fsm_info_to_plot$FSM)){
    
    all_ji_df <- all_ji_df %>%
      mutate(FSM1 = gsub("ranger_impu_cor", "ranger", FSM1))
  #   
  # }
  
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
  
  dev.copy2eps(file = get_file_path(heatmapfilename, dir),
           width = 10, height = 8)
  dev.off()
}


plot_JI_heatmap()
plot_JI_heatmap(heatmapfilename = "no_fil_fems_JI.pdf", fsm_allowed = fsm_vector_fil_compare)
