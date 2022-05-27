setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis")

library(tidyverse)
library("XLConnect")
library(readxl)

#GBM1
phenotype_GBM1 <- read.table(file = "phenotype_info/phenotype_GBM1_raw.txt", header=TRUE)
phenotype_GBM1_modified <- 
  phenotype_GBM1 %>%
    rename(Mutant = Mut.) %>%
    mutate(DataSetId = "GSE122488", .after = "Sample") %>%
    mutate(Biomarker = "EV_miRNA", .after = "DataSetId") %>%  
    mutate(Technology = "RNASeq", .after = "Biomarker") %>%
    mutate(GliomavsCont = ifelse(Type == 'Glioma', 'Glioma', ifelse(Type == 'Control', 'Control', 'NA')))

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
TEP_2015_meta_data <- read.table("data/GBM/TEP/GSE68086_series_matrix.txt", header = FALSE, 
                                 skip = 28, nrows = 16)
TEP_2015_meta_data <- as.data.frame(t(as.matrix(TEP_2015_meta_data)))
TEP_2015_meta_data <- data.frame( 
  SampleNameFromMetaData = TEP_2015_meta_data[c(2:286),'V8'],
  CancerType = unlist(list(TEP_2015_meta_data[c(2:246),'V13'], TEP_2015_meta_data[c(247:286),'V11'])),
  Mutant = unlist(list(TEP_2015_meta_data[c(2:246),'V15'], TEP_2015_meta_data[c(247:286),'V13']))
)
TEP_2015 <- data.frame(
  Sample = colnames(read.table("data/GBM/TEP/GSE68086_TEP_data_matrix.txt", 
                               header=TRUE, row.names = 1, nrow = 1)))
TEP_2015 <- TEP_2015 %>%
  mutate(SampleNameModified = sub("^X", "", Sample)) %>%
  mutate(SampleNameModified = gsub("\\.", "-", SampleNameModified)) 
TEP_2015 <- TEP_2015 %>%
  inner_join(TEP_2015_meta_data, by = c("SampleNameModified" = "SampleNameFromMetaData"))

TEP_2015 <- TEP_2015 %>%
  select(-c(SampleNameModified)) %>%
  mutate(CancerType = sub("^cancer type: ", "", CancerType)) %>%
  mutate(Mutant = sub("^mutational subclass: ", "", Mutant)) %>%
  mutate(DataSetId = "GSE68086", .after = "Sample") %>%
  mutate(Biomarker = "TEP_totalRNA", .after = "DataSetId") %>%  
  mutate(Technology = "RNASeq", .after = "Biomarker") %>%
  mutate(GBMVsHC = ifelse(CancerType == 'GBM', 'GBM', ifelse(CancerType == 'HC', 'HC', 'NA'))) %>%
  mutate(NSCLCVsHC = ifelse(CancerType == 'Lung', 'NSCLC', ifelse(CancerType == 'HC', 'HC', 'NA'))) %>%
  mutate(BCVsHC = ifelse(CancerType == 'Breast', 'BC', ifelse(CancerType == 'HC', 'HC', 'NA'))) %>%
  mutate(CRCVsHC = ifelse(CancerType == 'CRC', 'CRC', ifelse(CancerType == 'HC', 'HC', 'NA'))) %>%  
  mutate(PancCVsHC = ifelse(CancerType == 'Pancreas', 'PancC', ifelse(CancerType == 'HC', 'HC', 'NA'))) %>%
  mutate(HepCarVsHC = ifelse(CancerType == 'Hepatobiliary', 'HepCar', ifelse(CancerType == 'HC', 'HC', 'NA'))) %>%
  mutate(CancerVsHC = ifelse(CancerType == 'HC', 'HC', 'Cancer'))

write.table(TEP_2015, file = "phenotype_info/phenotype_TEP2015.txt", quote = FALSE, sep = "\t", row.names = FALSE)


#TEP2017
wb <- loadWorkbook("data/LungCancer/TEP/GSE89843_Best_et_al_Cancer_Cell_2017_Table_S1_conversion_to_GEO.xlsx", create = FALSE)
TEP_2017_meta_data <- readWorksheet(wb, sheet="Blad1", startRow = 3, endRow = 782, startCol = 3, endCol = 14)
TEP_2017_meta_data <- TEP_2017_meta_data %>%
  rename(Sample = 12) %>%
  select(-c(10,11))

