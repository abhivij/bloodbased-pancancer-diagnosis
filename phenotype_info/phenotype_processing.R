setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis")

library(dplyr)

#GBM1
phenotype_GBM1 <- read.table(file = "phenotype_info/phenotype_GBM1_raw.txt", header=TRUE)
phenotype_GBM1_modified <- 
  phenotype_GBM1 %>%
    rename(Mutant = Mut.) %>%
    mutate(DataSetId = "GSE122488", .after = "Sample") %>%
    mutate(Biomarker = "EV_miRNA", .after = "DataSetId") %>%  
    mutate(Technology = "RNASeq", .after = "Biomarker")

write.table(phenotype_GBM1_modified, file = "phenotype_info/phenotype_GBM1.txt", quote=FALSE, sep="\t", row.names=FALSE)


#LungCancer1  
lung_1 <- read.table("data/LungCancer/1/GSE111803_Readcount_TPM.txt", header = TRUE)
phenotype_LungCancer1 <- data.frame(Sample = colnames(lung_1)[c(2:11)])
phenotype_LungCancer1 <- 
  phenotype_LungCancer1 %>%
  mutate(DataSetId = "GSE111803", .after = "Sample") %>%
  mutate(Biomarker = "EV_miRNA", .after = "DataSetId") %>%  
  mutate(Technology = "RNASeq", .after = "Biomarker")  
phenotype_LungCancer1['LUADVsControl'] <- ifelse(
        sapply(phenotype_LungCancer1$Sample, grepl, pattern='LC', fixed=TRUE),
        'LUAD', 'Control')
write.table(phenotype_LungCancer1, file = "phenotype_info/phenotype_LungCancer1.txt", quote=FALSE, sep="\t", row.names=FALSE)


#TEP2015
TEP_2015_meta_data <- read.table("GBM/TEP/GSE68086_series_matrix.txt", header = FALSE, 
                                 skip = 28, nrows = 16)
TEP_2015_meta_data <- as.data.frame(t(as.matrix(TEP_2015_meta_data)))

TEP_2015 <- read.table("GBM/TEP/GSE68086_TEP_data_matrix.txt", header=TRUE, row.names = 1)
TEP_2015 <- data.frame(Sample = colnames(TEP_2015), 
                       CancerType = unlist(list(TEP_2015_meta_data[c(2:246),'V13'], TEP_2015_meta_data[c(247:286),'V11'])),
                       Mutant = unlist(list(TEP_2015_meta_data[c(2:246),'V15'], TEP_2015_meta_data[c(247:286),'V13']))
                       )
TEP_2015 <- TEP_2015  %>%
  mutate(CancerType = sub("^cancer type: ", "", CancerType)) %>%
  mutate(Mutant = sub("^mutational subclass: ", "", Mutant)) %>%
  mutate(DataSetId = "GSE68086", .after = "Sample") %>%
  mutate(Biomarker = "TEP_totalRNA", .after = "DataSetId") %>%  
  mutate(Technology = "RNASeq", .after = "Biomarker") %>%
  mutate(GBMVsHC = ifelse(CancerType == 'GBM', 'GBM', ifelse(CancerType == 'HC', 'HC', 'NA'))) %>%
  mutate(NSCLCVsHC = ifelse(CancerType == 'Lung', 'NSCLC', ifelse(CancerType == 'HC', 'HC', 'NA'))) %>%
  mutate(BCVsHC = ifelse(CancerType == 'Breast', 'BC', ifelse(CancerType == 'HC', 'HC', 'NA'))) %>%
  mutate(CRCVsHC = ifelse(CancerType == 'CRC', 'CRC', ifelse(CancerType == 'HC', 'HC', 'NA'))) %>%  
  mutate(PCVsHC = ifelse(CancerType == 'Pancreas', 'PC', ifelse(CancerType == 'HC', 'HC', 'NA'))) %>%
  mutate(HepCarVsHC = ifelse(CancerType == 'Hepatobiliary', 'HepCar', ifelse(CancerType == 'HC', 'HC', 'NA')))

write.table(TEP_2015, file = "phenotype_info/phenotype_TEP2015.txt", quote = FALSE, sep = "\t", row.names = FALSE)
