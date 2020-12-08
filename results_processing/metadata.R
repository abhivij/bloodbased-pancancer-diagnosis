setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results/")

#feature extraction methods
fem_vector <- c('all', 't-test', 'wilcoxontest', 'RF_RFE', 'ga_rf',
                'ranger_perm', 'ranger_impu', 'ranger_impu_cor',
                'mrmr30', 'mrmr100',
                 'PCA_75', 
                'phate2', 'phate5', 
                'umap2', 'umap5', 
                'kpca_all', 'kpca2', 'kpca5',
                'plsda2', 'plsda5')

#feature selection methods
fsm_vector <- c('all', 't-test', 'wilcoxontest', 'RF_RFE', 'ga_rf',
                'ranger_perm', 'ranger_impu', 'ranger_impu_cor',
                'mrmr30', 'mrmr100')

#transformation methods
t_vector <- c('PCA_75', 
              'phate2', 'phate5', 
              'umap2', 'umap5', 
              'kpca_all', 'kpca2', 'kpca5',
              'plsda2', 'plsda5')

new_t_vector <- c('phate2', 'phate5', 'umap2', 'umap5', 'plsda2', 'plsda5')

best_pca_transform_vector <- c('PCA_75')


TEP_datasets <- c('TEP2015_GBMVsHC', 'TEP2015_NSCLCVsHC', 'TEP2015_CancerVsHC', 'TEP2017_NSCLCVsNC')

TEP_failed_datasets <- c('TEP2015_GBMVsHC', 'TEP2015_NSCLCVsHC', 'TEP2017_NSCLCVsNC', 'TEP2015_CancerVsHC')