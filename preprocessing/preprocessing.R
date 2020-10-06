library("XLConnect")
library("stringr")
library(dplyr)
library(tidyr)
library(edgeR)

setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis")

filter_and_normalize <- function(read_count_dir_path, read_count_file, op_file_name, extracted_data_list){
  # x.raw <- read.table(paste(read_count_dir_path, read_count_file, sep="/"), 
  #                     header=TRUE, row.names=1)
  x.raw <- extracted_data_list[[1]]
  output_labels <- extracted_data_list[[2]]
  print("raw read count dim")
  print(dim(x.raw))
  print("output label dim")
  print(dim(output_labels))
  keep <- filterByExpr(x.raw, group = output_labels$Label, min.count = round(dim(x.raw)[1]/3))
  x.filtered <- x.raw[keep, ]
  print("filtered read count dim")
  print(dim(x.filtered))
  x.logcpm <- cpm(x.filtered, log=TRUE)
  x <- scale(x.logcpm)  
  write.table(x, file = paste(read_count_dir_path, op_file_name, sep = "/"), 
              quote=FALSE, sep="\t", row.names=TRUE, col.names=NA)
}

