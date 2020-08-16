require("XLConnect")

setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/data")

gbm_1 <- read.table("GBM/1/GSE122488_normalized_microRNA_counts.txt", 
                                      header=TRUE, row.names=1, skip=3)

gbm_bbcancer <- read.table("GBM/Others/bbcancer/Glioblastoma-EVs.miRNA.exprLevel/Glioblastoma-EVs-miRNA/miRNA.GBM_O1.expression.txt", header=TRUE)

lung_1 <- read.table("LungCancer/1/GSE111803_Readcount_TPM.txt", header = TRUE)

lung_wb <- loadWorkbook("LungCancer/2/176791_2_supp_4043545_kq2mmk.xlsx", create = FALSE)
lung_2 <- readWorksheet(lung_wb, sheet="miRNA-Seq data")

lung_3 <- ""
path <- "LungCancer/3/GSE114711_RAW/"
file.names <- dir(path, pattern =".txt.gz")
for(i in 1:length(file.names)){
  sample <- str_extract(file.names[i], "(?<=_)[:alnum:]*") 
  file_path = paste(path, file.names[i], sep="")
  lung_3_sub <- read.table(file_path, col.names = c("Transcripts", sample))
  lung_3 <- cbind(lung_3, lung_3_sub)
}