TEP_2017 <- data.frame(
  Sample = colnames(read.table("data/LungCancer/TEP/GSE89843_TEP_Count_Matrix.txt", header = TRUE, 
                               row.names = 1, nrow = 1))
  )
TEP_2017 <- TEP_2017 %>%
  mutate(SampleNameModified = gsub("\\.", "-", Sample)) 
TEP_2017 <- TEP_2017 %>%
  inner_join(TEP_2017_meta_data, by = c("SampleNameModified" = "Sample")) %>%
  select(-c(SampleNameModified)) %>%
  rename(NSCLCVsNC = Classification.group) %>%
  mutate(NSCLCVsNC = sub("Non-cancer", "NonCancer", NSCLCVsNC)) %>%
  mutate(DataSetId = "GSE89843", .after = "Sample") %>%
  mutate(Biomarker = "TEP_totalRNA", .after = "DataSetId") %>%  
  mutate(Technology = "RNASeq", .after = "Biomarker")  

write.table(TEP_2017, file = "phenotype_info/phenotype_TEP2017.txt", quote = FALSE, sep = "\t", row.names = FALSE)  



#GBM2
gbm2 <- read.table("data/GBM/2/GSE112462_series_matrix.txt", header = FALSE, 
                   skip = 27, nrows = 8)
gbm2 <- as.data.frame(t(as.matrix(gbm2[c(1,2,8),])))
gbm2_rows <- dim(gbm2)[1]
gbm2_phenotype <- data.frame(Sample = gbm2[2:gbm2_rows, 2],
                             SampleNum = gbm2[2:gbm2_rows, 1],
                             Type = gbm2[2:gbm2_rows, 3])
gbm2_phenotype <- gbm2_phenotype %>%
  mutate(DataSetId = "GSE112462", .after = "Sample") %>%
  mutate(Biomarker = "EV_miRNA", .after = "DataSetId") %>%  
  mutate(Technology = "Nanostring", .after = "Biomarker") %>%  
  mutate(GBMVsNC = ifelse(Type == 'GLIOBLASTOMA', 'GBM', ifelse(Type == 'NORMAL/NONDISEASED', 'NonCancer', 'NA'))) %>%
  mutate(GBMVsAstro = ifelse(Type == 'GLIOBLASTOMA', 'GBM', ifelse(Type == 'ASTROCYTOMAS', 'Astro', 'NA'))) %>%
  mutate(GBMVsOligo = ifelse(Type == 'GLIOBLASTOMA', 'GBM', ifelse(Type == 'OLIGODENDROGLIOMA', 'Oligo', 'NA'))) %>%  
  mutate(GBMVsAstro_Oligo = ifelse(Type == 'GLIOBLASTOMA', 'GBM', ifelse(Type == 'NORMAL/NONDISEASED', 'NA', 'Astro_Oligo'))) %>%  
  mutate(AstroVsNC = ifelse(Type == 'ASTROCYTOMAS', 'Astro', ifelse(Type == 'NORMAL/NONDISEASED', 'NonCancer', 'NA'))) %>%
  mutate(OligoVsNC = ifelse(Type == 'OLIGODENDROGLIOMA', 'Oligo', ifelse(Type == 'NORMAL/NONDISEASED', 'NonCancer', 'NA'))) %>%  
  mutate(Astro_OligoVsNC = ifelse(Type == 'GLIOBLASTOMA', 'NA', ifelse(Type == 'NORMAL/NONDISEASED', 'NonCancer', 'Astro_Oligo')))
  
write.table(gbm2_phenotype, file = "phenotype_info/phenotype_GBM2.txt", quote = FALSE, sep = "\t", row.names = FALSE)    
  

#LungCancer3  note : Dataset labelled LungCancer2, is not being used currently, so not present in this file
lungcancer3 <- read.table("data/LungCancer/3/GSE114711_series_matrix.txt", header = FALSE, 
                   skip = 37, nrows = 10)
lungcancer3 <- as.data.frame(t(as.matrix(lungcancer3[c(1,3,10),])))
lungcancer3_rows <- dim(lungcancer3)[1]
lungcancer3 <- data.frame(Sample = lungcancer3[2:lungcancer3_rows, 3],
                             Sex = lungcancer3[2:lungcancer3_rows, 2],
                             Type = lungcancer3[2:lungcancer3_rows, 1])
