library("XLConnect")
library("stringr")
library(dplyr)
library(tidyr)
library(edgeR)


setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/data")

gbm_1 <- read.table("GBM/1/GSE122488_normalized_microRNA_counts.txt", 
                    header=TRUE, row.names=1, skip=3)

disease_data <- data.frame(colnames(gbm_1))
colnames(disease_data) <- 'sample_name'
disease_data['disease_status'] <- disease_data$sample_name
levels(disease_data$disease_status) <- c(levels(disease_data$disease_status), 'GBM', 'Control', 'Glioma')
disease_data$disease_status[grepl('GBM', disease_data$disease_status)] <- 'GBM'
disease_data$disease_status[grepl('HC', disease_data$disease_status)] <- 'Control'
disease_data$disease_status[grepl('GII.III', disease_data$disease_status)] <- 'Glioma'
disease_data$disease_status <- factor(disease_data$disease_status)

# set1 <- subset(disease_data, disease_status == 'Control'    )
# set2 <- subset(disease_data, disease_status == 'GBM'  )
# 
# set = data.frame(rep(0,dim(gbm_1)[2]))
# colnames(set) = "comparator"
# rownames(set) = colnames(raw)
# set[rownames(set1),1] = 1
# set[rownames(set2),1] = 2
# x.raw <- gbm_1[ ,which(set > 0)]  
# groups <- set[which(set > 0),]

gbm_and_control_samples <- disease_data$disease_status == 'Control' | disease_data$disease_status == 'GBM'
x.raw <- gbm_1[, gbm_and_control_samples] 
disease_data <- disease_data[gbm_and_control_samples, ]


keep <- filterByExpr(x.raw)
x.filtered <- x.raw[keep, ]
x.logcpm <- cpm(x.filtered, log=TRUE)
x <- scale(x.logcpm)

# colnames(x.normlogcpm) <- disease_data$disease_status


ttest_result <- c()
for (i in 1:nrow(x)) {
  ttest_result[i] <- t.test(x = x[i, disease_data$disease_status == 'GBM'],
                            y = x[i, disease_data$disease_status == 'Control'],
                            var.equal = FALSE)$p.value
}
ttest_result <- data.frame(ttest_result)
row.names(ttest_result) <- rownames(x)


# ttest_result <- ttest_result[order(ttest_result$ttest_result), ]
