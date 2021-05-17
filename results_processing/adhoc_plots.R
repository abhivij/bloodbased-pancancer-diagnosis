setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results_processing/")
library(tidyverse)
library(viridis)
library(ComplexHeatmap)
source("metadata.R")
source("../utils/utils.R")

setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results/results_breastcanceronly/")

data_info <- read.table('data_info.csv', sep = ',', header = TRUE)
fsm_info <- read.table('fsm_info.csv', sep = ',', header = TRUE)
model_results <- read.table('model_results.csv', sep = ',', header = TRUE)

allowed_datasets <- c('GSE83270_BCVsHC', 'GSE22981_EBCVsHC', 'GSE73002_BCVsNC')

model_results <- model_results %>%
  mutate(FSM = factor(FSM)) %>%
  mutate(Model = factor(Model, levels = model_vector)) %>%
  filter(Model == "L2 Regularized logistic regression") %>%
  filter(DataSetId %in% allowed_datasets) %>%
  arrange(DataSetId)

model_barplot <- ggplot(model_results, aes(x=DataSetId, fill=FSM, y=Mean_AUC)) +
  geom_bar(stat="identity", position="dodge") +
  geom_errorbar( aes(x=DataSetId, ymin=X95.CI_AUC_lower, ymax=X95.CI_AUC_upper), position="dodge") +
  scale_fill_manual(values=c("blue")) +
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1, size=rel(1.5)),
        axis.text.y = element_text(size=rel(1.5), face="italic", hjust=0.95),
        axis.title.x = element_text(size=rel(1.5)),
        axis.title.y = element_text(size=rel(1.5)),
        strip.text = element_text(size=rel(1.2), face="bold"),
        legend.title = element_text(size=rel(1.5)),
        legend.text = element_text(size=rel(1.5))) +
  labs(x = "Data Sets", y = "Mean AUC with 95 CI")

ggsave("AUC_barplot.png", model_barplot, width=20, height=10, dpi=500)


#JI
all_ji_df <- read.table("JI/all_ji.csv", sep = ',', header = TRUE)
all_ji_df <- all_ji_df %>%
  filter(FSM1 == FSM2) %>%
  select(-c(FSM2)) %>%
  filter(FSM1 %in% 't-test') %>%
  filter(DataSetId %in% allowed_datasets) %>%
  rename(c("FSM" = "FSM1")) %>%
  arrange(DataSetId)

ji_barplot <- ggplot(all_ji_df, aes(x=DataSetId, fill=FSM, y=JI)) +
  geom_bar(stat="identity", position="dodge") +
  scale_fill_manual(values=c("green")) +
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1, size=rel(1.5)),
        axis.text.y = element_text(size=rel(1.5), face="italic", hjust=0.95),
        axis.title.x = element_text(size=rel(1.5)),
        axis.title.y = element_text(size=rel(1.5)),
        strip.text = element_text(size=rel(1.2), face="bold"),
        legend.title = element_text(size=rel(1.5)),
        legend.text = element_text(size=rel(1.5))) +
  labs(x = "Data Sets", y = "Jaccard Index")

ggsave("JI_barplot.png", ji_barplot, width=20, height=10, dpi=500)


ji_scatterplot <- ggplot(all_ji_df, aes(x=DataSetId, fill=FSM, y=JI)) +
  geom_point(shape=23, fill="green", color="darkred", size=5) +
  scale_fill_manual(values=c("green")) +
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1, size=rel(1.5)),
        axis.text.y = element_text(size=rel(1.5), face="italic", hjust=0.95),
        axis.title.x = element_text(size=rel(1.5)),
        axis.title.y = element_text(size=rel(1.5)),
        strip.text = element_text(size=rel(1.2), face="bold"),
        legend.title = element_text(size=rel(1.5)),
        legend.text = element_text(size=rel(1.5))) +
  labs(x = "Data Sets", y = "Jaccard Index")

ggsave("JI_scatterplot.png", ji_scatterplot, width=20, height=10, dpi=500)



# tsne plot with iter 1 features

results_dir <- "results/results_breastcanceronly/"



source("../../data_extraction/extract.R")

plot_tsne_iter1 <- function(phenotype_file_name, 
                            read_count_dir_path, read_count_file_name, 
                            skip_row_count = 0, row_count = -1,
                            na_strings = "NA",
                            classification_criteria, filter_expression, classes,
                            extracted_count_file_name = "read_counts.txt",
                            output_label_file_name = "output_labels.txt",
                            dataset_id, cores = 16,
                            results_dir_path = "results_breastcanceronly"){
  print(paste("Pipeline Execution on", dataset_id, classification_criteria))
  
  extracted_count_file_name <- paste(classification_criteria, extracted_count_file_name, sep = "_")
  output_label_file_name <- paste(classification_criteria, output_label_file_name, sep = "_")
  
  setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/")
  data_list <- extract_data(phenotype_file_name, read_count_file_name, read_count_dir_path, 
                            skip_row_count, row_count, na_strings, classification_criteria, filter_expression,
                            extracted_count_file_name, output_label_file_name)
  raw_data_dim <- dim(data_list[[1]])
  
  x <- data_list[[1]]
  x <- as.data.frame(t(as.matrix(x)))
  output_labels <- data_list[[2]]
  
  features_file <- paste(dataset_id, classification_criteria, "features.csv", sep = "_")
  features_info <- read.table(get_file_path(features_file, results_dir), sep = ',', skip = 1, nrows = 1) %>%
    select(-c(1,2))
  
  x_selected <- x[, features_info == 1]
  
  set.seed(1)
  tsne_result <- Rtsne::Rtsne(x_selected, perplexity = 3)
  tsne_df <- data.frame(x = tsne_result$Y[,1], y = tsne_result$Y[,2], Colour = output_labels$Label)
  
  plot_title <- paste(dataset_id, classification_criteria, "tSNE embeddings")
  tsne_plot <- ggplot2::ggplot(tsne_df) +
    ggplot2::geom_point(ggplot2::aes(x = x, y = y, colour = Colour)) +
    ggplot2::labs(colour = "Classes", title = plot_title) +
    ggplot2::xlab("Dimension 1") +
    ggplot2::ylab("Dimension 2")  
  
  plot_file_name <- paste(dataset_id, "tsne_plot.png", sep = "_")
  ggplot2::ggsave(plot_file_name, tsne_plot)
  
  x <- as.data.frame(t(as.matrix(x)))
  classes <- output_labels$Label
  psdR::compare_methods(x, classes,
                        c('CPM'), 
                        perplexity = 3,
                        plot_file_name = paste("psd", plot_file_name, sep = "_"),
                        plot_colour_label = "Classes",
                        plot_title = "tSNE embeddings")
  
  print('test')
  
}  


for (dparg in dataset_pipeline_arguments[c(20:22)]) {
  do.call(plot_tsne_iter1, dparg)
  print(class(dparg))
  print(str(dparg))
}