lungcancer3 <- lungcancer3 %>%
  mutate(DataSetId = "GSE114711", .after = "Sample") %>%
  mutate(Biomarker = "EV_miRNA", .after = "DataSetId") %>%  
  mutate(Technology = "RNASeq", .after = "Biomarker") %>%    
  mutate(Sex = sub("Sex: ", "", Sex)) %>%
  mutate(Type = sub("dissease state: ", "", Type)) %>%
  mutate(Type = sub("early stage NSCLC", "earlystageNSCLC", Type)) %>%
  mutate(Type = sub("late stage NSCLC", "latestageNSCLC", Type)) %>%  
  mutate(NSCLCVsCont = ifelse(Type == 'control', 'control', 'NSCLC')) %>%
  mutate(ENSCLCVsCont = ifelse(Type == 'control', 'control', ifelse(Type == 'earlystageNSCLC', 'earlystageNSCLC', 'NA'))) %>%  
  mutate(LNSCLCVsCont = ifelse(Type == 'control', 'control', ifelse(Type == 'latestageNSCLC', 'latestageNSCLC', 'NA'))) %>%
  mutate(LNSCLCVsENSCLC = ifelse(Type == 'control', 'NA', ifelse(Type == 'earlystageNSCLC', 'earlystageNSCLC', 'latestageNSCLC')))  

write.table(lungcancer3, file = "phenotype_info/phenotype_LungCancer3.txt", quote = FALSE, sep = "\t", row.names = FALSE) 



#GSE71008 - Colon Cancer, Pancreatic Cancer
GSE71008_meta_data <- read.table("data/GSE71008/GSE71008_series_matrix.txt", header = FALSE, 
                                 skip = 31, nrows = 14)
GSE71008_meta_data <- as.data.frame(t(as.matrix(GSE71008_meta_data)))
GSE71008_meta_data_rows <- dim(GSE71008_meta_data)[1]
GSE71008_meta_data <- data.frame( 
  Sample = GSE71008_meta_data[c(2:GSE71008_meta_data_rows), 'V1'],
  DataSetSampleId = GSE71008_meta_data[c(2:GSE71008_meta_data_rows), 'V2'],
  Sex = GSE71008_meta_data[c(2:GSE71008_meta_data_rows), 'V10'],
  Age = GSE71008_meta_data[c(2:GSE71008_meta_data_rows), 'V11'],
  CancerType = GSE71008_meta_data[c(2:GSE71008_meta_data_rows), 'V13']
)
GSE71008_meta_data <- GSE71008_meta_data %>%
  mutate(Sample = make.names(sub("Sample_", "", Sample))) %>%
  mutate(DataSetId = "GSE71008", .after = "DataSetSampleId") %>%
  mutate(Biomarker = "plasma-microvesicles_totalRNA", .after = "DataSetId") %>%  
  mutate(Technology = "RNASeq", .after = "Biomarker") %>%
  mutate(Sex = sub("Sex: ", "", Sex))  %>%
  mutate(Age = sub("age \\(years\\): ", "", Age))  %>%
  mutate(CancerType = sub("disease type: ", "", CancerType)) 
GSE71008_meta_data <- GSE71008_meta_data %>%
  mutate(CRCVsHC = ifelse(CancerType == 'Colorectal Cancer', 'CRC', ifelse(CancerType == 'Healthy Control', 'HC', 'NA'))) %>%
  mutate(PCVsHC = ifelse(CancerType == 'Pancreatic Cancer', 'PC', ifelse(CancerType == 'Healthy Control', 'HC', 'NA'))) %>%
  mutate(ProCVsHC = ifelse(CancerType == 'Prostate Cancer', 'ProC', ifelse(CancerType == 'Healthy Control', 'HC', 'NA'))) %>%
  mutate(CancerVsHC = ifelse(CancerType == 'Healthy Control', 'HC', 'Cancer'))

write.table(GSE71008_meta_data, file = "phenotype_info/phenotype_GSE71008.txt", quote = FALSE, sep = "\t", row.names = FALSE)

data <- read.table("data/GSE71008/GSE71008_Data_matrix.txt", header=TRUE, row.names=1,
                   skip=0, nrows=-1, comment.char="", fill=TRUE)

