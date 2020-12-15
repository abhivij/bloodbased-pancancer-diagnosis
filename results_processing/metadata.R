setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results/")

source("../dataset_pipeline_arguments.R")

#feature extraction methods
fem_vector <- c('all', 't-test', 'wilcoxontest', 'RF_RFE', 'ga_rf',
                'ranger_perm', 'ranger_impu', 'ranger_impu_cor',
                'mrmr30', 'mrmr50', 'mrmr75', 'mrmr100',
                 'PCA_75', 
                'phate2', 'phate5', 
                'umap2', 'umap5', 
                'kpca_all', 'kpca2', 'kpca5',
                'plsda2', 'plsda5',
                'mrmr_plsda')

#feature selection methods
fsm_vector <- c('all', 't-test', 'wilcoxontest', 'RF_RFE', 'ga_rf',
                'ranger_perm', 'ranger_impu', 'ranger_impu_cor',
                'mrmr30', 'mrmr50', 'mrmr75', 'mrmr100')

#transformation methods
t_vector <- c('PCA_75', 
              'phate2', 'phate5', 
              'umap2', 'umap5', 
              'kpca_all', 'kpca2', 'kpca5',
              'plsda2', 'plsda5',
              'mrmr_plsda')

new_t_vector <- c('phate2', 'phate5', 'umap2', 'umap5', 'plsda2', 'plsda5')

best_pca_transform_vector <- c('PCA_75')


TEP_datasets <- c('TEP2015_GBMVsHC', 'TEP2015_NSCLCVsHC', 'TEP2015_CancerVsHC', 'TEP2017_NSCLCVsNC')

TEP_failed_datasets <- c('TEP2015_GBMVsHC', 'TEP2015_NSCLCVsHC', 'TEP2017_NSCLCVsNC', 'TEP2015_CancerVsHC')


major_disease_datasets <- c('GBM1_GBMVsCont', 'GBM2_GBMVsNC',
                            'LungCancer1_LUADVsControl', 'LungCancer3_LNSCLCVsCont',
                            'TEP2015_GBMVsHC', 'TEP2017_NSCLCVsNonCancer')

non_major_disease_datasets <- c('GBM1_GliomaVsCont', 'GBM2_Astro_OligoVsNC',
                                'LungCancer1_LUADVsControl', 'LungCancer3_ENSCLCVsCont')