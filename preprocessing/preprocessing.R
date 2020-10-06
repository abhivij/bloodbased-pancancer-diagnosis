library("XLConnect")
library("stringr")
library(dplyr)
library(tidyr)
library(edgeR)

setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis")

filter_and_normalize <- function(extracted_data_list, dir_path, op_file_name){
  x.raw <- extracted_data_list[[1]]
  output_labels <- extracted_data_list[[2]]
  print("raw read count dim")
  print(dim(x.raw))
  print("output label dim")
  print(dim(output_labels))
  keep <- filterByExpr(x.raw, group = output_labels$Label)
  x.filtered <- x.raw[keep, ]
  print("filtered read count dim")
  print(dim(x.filtered))
  x.logcpm <- cpm(x.filtered, log=TRUE)
  x.scaled <- scale(x.logcpm)  
  write.table(x.scaled, file = paste(dir_path, op_file_name, sep = "/"), 
              quote=FALSE, sep="\t", row.names=TRUE, col.names=NA)
  filtered_data_list <- list(x.scaled, output_labels)
  return (filtered_data_list)
}