#GSE41526 - Breast Cancer
#ignore 64 lines to read data
GSE41526_meta_data <- read.table("data/GSE41526/GSE41526_series_matrix.txt", header = FALSE, 
                                 skip = 28, nrows = 12)
GSE41526_meta_data <- as.data.frame(t(as.matrix(GSE41526_meta_data)))
GSE41526_meta_data_rows <- dim(GSE41526_meta_data)[1]
GSE41526_meta_data <- data.frame( 
  Sample = GSE41526_meta_data[c(2:GSE41526_meta_data_rows), 'V2'],
  Sex = GSE41526_meta_data[c(2:GSE41526_meta_data_rows), 'V11'],
  CancerType = GSE41526_meta_data[c(2:GSE41526_meta_data_rows), 'V12']
)
GSE41526_meta_data <- GSE41526_meta_data %>%
  mutate(DataSetId = "GSE41526", .after = "Sample") %>%
  mutate(Biomarker = "plasma-totalRNA", .after = "DataSetId") %>%  
  mutate(Technology = "Microarray", .after = "Biomarker") %>%
  mutate(Sex = sub("gender: ", "", Sex))  %>%
  mutate(CancerType = sub("sample type: ", "", CancerType)) 
GSE41526_meta_data <- GSE41526_meta_data %>%
  mutate(preBCVsHC = ifelse(CancerType == 'pre-resection breast cancer', 'preBC', ifelse(CancerType == 'control', 'HC', 'NA'))) %>%
  mutate(postBCVsHC = ifelse(CancerType == 'post-resection breast cancer', 'postBC', ifelse(CancerType == 'control', 'HC', 'NA'))) %>%  
  mutate(BCVsHC = ifelse(sapply(CancerType, grepl, pattern='breast cancer', fixed=TRUE), 'BC', 
                         ifelse(CancerType == 'control', 'HC', 'NA'))) %>%    
  mutate(CRCVsHC = ifelse(CancerType == 'colon cancer', 'CRC', ifelse(CancerType == 'control', 'HC', 'NA'))) %>%
  mutate(LCVsHC = ifelse(CancerType == 'lung cancer', 'LC', ifelse(CancerType == 'control', 'HC', 'NA'))) %>%
  mutate(CancerVsHC = ifelse(CancerType == 'control', 'HC', 'Cancer'))

write.table(GSE41526_meta_data, file = "phenotype_info/phenotype_GSE41526.txt", quote = FALSE, sep = "\t", row.names = FALSE)

# data <- read.table("data/GSE41526/GSE41526_series_matrix.txt", header=TRUE, row.names=1, skip=64,
#                    comment.char = "", nrows = 1145, fill = TRUE)



#GSE83270 - Breast Cancer
#ignore 64 lines to read data
meta_data <- read.table("data/GSE83270/GSE83270_series_matrix.txt", header = FALSE, 
                                 skip = 26, nrows = 9)
meta_data <- as.data.frame(t(as.matrix(meta_data)))
meta_data_rows <- dim(meta_data)[1]
meta_data <- data.frame( 
  Sample = meta_data[c(2:meta_data_rows), 'V1'],
  Sex = meta_data[c(2:meta_data_rows), 'V9'],
  CancerType = meta_data[c(2:meta_data_rows), 'V7']
)
meta_data <- meta_data %>%
  mutate(DataSetId = "GSE83270", .after = "Sample") %>%
  mutate(Biomarker = "blood-totalRNA", .after = "DataSetId") %>%  
  mutate(Technology = "Microarray", .after = "Biomarker") %>%
  mutate(Sex = sub("gender: ", "", Sex))  %>%
  mutate(BCVsHC = ifelse(CancerType == 'breast cancer patients', 'BC', 'HC'))
write.table(meta_data, file = "phenotype_info/phenotype_GSE83270.txt", 
            quote = FALSE, sep = "\t", row.names = FALSE)

# data <- read.table("data/GSE83270/GSE83270_series_matrix.txt",
#                     header=TRUE, row.names=1, skip=57, nrows = 2158, fill = TRUE)


#GSE22981 - Breast Cancer
#ignore 64 lines to read data
meta_data <- read.table("data/GSE22981/GSE22981_series_matrix.txt", header = FALSE, 
                        skip = 32, nrows = 10)
