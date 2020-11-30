setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results/")

#feature extraction methods
fem_vector <- c('all', 't-test', 'wilcoxontest', 'RF_RFE', 'GA_RF',
                 'PCA_75', 'phate2', 'phate5', 'umap2', 'umap5', 'plsda2', 'plsda5',
                'ga_rf_cv', 'ga', 'ga_rf_with_repcv', 'rf_cv', 'rf_repcv')

#feature selection methods
fsm_vector <- c('all', 't-test', 'wilcoxontest', 'RF_RFE', 'GA_RF',
                'ga_rf_cv', 'ga', 'ga_rf_with_repcv', 'rf_cv', 'rf_repcv')

#transformation methods
t_vector <- c('PCA_75', 'phate2', 'phate5', 'umap2', 'umap5', 'plsda2', 'plsda5')

new_t_vector <- c('phate2', 'phate5', 'umap2', 'umap5', 'plsda2', 'plsda5')

best_pca_transform_vector <- c('PCA_75')


TEP_datasets <- c('TEP2015_GBMVsHC', 'TEP2015_NSCLCVsHC', 'TEP2015_CancerVsHC', 'TEP2017_NSCLCVsNC')

TEP_failed_datasets <- c('TEP2015_GBMVsHC', 'TEP2015_NSCLCVsHC', 'TEP2017_NSCLCVsNC', 'TEP2015_CancerVsHC')