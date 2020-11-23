setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results/")

#feature extraction methods
fem_vector <- c('all', 't-test', 'wilcoxontest', 'RF_RFE', 'Genetic Algorithm', 
                 'PCA_75', 'phate2', 'phate5', 'umap2', 'umap5')

#feature selection methods
fsm_vector <- c('all', 't-test', 'wilcoxontest', 'RF_RFE', 'Genetic Algorithm')

#transformation methods
t_vector <- c('PCA_75', 'phate2', 'phate5', 'umap2', 'umap5')

best_pca_transform_vector <- c('PCA_75')


TEP_datasets <- c('TEP2015_GBMVsHC', 'TEP2015_NSCLCVsHC', 'TEP2015_CancerVsHC', 'TEP2017_NSCLCVsNC')