meta_data <- as.data.frame(t(as.matrix(meta_data)))
meta_data_rows <- dim(meta_data)[1]
meta_data <- data.frame( 
  Sample = meta_data[c(2:meta_data_rows), 'V1'],
  Race = meta_data[c(2:meta_data_rows), 'V9'],
  CancerType = meta_data[c(2:meta_data_rows), 'V10']
)
meta_data <- meta_data %>%
  mutate(DataSetId = "GSE22981", .after = "Sample") %>%
  mutate(Biomarker = "plasma-totalRNA", .after = "DataSetId") %>%  
  mutate(Technology = "Microarray", .after = "Biomarker") %>%
  mutate(Race = sub("race: ", "", Race))  %>%
  mutate(CancerType = sub("disease state: ", "", CancerType)) %>%
  mutate(EBCVsHC = ifelse(CancerType == 'Control', 'HC', 'EBC'))
write.table(meta_data, file = "phenotype_info/phenotype_GSE22981.txt", 
            quote = FALSE, sep = "\t", row.names = FALSE)

data <- read.table("data/GSE22981/GSE22981_series_matrix.txt",
                    header=TRUE, row.names=1, skip=64, nrows = 1145, fill = TRUE)




#GSE73002 - Breast Cancer
sample_id <- strsplit(read.table("data/GSE73002/GSE73002_series_matrix.txt", 
                                 header = FALSE, skip = 23, nrows = 1)[,2], 
                      split = " ", fixed = TRUE)

characteristics <- read.table("data/GSE73002/GSE73002_series_matrix.txt", 
                                    header = FALSE, skip = 48, nrows = 1)
col_num <- dim(characteristics)[2]
characteristics <- t(as.matrix(characteristics[,2:col_num]))

meta_data <- data.frame(sample_id, characteristics)
colnames(meta_data) <- c("Sample", "DiseaseType")

meta_data <- meta_data %>%
  mutate(DataSetId = "GSE73002", .after = "Sample") %>%
  mutate(Biomarker = "serum-miRNA", .after = "DataSetId") %>%  
  mutate(Technology = "Microarray", .after = "Biomarker") %>%
  mutate(DiseaseType = sub("diagnosis: ", "", DiseaseType)) %>%
  mutate(BCVsNC = ifelse(DiseaseType == 'breast cancer', 'BC', 
                         ifelse(DiseaseType == 'non-cancer', 'NC', 'NA')))
write.table(meta_data, file = "phenotype_info/phenotype_GSE73002.txt", 
            quote = FALSE, sep = "\t", row.names = FALSE)

data <- read.table("data/GSE73002/GSE73002_series_matrix.txt",
                   header=TRUE, row.names=1, skip=73, nrows = 2540, fill = TRUE, na.strings = "null")



#GSE44281 - Breast Cancer
sample_id <- strsplit(read.table("data/GSE44281/GSE44281_series_matrix.txt", 
                                 header = FALSE, skip = 18, nrows = 1)[,2], 
                      split = " ", fixed = TRUE)
characteristics <- read.table("data/GSE44281/GSE44281_series_matrix.txt", 
                              header = FALSE, skip = 43, nrows = 3)
col_num <- dim(characteristics)[2]
characteristics <- data.frame(t(as.matrix(characteristics[,2:col_num])))
meta_data <- cbind(sample_id, characteristics)
colnames(meta_data) <- c("Sample", "DiseaseType", "Age", "Race")

meta_data <- meta_data %>%
  mutate(DataSetId = "GSE44281", .after = "Sample") %>%
  mutate(Biomarker = "serum-miRNA", .after = "DataSetId") %>%  
  mutate(Technology = "Microarray", .after = "Biomarker") %>%
  mutate(DiseaseType = sub("status: ", "", DiseaseType)) %>%
  mutate(Age = sub("age: ", "", Age)) %>%
  mutate(Race = sub("race: (.)) ", "", Race)) %>%
  mutate(caseVsnoncase = ifelse(DiseaseType == 'case', 'case', 
                                ifelse(DiseaseType == 'noncase', 'noncase', 'NA')))
write.table(meta_data, file = "phenotype_info/phenotype_GSE44281.txt", 
            quote = FALSE, sep = "\t", row.names = FALSE)
data <- read.table("data/GSE44281/GSE44281_series_matrix.txt",
                   header=TRUE, row.names=1, skip=67, nrows = 20180, fill = TRUE)



