source("feature_extraction/t_test.R")
source("feature_extraction/wilcoxon_test.R")
source("feature_extraction/rfrfe.R")
source("feature_extraction/ga.R")
source("feature_extraction/pca.R")
source("feature_extraction/ranger_features.R")
source("feature_extraction/phate_transformation.R")
source("feature_extraction/umap_transformation.R")
source("feature_extraction/plsda_transformation.R")

feature_extraction_arguments <- list(
  # list(fsm_name = "all"),
  list(fsm = t_test_features, fsm_name = "t-test"),
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
  list(fsm = ranger_features, fsm_name = "ranger_perm", imp = "permutation"),
  list(fsm = ranger_features, fsm_name = "ranger_impu", imp = "impurity"),
  list(fsm = ranger_features, fsm_name = "ranger_impu_cor", imp = "impurity_corrected"),
  # list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_50", variance_threshold = 0.5),
  # list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_75", variance_threshold = 0.75),
  # list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_90", variance_threshold = 0.9),
  # list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_95", variance_threshold = 0.95),
  # list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_99", variance_threshold = 0.99),
  # list(transformation = TRUE, fsm = pca_transformation, fsm_name = "PCA_100"),
  list(transformation = TRUE, fsm = phate_transformation, fsm_name = "phate2", embedding_size = 2),
  list(transformation = TRUE, fsm = phate_transformation, fsm_name = "phate5", embedding_size = 5),
  # list(transformation = TRUE, fsm = umap_transformation, fsm_name = "umap2", embedding_size = 2),
  # list(transformation = TRUE, fsm = umap_transformation, fsm_name = "umap5", embedding_size = 5),
  list(transformation = TRUE, fsm = plsda_transformation, fsm_name = "plsda2", embedding_size = 2),
  list(transformation = TRUE, fsm = plsda_transformation, fsm_name = "plsda5", embedding_size = 5)
)