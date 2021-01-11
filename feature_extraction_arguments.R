source("feature_extraction/t_test.R")
source("feature_extraction/wilcoxon_test.R")
source("feature_extraction/rfrfe.R")
source("feature_extraction/ga.R")
source("feature_extraction/pca.R")
source("feature_extraction/rf_features.R")
source("feature_extraction/ranger_features.R")
source("feature_extraction/mrmr_features.R")
source("feature_extraction/phate_transformation.R")
source("feature_extraction/umap_transformation.R")
source("feature_extraction/plsda_transformation.R")
source("feature_extraction/kpca_transformation.R")
source("feature_extraction/mrmr_plsda_transformation.R")


feature_extraction_arguments <- list(
  # list(fsm_name = "all"),
  # list(fsm = t_test_features, fsm_name = "t-test"),
  # list(fsm = t_test_features, fsm_name = "t-test_holm", adjust_method = 'holm'),
  # list(fsm = t_test_features, fsm_name = "t-test_bonferroni", adjust_method = 'bonferroni'),
  # list(fsm = t_test_features, fsm_name = "t-test_BH", adjust_method = 'BH'),
  # list(fsm = t_test_features, fsm_name = "t-test_BY", adjust_method = 'BY'),
  # list(fsm = wilcoxon_test_features, fsm_name = "wilcoxontest"),
  # list(fsm = wilcoxon_test_features, fsm_name = "wilcoxontest_holm", adjust_method = 'holm'),
  # list(fsm = wilcoxon_test_features, fsm_name = "wilcoxontest_bonferroni", adjust_method = 'bonferroni'),
  # list(fsm = wilcoxon_test_features, fsm_name = "wilcoxontest_BH", adjust_method = 'BH'),
  # list(fsm = wilcoxon_test_features, fsm_name = "wilcoxontest_BY", adjust_method = 'BY'),
  # list(fsm = rfrfe, fsm_name = "RF_RFE"),
  # list(fsm = ga, fsm_name = "ga_rf"),
  # list(fsm = rf_features, fsm_name = "rf"),
  # list(fsm = ranger_features, fsm_name = "ranger_perm", imp = "permutation")
  # list(fsm = ranger_features, fsm_name = "ranger_impu", imp = "impurity"),
  # list(fsm = ranger_features, fsm_name = "ranger_impu_cor", imp = "impurity_corrected"),
  # list(fsm = mrmr_features, fsm_name = "mrmr30", attr_num = 30),
  # list(fsm = mrmr_features, fsm_name = "mrmr50", attr_num = 50),
  # list(fsm = mrmr_features, fsm_name = "mrmr75", attr_num = 75),
  # list(fsm = mrmr_features, fsm_name = "mrmr100", attr_num = 100),
  # list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_50", variance_threshold = 0.5),
  # list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_75", variance_threshold = 0.75),
  # list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_90", variance_threshold = 0.9),
  # list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_95", variance_threshold = 0.95),
  # list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_99", variance_threshold = 0.99),
  # list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_100"),
  # list(transformation = TRUE, fsm = pca_transformation, fsm_name = "pca2", embedding_size = 2),
  # list(transformation = TRUE, fsm = pca_transformation, fsm_name = "pca5", embedding_size = 5),
  # list(transformation = TRUE, fsm = pca_transformation, fsm_name = "pca_var", var_embedding = TRUE),
  # list(transformation = TRUE, fsm = phate_transformation, fsm_name = "phate2", embedding_size = 2),
  # list(transformation = TRUE, fsm = phate_transformation, fsm_name = "phate5", embedding_size = 5),
  # list(transformation = TRUE, fsm = phate_transformation, fsm_name = "phate_var", var_embedding = TRUE),
  # list(transformation = TRUE, fsm = phate_transformation, fsm_name = "phate_pcavar", var_embedding = TRUE, use_pca = TRUE),
  # list(transformation = TRUE, fsm = umap_transformation, fsm_name = "umap2", embedding_size = 2),
  # list(transformation = TRUE, fsm = umap_transformation, fsm_name = "umap5", embedding_size = 5),
  # list(transformation = TRUE, fsm = umap_transformation, fsm_name = "umap_var", var_embedding = TRUE),
  # list(transformation = TRUE, fsm = umap_transformation, fsm_name = "umap_pcavar", var_embedding = TRUE, use_pca = TRUE),
  # list(transformation = TRUE, fsm = plsda_transformation, fsm_name = "plsda2", embedding_size = 2),
  # list(transformation = TRUE, fsm = plsda_transformation, fsm_name = "plsda5", embedding_size = 5),
  # list(transformation = TRUE, fsm = plsda_transformation, fsm_name = "plsda_var", var_embedding = TRUE),
  # list(transformation = TRUE, fsm = plsda_transformation, fsm_name = "plsda_pcavar", var_embedding = TRUE, use_pca = TRUE),
  # list(transformation = TRUE, fsm = kpca_transformation, fsm_name = "kpca_all"),
  # list(transformation = TRUE, fsm = kpca_transformation, fsm_name = "kpca2", embedding_size = 2),
  # list(transformation = TRUE, fsm = kpca_transformation, fsm_name = "kpca5", embedding_size = 5),
  # list(transformation = TRUE, fsm = kpca_transformation, fsm_name = "kpca_var", var_embedding = TRUE),
  # list(transformation = TRUE, fsm = kpca_transformation, fsm_name = "kpca_pcavar", var_embedding = TRUE, use_pca = TRUE),
  # list(transformation = TRUE, fsm = mrmr_plsda_transformation, fsm_name = "mrmr_plsda", embedding_size = 5),
  # list(transformation = TRUE, fsm = mrmr_plsda_transformation, fsm_name = "mrmr_plsda_var", var_embedding = TRUE),
  # list(transformation = TRUE, fsm = mrmr_plsda_transformation, fsm_name = "mrmr_plsda_pcavar", var_embedding = TRUE, use_pca = TRUE),

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