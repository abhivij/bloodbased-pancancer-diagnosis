library(tidyverse)

setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/")

data <- read.table("data/GSE71008/GSE71008_Data_matrix.txt", header=TRUE, row.names=1,
                   skip=0, nrows=-1, comment.char="", fill=TRUE)

data <- read.table("data/GBM/TEP/GSE68086_TEP_data_matrix.txt", header=TRUE, row.names=1,
                   skip=0, nrows=-1, comment.char="", fill=TRUE)

data <- read.table("data/LungCancer/TEP/GSE89843_TEP_Count_Matrix.txt", header=TRUE, row.names=1,
                   skip=0, nrows=-1, comment.char="", fill=TRUE)

library(org.Hs.eg.db)

keytypes(org.Hs.eg.db)

columns(org.Hs.eg.db)

eKeys <- head(keys(org.Hs.eg.db, keytype="ENSEMBL"))
cols <- c("GENENAME", "GENETYPE", "SYMBOL")
select(org.Hs.eg.db, keys=eKeys, columns=cols, keytype="ENSEMBL")

select(org.Hs.eg.db, keys= c("ENSG00000249684", "ENSG00000267279", "ENSG00000273143", "ENSG00000283904"), 
       columns=cols, keytype="ENSEMBL")

ENSG00000249684


data <- read.table("data/LungCancer/TEP/GSE89843_TEP_Count_Matrix.txt", header=TRUE, row.names=1,
                   skip=0, nrows=-1, comment.char="", fill=TRUE)
gene_type <- select(org.Hs.eg.db, keys= rownames(data), 
       columns=cols, keytype="ENSEMBL")
summary(factor(gene_type$GENETYPE))

# ncRNA          other protein-coding         pseudo           NA's 
#             75              5           4530             31            110 



data <- read.table("data/GBM/TEP/GSE68086_TEP_data_matrix.txt", header=TRUE, row.names=1,
                   skip=0, nrows=-1, comment.char="", fill=TRUE)
gene_type <- select(org.Hs.eg.db, keys= rownames(data), 
                    columns=cols, keytype="ENSEMBL")
summary(factor(gene_type$GENETYPE))

# ncRNA          other protein-coding         pseudo           rRNA         snoRNA          snRNA 
# 5026            334          18968           8578             18            368             28 
# NA's 
#          24633 



library(biomaRt)


ensembl = useEnsembl(biomart="ensembl", dataset="hsapiens_gene_ensembl")
head(listAttributes(ensembl))

getBM(
  attributes = c(
    'ensembl_gene_id',
    'ensembl_transcript_id',
    'hgnc_symbol',
    'chromosome_name',
    'start_position',
    'end_position'
  ),
  filters =
    'chromosome_name',
  values = "1",
  mart = ensembl
)


getBM(
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
  values = c("ENSG00000249684", "ENSG00000267279", "ENSG00000273143", "ENSG00000283904", "ENSG00000000419"),
  mart = ensembl
)
