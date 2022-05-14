# source("R/fem_t_test.R")
# source("R/fem_wilcoxon_test.R")
# source("R/fem_rfrfe.R")
# source("R/fem_ga.R")
# source("R/fem_pca.R")
# source("R/fem_rf_features.R")
# source("R/fem_ranger_features.R")
# source("R/fem_mrmr_features.R")
# source("R/fem_phate_transformation.R")
# source("R/fem_umap_transformation.R")
# source("R/fem_plsda_transformation.R")
# source("R/fem_kpca_transformation.R")
# source("R/fem_mrmr_plsda_transformation.R")
# source("R/fem_ranger_plsda.R")


feature_extraction_arguments <- list(
  list(fsm_name = "all"),
  list(fsm = t_test_features, fsm_name = "t-test"),
  list(fsm = t_test_features, fsm_name = "t-test_pval_0.025", p_value_threshold = 0.025),
  list(fsm = t_test_features, fsm_name = "t-test_pval_0.01", p_value_threshold = 0.01),
  list(fsm = t_test_features, fsm_name = "t-test_pval_0.005", p_value_threshold = 0.005),
  list(fsm = t_test_features, fsm_name = "t-test_holm", adjust_method = 'holm'),
  list(fsm = t_test_features, fsm_name = "t-test_bonferroni", adjust_method = 'bonferroni'),
  list(fsm = t_test_features, fsm_name = "t-test_BH", adjust_method = 'BH'),
  list(fsm = t_test_features, fsm_name = "t-test_BY", adjust_method = 'BY'),
  list(fsm = wilcoxon_test_features, fsm_name = "wilcoxontest"),
  list(fsm = wilcoxon_test_features, fsm_name = "wilcoxontest_pval_0.025", p_value_threshold = 0.025),
  list(fsm = wilcoxon_test_features, fsm_name = "wilcoxontest_pval_0.01", p_value_threshold = 0.01),
  list(fsm = wilcoxon_test_features, fsm_name = "wilcoxontest_pval_0.005", p_value_threshold = 0.005),
  list(fsm = wilcoxon_test_features, fsm_name = "wilcoxontest_holm", adjust_method = 'holm'),
  list(fsm = wilcoxon_test_features, fsm_name = "wilcoxontest_bonferroni", adjust_method = 'bonferroni'),
  list(fsm = wilcoxon_test_features, fsm_name = "wilcoxontest_BH", adjust_method = 'BH'),
  list(fsm = wilcoxon_test_features, fsm_name = "wilcoxontest_BY", adjust_method = 'BY'),
  list(fsm = rfrfe, fsm_name = "RF_RFE"),
  list(fsm = ga, fsm_name = "ga_rf"),
  list(fsm = rf_features, fsm_name = "rf"),
  list(fsm = ranger_features, fsm_name = "ranger_perm", imp = "permutation"),
  list(fsm = ranger_features, fsm_name = "ranger_impu", imp = "impurity"),
  list(fsm = ranger_features, fsm_name = "ranger_impu_cor", imp = "impurity_corrected"),
  list(fsm = mrmr_features, fsm_name = "mrmr10", attr_num = 10),
  list(fsm = mrmr_features, fsm_name = "mrmr20", attr_num = 20),
  list(fsm = mrmr_features, fsm_name = "mrmr30", attr_num = 30),
  list(fsm = mrmr_features, fsm_name = "mrmr50", attr_num = 50),
  list(fsm = mrmr_features, fsm_name = "mrmr75", attr_num = 75),
  list(fsm = mrmr_features, fsm_name = "mrmr_perc25", perc_attr = 25),
  list(fsm = mrmr_features, fsm_name = "mrmr_perc50", perc_attr = 50),
  list(fsm = mrmr_features, fsm_name = "mrmr_perc75", perc_attr = 75),
  list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_50", variance_threshold = 0.5),
  list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_75", variance_threshold = 0.75),
  list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_90", variance_threshold = 0.9),
  list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_95", variance_threshold = 0.95),
  list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_99", variance_threshold = 0.99),
  list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_100"),
  list(transformation = TRUE, fsm = pca_transformation, fsm_name = "pca2", embedding_size = 2),
  list(transformation = TRUE, fsm = pca_transformation, fsm_name = "pca5", embedding_size = 5),
  list(transformation = TRUE, fsm = pca_transformation, fsm_name = "pca_var", var_embedding = TRUE),
  list(transformation = TRUE, fsm = phate_transformation, fsm_name = "phate2", embedding_size = 2),
  list(transformation = TRUE, fsm = phate_transformation, fsm_name = "phate5", embedding_size = 5),
  list(transformation = TRUE, fsm = phate_transformation, fsm_name = "phate_var", var_embedding = TRUE),
  list(transformation = TRUE, fsm = phate_transformation, fsm_name = "phate_pcavar", var_embedding = TRUE, use_pca = TRUE),
  list(transformation = TRUE, fsm = umap_transformation, fsm_name = "umap2", embedding_size = 2),
  list(transformation = TRUE, fsm = umap_transformation, fsm_name = "umap5", embedding_size = 5),
  list(transformation = TRUE, fsm = umap_transformation, fsm_name = "umap_var", var_embedding = TRUE),
  list(transformation = TRUE, fsm = umap_transformation, fsm_name = "umap_pcavar", var_embedding = TRUE, use_pca = TRUE),
  list(transformation = TRUE, fsm = plsda_transformation, fsm_name = "plsda2", embedding_size = 2),
  list(transformation = TRUE, fsm = plsda_transformation, fsm_name = "plsda5", embedding_size = 5),
  list(transformation = TRUE, fsm = plsda_transformation, fsm_name = "plsda_var", var_embedding = TRUE),
  list(transformation = TRUE, fsm = plsda_transformation, fsm_name = "plsda_pcavar", var_embedding = TRUE, use_pca = TRUE),
  list(transformation = TRUE, fsm = kpca_transformation, fsm_name = "kpca_all"),
  list(transformation = TRUE, fsm = kpca_transformation, fsm_name = "kpca2", embedding_size = 2),
  list(transformation = TRUE, fsm = kpca_transformation, fsm_name = "kpca5", embedding_size = 5),
  list(transformation = TRUE, fsm = kpca_transformation, fsm_name = "kpca_var", var_embedding = TRUE),
  list(transformation = TRUE, fsm = kpca_transformation, fsm_name = "kpca_pcavar", var_embedding = TRUE, use_pca = TRUE),
  
  #below ones experimental - didn't give good results
  list(transformation = TRUE, fsm = mrmr_plsda_transformation, fsm_name = "mrmr_plsda", embedding_size = 5),
  list(transformation = TRUE, fsm = mrmr_plsda_transformation, fsm_name = "mrmr_plsda_var", var_embedding = TRUE),
  list(transformation = TRUE, fsm = mrmr_plsda_transformation, fsm_name = "mrmr_plsda_pcavar", var_embedding = TRUE, use_pca = TRUE),
  list(transformation = TRUE, fsm = ranger_plsda_transformation, fsm_name = "ranger_plsda2",
       embedding_size = 2, imp = "impurity_corrected"),
  list(transformation = TRUE, fsm = ranger_plsda_transformation, fsm_name = "ranger_plsda5",
       embedding_size = 5, imp = "impurity_corrected"),
  #end of experimental

  list(filter = FALSE, fsm_name = "all_no_fil"),
  list(fsm = t_test_features, filter = FALSE, fsm_name = "t-test_no_fil"),
  list(fsm = wilcoxon_test_features, filter = FALSE, fsm_name = "wilcoxontest_no_fil"),
  list(fsm = ranger_features, filter = FALSE, fsm_name = "ranger_impu_cor_no_fil",
       imp = "impurity_corrected"),
  list(fsm = mrmr_features, filter = FALSE, fsm_name = "mrmr30_no_fil", attr_num = 30),
  list(fsm = mrmr_features, filter = FALSE, fsm_name = "mrmr50_no_fil", attr_num = 50),
  list(transformation = TRUE, fsm = plsda_transformation, filter = FALSE,
       fsm_name = "plsda2_no_fil", embedding_size = 2),
  list(transformation = TRUE, fsm = plsda_transformation, filter = FALSE,
       fsm_name = "plsda5_no_fil", embedding_size = 5)
)

#' show_allowed_fems
#'
#' Gives list of allowed feature extraction methods that can be used in the pipeline
#' @export
show_allowed_fems <- function(){
  for (fe_arg in feature_extraction_arguments) {
    print(fe_arg[["fsm_name"]])
  }
}
