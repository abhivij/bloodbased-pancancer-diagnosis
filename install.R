#dependencies of scmamp start
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("graph")
BiocManager::install("Rgraphviz")
#dependencies of scmamp end

install.packages("scmamp")

install.packages("synchrony")

install.packages("tidyverse")