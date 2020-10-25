setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results/")

library(tidyverse)
library(plotly)

data_info <- read.table('data_info.csv', sep = ',', header = TRUE)
fsm_info <- read.table('fsm_info.csv', sep = ',', header = TRUE)
model_results <- read.table('model_results.csv', sep = ',', header = TRUE)


fsm_info <- fsm_info %>%
            select(-starts_with('X'))

# model_results <- model_results %>%
#   select(-starts_with('X'))

RF_AUC <- model_results %>%
  filter(Model == 'Random Forest')

# datasets <- unique(model_results$DataSetId)
# fsms <- unique(model_results$FSM)

all_model_heatmap <- ggplot(model_results, aes(x = FSM, y = DataSetId, fill = Mean_AUC, text = Mean_AUC)) +
  geom_tile(color="black", size=0.5) +
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1)) +
  facet_wrap(facets = vars(Model))
ggplotly(all_model_heatmap, tooltip = "text")
ggsave("all_model_heatmap.png", all_model_heatmap, width=10, height=10, dpi=300)                        



all_model_barplot <- ggplot(model_results, aes(x=DataSetId, fill=FSM, y=Mean_AUC)) +
  geom_bar(stat="identity", position="dodge") +
  geom_errorbar( aes(x=DataSetId, ymin=X95.CI_AUC_lower, ymax=X95.CI_AUC_upper), position="dodge") +
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1)) +
  facet_wrap(facets = vars(Model))  
ggsave("all_model_barplot.png", all_model_barplot, width=10, height=10, dpi=300)