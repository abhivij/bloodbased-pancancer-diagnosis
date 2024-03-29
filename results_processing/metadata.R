# uncomment below line to run in local
# setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/results/")

# uncomment below line to run in katana
setwd("../results/")

source("../dataset_pipeline_arguments.R")

# #feature extraction methods
# fem_vector <- c('all', 't-test', 'wilcoxontest', 'RF_RFE', 'ga_rf',
#                 'ranger_perm', 'ranger_impu', 'ranger_impu_cor',
#                 'mrmr30', 'mrmr50', 'mrmr75', 'mrmr100',
#                  'PCA_75', 'pca2', 'pca5', 'pca_var',
#                 'phate2', 'phate5', 
#                 'umap2', 'umap5', 
#                 'kpca_all', 'kpca2', 'kpca5',
#                 'plsda2', 'plsda5',
#                 'mrmr_plsda',
#                 'phate_var', 'umap_var', 'kpca_var',
#                 'plsda_var', 'mrmr_plsda_var',
#                 'phate_pcavar', 'umap_pcavar', 'kpca_pcavar',
#                 'plsda_pcavar', 'mrmr_plsda_pcavar')
# 
# #feature selection methods
# fsm_vector <- c('all', 't-test', 'wilcoxontest', 'RF_RFE', 'ga_rf',
#                 'ranger_perm', 'ranger_impu', 'ranger_impu_cor',
#                 'mrmr30', 'mrmr50', 'mrmr75', 'mrmr100')

###############################################################

# fem_vector <- c('all', 't-test', 'wilcoxontest', 'RF_RFE', 'ga_rf',
#                 'ranger_impu_cor',
#                 'mrmr30', 'mrmr50',
#                 'PCA_75', 'pca2', 'pca5', 'pca_var',
#                 'phate2', 'phate5', 
#                 'umap2', 'umap5', 
#                 'kpca_all', 'kpca2', 'kpca5',
#                 'plsda2', 'plsda5',
#                 'phate_var', 'umap_var', 'kpca_var',
#                 'plsda_var',
#                 'phate_pcavar', 'umap_pcavar', 'kpca_pcavar',
#                 'plsda_pcavar')
# 
# #feature selection methods
# fsm_vector <- c('all', 't-test', 'wilcoxontest', 'RF_RFE', 'ga_rf',
#                 'ranger_impu_cor',
#                 'mrmr30', 'mrmr50')

#########################################

datasets <-
  c(
    'GBM1_GBMvsGlioma',
    'GBM1_GBMvsCont',
    'GBM1_GliomavsCont',
    'GBM2_GBMVsNC',
    'GBM2_GBMVsAstro_Oligo',
    'GBM2_Astro_OligoVsNC',
    'TEP2015_GBMVsHC',
    'TEP2015_CancerVsHC',
    'TEP2015_NSCLCVsHC',
    'TEP2017_NSCLCVsNC',
    'TEP2015_CRCVsHC',
    'TEP2015_BCVsHC',
    'TEP2015_PCVsHC',
    'LungCancer1_LUADVsControl',
    'LungCancer3_NSCLCVsCont',
    'LungCancer3_LNSCLCVsCont',
    'LungCancer3_ENSCLCVsCont',
    'LungCancer3_LNSCLCVsENSCLC',
    'GSE71008_CRCVsHC',
    'GSE83270_BCVsHC',
    'GSE22981_EBCVsHC',
    'GSE73002_BCVsNC',
    'GSE44281_caseVsnoncase',
    'GSE158523_HCCVsHC',
    'GSE160252_PDACVsBenign',
    'GSE175436_PDACVsHealthy',
    'GSE158508_OCVsCTRL',
    'GSE156902_GBMVsHC'
  )

fem_vector <- c('all', 't-test', 'wilcoxontest',
                'mrmr10', 'mrmr75', 'mrmr_perc50',
                'ga_rf',
                'RF_RFE', 'ranger_impu_cor',
                'ranger_pos_impu_cor',
                'ipage_pval_0.05',
                'pca2', 'pca5',
                'kpca2', 'kpca5',
                'umap2', 'umap5',
                'phate2', 'phate5',
                'plsda2', 'plsda5')

#feature selection methods
# fsm_vector <- c('all', 't-test', 'wilcoxontest',
#                 'mrmr30', 'mrmr50',
#                 'ga_rf',
#                 'RF_RFE', 'ranger_impu_cor')

fsm_vector <- c('all', 't-test', 'wilcoxontest',
                'mrmr10', 'mrmr75', 'mrmr_perc50',
                'ga_rf',
                'RF_RFE', 'ranger_impu_cor')

#dim red methods
dr_vector <- c('pca2', 'pca5',
               'kpca2', 'kpca5',
               'umap2', 'umap5',
               'phate2', 'phate5',
               'plsda2', 'plsda5')


