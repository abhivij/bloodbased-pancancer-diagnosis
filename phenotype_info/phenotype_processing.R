setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/phenotype_info/")

library(dplyr)

phenotype_GBM1 <- read.table(file = "phenotype_GBM1_raw.txt", header=TRUE)
phenotype_GBM1_modified <- 
  phenotype_GBM1 %>%
    rename(Mutant = Mut.) %>%
    mutate(DataSetId = "GSE122488", .after = "Sample") %>%
    mutate(Biomarker = "EV_miRNA", .after = "DataSetId") %>%  
    mutate(Technology = "RNASeq", .after = "Biomarker")

write.table(phenotype_GBM1_modified, file = "phenotype_GBM1.txt", quote=FALSE, sep="\t", row.names=FALSE)


  