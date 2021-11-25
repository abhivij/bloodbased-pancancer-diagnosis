#dependencies of scmamp start
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("graph")
BiocManager::install("Rgraphviz")
#dependencies of scmamp end

install.packages("scmamp")

BiocManager::install("edgeR")

install.packages("synchrony")

install.packages("glmnet")
install.packages("e1071")
install.packages("randomForest")
install.packages("ROCR")

install.packages("caret")

install.packages("tidyverse")

install.packages("viridis")

install.packages("doParallel")

install.packages("phateR")
install.packages("umap")

install.packages("pls")

install.packages("ranger")

install.packages("mRMRe")

install.packages("kernlab")


BiocManager::install("ComplexHeatmap")

install.packages("usethis")

BiocManager::install("vsn")