fem_vector_var <- c('all', 't-test', 'wilcoxontest',
                    'mrmr10', 'mrmr75', 'mrmr_perc50',
                'ga_rf',
                'RF_RFE', 'ranger_impu_cor',
                'pca_var',
                'phate_var', 'umap_var', 'kpca_var',
                'plsda_var')



fem_vector_pcavar <- c('all', 't-test', 'wilcoxontest', 'RF_RFE', 'ga_rf',
                'ranger_impu_cor',
                'mrmr10', 'mrmr75', 'mrmr_perc50',
                'PCA_75',
                'phate_pcavar', 'umap_pcavar', 'kpca_pcavar',
                'plsda_pcavar')




fem_vector_fil_compare <- c('all', 't-test', 'wilcoxontest',
                            'mrmr10', 'mrmr75', 'mrmr_perc50', 'ranger_impu_cor',
                            'all_no_fil', 't-test_no_fil', 'wilcoxontest_no_fil', 
                            'mrmr10_no_fil', 'mrmr75_no_fil', 'mrmr_perc50_no_fil',
                            'ranger_impu_cor_no_fil',
                            'plsda2', 'plsda5',
                            'plsda2_no_fil', 'plsda5_no_fil')


fsm_vector_fil_compare <- c('all', 't-test', 'wilcoxontest',
                            'mrmr10', 'mrmr75', 'mrmr_perc50', 'ranger_impu_cor',
                            'all_no_fil', 't-test_no_fil', 'wilcoxontest_no_fil', 
                            'mrmr10_no_fil', 'mrmr75_no_fil', 'mrmr_perc50_no_fil',
                            'ranger_impu_cor_no_fil')


fsm_vector_for_ji_computation <- c('all', 't-test', 'wilcoxontest',
                            'mrmr30', 'mrmr50', 'ranger_impu_cor',
                            'ga_rf', 'RF_RFE', 'mrmr10', 'mrmr_perc50', 'mrmr75',
                            'all_no_fil', 't-test_no_fil', 'wilcoxontest_no_fil', 
                            'mrmr30_no_fil', 'mrmr50_no_fil', 'ranger_impu_cor_no_fil',
                            'ranger_pos_impu_cor', 'ranger_pos_impu_cor_no_fil')

ranger_fems <- c('ranger_perm', 'ranger_impu', 'ranger_impu_cor', 'ranger_impu_cor_no_fil')

ranger_pos_fems <- c('ranger_pos_perm', 'ranger_pos_impu', 'ranger_pos_impu_cor', 'ranger_pos_impu_cor_no_fil')


#transformation methods
t_vector <- c('PCA_75', 'pca2', 'pca5', 'pca_var',
              'phate2', 'phate5', 
              'umap2', 'umap5', 
              'kpca_all', 'kpca2', 'kpca5',
              'plsda2', 'plsda5',
              'mrmr_plsda',
              'phate_var', 'umap_var', 'kpca_var',
              'plsda_var', 'mrmr_plsda_var',
              'phate_pcavar', 'umap_pcavar', 'kpca_pcavar',
              'plsda_pcavar', 'mrmr_plsda_pcavar',
              'ranger_plsda2', 'ranger_plsda5')

new_t_vector <- c('phate2', 'phate5', 'umap2', 'umap5', 'plsda2', 'plsda5')

best_pca_transform_vector <- c('PCA_75')

model_vector <- c('Simple logistic regression',
                  'L1 Regularized logistic regression',
                  'L2 Regularized logistic regression',
                  'Elastic net logistic regression',
                  'Sigmoid Kernel SVM',
                  'Radial Kernel SVM',
                  'Random Forest')


TEP_datasets <- c('TEP2015_GBMVsHC', 'TEP2015_NSCLCVsHC', 'TEP2015_CancerVsHC', 'TEP2017_NSCLCVsNC',
                  'TEP2015_CRCVsHC', 'TEP2015_BCVsHC', 'TEP2015_PCVsHC')

# TEP_failed_datasets <- c('TEP2015_GBMVsHC', 'TEP2015_NSCLCVsHC', 'TEP2017_NSCLCVsNC', 'TEP2015_CancerVsHC')
# major_disease_datasets <- c('GBM1_GBMVsCont', 'GBM2_GBMVsNC',
#                             'LungCancer1_LUADVsControl', 'LungCancer3_LNSCLCVsCont',
#                             'TEP2015_GBMVsHC', 'TEP2017_NSCLCVsNonCancer')
# non_major_disease_datasets <- c('GBM1_GliomaVsCont', 'GBM2_Astro_OligoVsNC',
#                                 'LungCancer1_LUADVsControl', 'LungCancer3_ENSCLCVsCont')