#GSE59856 - Breast Cancer
sample_id <- strsplit(read.table("data/GSE59856/GSE59856_series_matrix.txt", 
                                 header = FALSE, skip = 16, nrows = 1)[,2], 
                      split = " ", fixed = TRUE)
characteristics <- read.table("data/GSE59856/GSE59856_series_matrix.txt", 
                              header = FALSE, skip = 41, nrows = 5)
col_num <- dim(characteristics)[2]
characteristics <- data.frame(t(as.matrix(characteristics[,2:col_num])))
characteristics <- characteristics %>%
  select(-c(2))
meta_data <- cbind(sample_id, characteristics)
colnames(meta_data) <- c("Sample", "DiseaseType", "Gender", "TumourStage", "Age")

meta_data <- meta_data %>%
  mutate(DataSetId = "GSE59856", .after = "Sample") %>%
  mutate(Biomarker = "serum-miRNA", .after = "DataSetId") %>%  
  mutate(Technology = "Microarray", .after = "Biomarker") %>%
  mutate(DiseaseType = sub("disease state: ", "", DiseaseType)) %>%
  mutate(Gender = sub("gender: ", "", Gender)) %>%
  mutate(TumourStage = sub("tumor stage: ", "", TumourStage)) %>%
  mutate(Age = sub("age: ", "", Age))

write.table(meta_data, file = "phenotype_info/phenotype_GSE59856.txt", 
            quote = FALSE, sep = "\t", row.names = FALSE)
#To do later : add classification criteria columns
#note : this phenotype not used currently, since we wanted this for breast cancer samples

data <- read.table("data/GSE59856/GSE59856_series_matrix.txt",
                   header=TRUE, row.names=1, skip=69, nrows = 2555, fill = TRUE)



#GSE158523 - HCC
data <- read.table("data/GSE158523/GSE158523_miRNA_Expression_Summary.txt", 
                                 header = TRUE, skip = 0, nrows = -1, row.names = 1)
meta_data <- data.frame("Sample" = colnames(data))
meta_data <- meta_data %>%
  mutate(DataSetId = "GSE158523", .after = "Sample") %>%
  mutate(Biomarker = "TEP-miRNA", .after = "DataSetId") %>%  
  mutate(Technology = "RNASeq", .after = "Biomarker") %>%
  mutate(DiseaseType = case_when(grepl("^T", Sample) ~ "hepatocellular carcinoma",
                                 grepl("^N", Sample) ~ "healthy")) %>%
  mutate(HCCVsHC = case_when(grepl("^T", Sample) ~ "HCC",
                             grepl("^N", Sample) ~ "HC"))
write.table(meta_data, file = "phenotype_info/phenotype_GSE158523.txt", 
            quote = FALSE, sep = "\t", row.names = FALSE)

data <- read.table("data/GSE158523/GSE158523_miRNA_Expression_Summary.txt", 
                   header=TRUE, row.names=1, skip=0,
                   nrows=-1, comment.char="", fill=TRUE, na.strings = "NA")



#GSE160252 - Pancreatic Cancer

data <- read.table("data/GSE160252/GSE160252_miRNA.canonical.rawcounts.txt", 
                   header=TRUE, row.names=1, skip=0,
                   nrows=-1, comment.char="", fill=TRUE, na.strings = "NA")

meta_data <- data.frame("Sample" = colnames(data))
meta_data <- meta_data %>%
  mutate(DataSetId = "GSE160252", .after = "Sample") %>%
  mutate(Biomarker = "TEP-canonical-miRNA", .after = "DataSetId") %>%  
  mutate(Technology = "RNASeq", .after = "Biomarker") %>%
  mutate(DiseaseType = case_when(grepl("^P", Sample) ~ "PDAC",
                                 grepl("^B", Sample) ~ "Benign")) %>%
  mutate(PDACVsBenign = case_when(grepl("^P", Sample) ~ "PDAC",
                             grepl("^B", Sample) ~ "Benign"))
write.table(meta_data, file = "phenotype_info/phenotype_GSE160252.txt", 
            quote = FALSE, sep = "\t", row.names = FALSE)



#GSE175436 - Pancreatic Cancer mRNA

