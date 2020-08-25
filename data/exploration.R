library("XLConnect")
library("stringr")
library(dplyr)
library(tidyr)

setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/data")

gbm_1 <- read.table("GBM/1/GSE122488_normalized_microRNA_counts.txt", 
                                      header=TRUE, row.names=1, skip=3)
path <- "GBM/2/GSE112462_RAW/"
file.names <- dir(path, pattern =".gz")
for(i in 1:length(file.names)){
  sample <- str_extract(file.names[i], "(?<=_)[^/.]*")
  print(sample)
  file_path = paste(path, file.names[i], sep="")
  gbm_sub <- read.table(file_path, header=FALSE, skip=51)
  gbm_sub <- read.table(file_path, header=FALSE, skip=51, nrow=nrow(gbm_sub)-3, sep=",")
  gbm_sub <- filter(gbm_sub, V1=='Endogenous1') %>% select(V2, V4)
  names(gbm_sub) <- c("transcripts", sample)
  gbm_sub$transcripts <- str_sub(gbm_sub$transcripts, end=-3)
  print(tail(gbm_sub))
  if (i == 1){
    gbm_2 <- gbm_sub
  }
  else{
    gbm_2 <- cbind(gbm_2, gbm_sub[sample])  
  }
  
}



lung_1 <- read.table("LungCancer/1/GSE111803_Readcount_TPM.txt", header = TRUE)

lung_wb <- loadWorkbook("LungCancer/2/176791_2_supp_4043545_kq2mmk.xlsx", create = FALSE)
lung_2 <- readWorksheet(lung_wb, sheet="miRNA-Seq data")

lung_3 <- ""
path <- "LungCancer/3/GSE114711_RAW/"
file.names <- dir(path, pattern =".txt.gz")
for(i in 1:length(file.names)){
  sample <- str_extract(file.names[i], "(?<=_)[:alnum:]*") 
  print(sample)
  file_path = paste(path, file.names[i], sep="")
  lung_3_sub <- read.table(file_path, col.names = c("Transcripts", sample))
  lung_3 <- cbind(lung_3, lung_3_sub)
}
