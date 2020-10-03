library("XLConnect")
library("stringr")
library(dplyr)
library(tidyr)
library(edgeR)

setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis")

filter_and_normalize <- function(read_count_dir_path, read_count_file, op_file_name){
  x.raw <- read.table(paste(read_count_dir_path, read_count_file, sep="/"), 
                      header=TRUE, row.names=1)
  print("raw read count dim")
  print(dim(x.raw))
  keep <- filterByExpr(x.raw)
  x.filtered <- x.raw[keep, ]
  print("filtered read count dim")
  print(dim(x.filtered))
  x.logcpm <- cpm(x.filtered, log=TRUE)
  x <- scale(x.logcpm)  
  write.table(x, file = paste(read_count_dir_path, op_file_name, sep = "/"), 
              quote=FALSE, sep="\t", row.names=TRUE, col.names=NA)
}