data <- read_xlsx("data/GSE175436/GSE175436_mRNA_Expression_Profiling.xlsx", skip = 8)[, c(1:11)]
data <- data %>%
  column_to_rownames("gene_id")
colnames(data) <- sapply(strsplit(colnames(data), split = "...", fixed = TRUE),
                         function(x){return (x[[1]])})

meta_data <- data.frame("Sample" = colnames(data))
meta_data <- meta_data %>%
  mutate(DataSetId = "GSE175436", .after = "Sample") %>%
  mutate(Biomarker = "EV-mRNA", .after = "DataSetId") %>%  
  mutate(Technology = "RNASeq", .after = "Biomarker") %>%
  mutate(DiseaseType = case_when(grepl("^C", Sample) ~ "PDAC",
                                 grepl("^N", Sample) ~ "Healthy")) %>%
  mutate(PDACVsHealthy = case_when(grepl("^C", Sample) ~ "PDAC",
                                  grepl("^N", Sample) ~ "Healthy"))
write.table(meta_data, file = "phenotype_info/phenotype_GSE175436_mRNA.txt", 
            quote = FALSE, sep = "\t", row.names = FALSE)
  
write.table(data, file = "data/GSE175436/mRNA_count.txt", sep = "\t")  


data <- read.table("data/GSE175436/mRNA_count.txt", 
                   header=TRUE, row.names=1, skip=0,
                   nrows=-1, comment.char="", fill=TRUE, na.strings = "NA")


#GSE175436 - Pancreatic Cancer lncRNA

data <- read_xlsx("data/GSE175436/GSE175436_LncRNA_Expression_Profiling.xlsx", skip = 16)[, c(1:11)]
data <- data %>%
  column_to_rownames("transcript_id")
#issue : transcript id not unique
#so not using this data

# colnames(data) <- sapply(strsplit(colnames(data), split = "...", fixed = TRUE),
#                          function(x){return (x[[1]])})
# 
# meta_data <- data.frame("Sample" = colnames(data))
# meta_data <- meta_data %>%
#   mutate(DataSetId = "GSE175436", .after = "Sample") %>%
#   mutate(Biomarker = "EV-lncRNA", .after = "DataSetId") %>%  
#   mutate(Technology = "RNASeq", .after = "Biomarker") %>%
#   mutate(DiseaseType = case_when(grepl("^C", Sample) ~ "PDAC",
#                                  grepl("^N", Sample) ~ "Healthy")) %>%
#   mutate(PDACVsHealthy = case_when(grepl("^C", Sample) ~ "PDAC",
#                                    grepl("^N", Sample) ~ "Healthy"))
# write.table(meta_data, file = "phenotype_info/phenotype_GSE175436_lncRNA.txt", 
#             quote = FALSE, sep = "\t", row.names = FALSE)
# 
# write.table(data, file = "data/GSE175436/lncRNA_count.txt", sep = "\t")  
# 
# 
# data <- read.table("data/GSE175436/lncRNA_count.txt", 
#                    header=TRUE, row.names=1, skip=0,
#                    nrows=-1, comment.char="", fill=TRUE, na.strings = "NA")




#GSE158508 - Ovarian Cancer Vs Non-cancer gynaecological condition 

data <- read.table("data/GSE158508/GSE158508_ImPlatelet_counts.tsv", 
                   header=TRUE, row.names=1, skip=0,
                   nrows=-1, comment.char="", fill=TRUE, na.strings = "NA")
meta_data <- read.table("data/GSE158508/GSE158508_series_matrix.txt", 
                        header=FALSE, skip=33,
                        nrows=-1, comment.char="", fill=TRUE, na.strings = "NA")
meta_data <- data.frame(t(meta_data))
meta_data <- meta_data %>%
  select(c(X20, X2, X10, X11, X12, X13))
colnames(meta_data) <- c("Sample", "Sample_GEO_accession", "group", "gender", "age", "stage")
meta_data <- meta_data[2:70,]
meta_data <- meta_data %>%
  mutate(group = gsub("group: ", "", group, fixed = TRUE)) %>%
  mutate(gender = gsub("gender: ", "", gender, fixed = TRUE)) %>%
  mutate(age = gsub("age: ", "", age, fixed = TRUE)) %>%
  mutate(stage = gsub("Stage: ", "", stage, fixed = TRUE))

# data <- data[, meta_data$Sample]
