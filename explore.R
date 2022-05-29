library(tidyverse)
library(biomaRt)

setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/")

# data <- read.table("data/GSE71008/GSE71008_Data_matrix.txt", header=TRUE, row.names=1,
#                    skip=0, nrows=-1, comment.char="", fill=TRUE)
# RNA types provided in https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE71008

# miRNA (~40.4%), 
# piRNAs (~40.0%),
# pseudo-genes (~3.7%), 
# lncRNAs (~2.4%), 
# tRNAs (~2.1%),
# mRNAs (~2.1%)

ensembl = useEnsembl(biomart="ensembl", dataset="hsapiens_gene_ensembl")
head(listAttributes(ensembl))

data <- read.table("data/GBM/TEP/GSE68086_TEP_data_matrix.txt", header=TRUE, row.names=1,
                   skip=0, nrows=-1, comment.char="", fill=TRUE)

rna_types <- getBM(
  attributes = c(
    'ensembl_gene_id',
    'ensembl_transcript_id',
    'gene_biotype',
    'transcript_biotype',
    'source',
    'transcript_source'
  ),
  filters =
    'ensembl_gene_id',
  values = rownames(data),
  mart = ensembl
)
summary(factor(rna_types$gene_biotype))
summary(factor(rna_types$transcript_biotype))

options(scipen=999)
rna_types_df <- data.frame(count = summary(factor(rna_types$gene_biotype))) %>%
  rownames_to_column("gene_biotype")
rna_types_df <- rna_types_df %>%
  mutate(per = count * 100/ sum(count)) %>%
  arrange(desc(per))



data <- read.table("data/LungCancer/TEP/GSE89843_TEP_Count_Matrix.txt", header=TRUE, row.names=1,
                   skip=0, nrows=-1, comment.char="", fill=TRUE)
rna_types_tep2017 <- getBM(
  attributes = c(
    'ensembl_gene_id',
    'ensembl_transcript_id',
    'gene_biotype',
    'transcript_biotype',
    'source',
    'transcript_source'
  ),
  filters =
    'ensembl_gene_id',
  values = rownames(data),
  mart = ensembl
)
summary(factor(rna_types_tep2017$gene_biotype))
rna_types_tep2017_df <- data.frame(count = summary(factor(rna_types_tep2017$gene_biotype))) %>%
  rownames_to_column("gene_biotype")
rna_types_tep2017_df <- rna_types_tep2017_df %>%
  mutate(per = count * 100/ sum(count)) %>%
  arrange(desc(per))



#considering those with > 1%

# TEP2015
# 
# mRNAs (~70.5%),
# lncRNAs (~19%),
# pseudo-genes (~7.5%)



# TEP2017
# 
# mRNAs (~96.8%),
# lncRNAs (~2.7%)


#GSE158508

data <- read.table("data/GSE158508/GSE158508_ImPlatelet_counts.tsv", header=TRUE, row.names=1,
                   skip=0, nrows=-1, comment.char="", fill=TRUE)
rna_types <- getBM(
  attributes = c(
    'ensembl_gene_id',
    'ensembl_transcript_id',
    'gene_biotype',
    'transcript_biotype',
    'source',
    'transcript_source'
  ),
  filters =
    'ensembl_gene_id',
  values = rownames(data),
  mart = ensembl
)
summary(factor(rna_types$gene_biotype))
rna_types_df <- data.frame(count = summary(factor(rna_types$gene_biotype))) %>%
  rownames_to_column("gene_biotype")
rna_types_df <- rna_types_df %>%
  mutate(per = count * 100/ sum(count)) %>%
  arrange(desc(per))

# considering those with > 1%
# mRNAs (~70.5%),
# lncRNAs (~19%),
# pseudo-genes (~7.7%)




#GSE156902

data <- read.table("data/GSE156902/counts.txt", header=TRUE, row.names=1,
                   skip=0, nrows=-1, comment.char="", fill=TRUE)
rna_types <- getBM(
  attributes = c(
    'ensembl_gene_id',
    'ensembl_transcript_id',
    'gene_biotype',
    'transcript_biotype',
    'source',
    'transcript_source'
  ),
  filters =
    'ensembl_gene_id',
  values = rownames(data),
  mart = ensembl
)
summary(factor(rna_types$gene_biotype))
rna_types_df <- data.frame(count = summary(factor(rna_types$gene_biotype))) %>%
  rownames_to_column("gene_biotype")
rna_types_df <- rna_types_df %>%
  mutate(per = count * 100/ sum(count)) %>%
  arrange(desc(per))


# considering those with > 1%
# mRNAs (~97%),
# lncRNAs (~2.5%)
