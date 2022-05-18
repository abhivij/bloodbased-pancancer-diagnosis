dataset_pipeline_arguments <- list(
  
  #1
  #GBM1 GBMVsCont
  #filter <- expression(Age > 55 & Sex == 'M')
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GBMvsCont",
       classes = c("Control", "GBM"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #2
  #GBM1 GBMvsGlioma
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GBMvsGlioma",
       classes = c("Glioma", "GBM"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #3
  #GBM1 GliomavsCont
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GliomavsCont",
       classes = c("Control", "Glioma"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #4
  #GBM2 GBMVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "GBMVsNC",
       classes = c("NonCancer", "GBM"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #5
  #GBM2 GBMVsAstro_Oligo
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "GBMVsAstro_Oligo",
       classes = c("Astro_Oligo", "GBM"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #6
  #GBM2 Astro_OligoVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "Astro_OligoVsNC",
       classes = c("NonCancer", "Astro_Oligo"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #7
  #LungCancer1 LUADVsControl
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer1.txt",
       read_count_dir_path = "data/LungCancer/1",
       read_count_file_name = "GSE111803_Readcount_TPM.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer1",
       classification_criteria = "LUADVsControl",
       classes = c("Control", "LUAD"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #8
  #LungCancer3 NSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "NSCLCVsCont",
       classes = c("control", "NSCLC"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #9
  #LungCancer3 ENSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "ENSCLCVsCont",
       classes = c("control", "earlystageNSCLC"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #10
  #LungCancer3 LNSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "LNSCLCVsCont",
       classes = c("control", "latestageNSCLC"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #11
  #LungCancer3 LNSCLCVsENSCLC
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "LNSCLCVsENSCLC",
       classes = c("earlystageNSCLC", "latestageNSCLC"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),  
  
  #12
  #TEP2015 GBMVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "GBMVsHC",
       classes = c("HC", "GBM"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #13
  #TEP2015 NSCLCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "NSCLCVsHC",
       classes = c("HC", "NSCLC"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #14
  #TEP2015 CancerVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "CancerVsHC",
       classes = c("HC", "Cancer"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #15
  #TEP2017 NSCLCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2017.txt",
       read_count_dir_path = "data/LungCancer/TEP",
       read_count_file_name = "GSE89843_TEP_Count_Matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2017",
       classification_criteria = "NSCLCVsNC",
       classes = c("NonCancer", "NSCLC"),
       cores = 32,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #16
  #TEP2015 CRCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "CRCVsHC",
       classes = c("HC", "CRC"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #17
  #TEP2015 BCsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "BCVsHC",
       classes = c("HC", "BC"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #18
  #TEP2015 PCsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "PCVsHC",
       classes = c("HC", "PancC"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #19
  #GSE71008 CRCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE71008.txt",
       read_count_dir_path = "data/GSE71008",
       read_count_file_name = "GSE71008_Data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GSE71008",
       classification_criteria = "CRCVsHC",
       classes = c("HC", "CRC"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #20
  #GSE83270 BCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE83270.txt",
       read_count_dir_path = "data/GSE83270",
       read_count_file_name = "GSE83270_series_matrix.txt",
       skip_row_count = 57,
       row_count = 2158,
       filter_expression = expression(TRUE),
       dataset_id = "GSE83270",
       classification_criteria = "BCVsHC",
       classes = c("HC", "BC"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  #21
  #GSE22981 EBCVsHC  (Early Stage Breast Cancer Vs Healthy Control)
  list(phenotype_file_name = "phenotype_info/phenotype_GSE22981.txt",
       read_count_dir_path = "data/GSE22981",
       read_count_file_name = "GSE22981_series_matrix.txt",
       skip_row_count = 64,
       row_count = 1145,
       filter_expression = expression(TRUE),
       dataset_id = "GSE22981",
       classification_criteria = "EBCVsHC",
       classes = c("HC", "EBC"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),  
  
  #22
  #GSE73002 BCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE73002.txt",
       read_count_dir_path = "data/GSE73002",
       read_count_file_name = "GSE73002_series_matrix.txt",
       skip_row_count = 73,
       row_count = 2540,
       na_strings = "null",
       filter_expression = expression(TRUE),
       dataset_id = "GSE73002",
       classification_criteria = "BCVsNC",
       classes = c("NC", "BC"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),    
  
  #23
  #GSE44281 BCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE44281.txt",
       read_count_dir_path = "data/GSE44281",
       read_count_file_name = "GSE44281_series_matrix.txt",
       skip_row_count = 67,
       row_count = 20180,
       filter_expression = expression(TRUE),
       dataset_id = "GSE44281",
       classification_criteria = "caseVsnoncase",
       classes = c("noncase", "case"),
       cores = 16,
       fems_to_run = c("all", "t-test", "t-test_pval_0.025", "t-test_pval_0.01", "t-test_pval_0.005", "t-test_holm",
                       "t-test_bonferroni", "t-test_BH", "t-test_BY", "wilcoxontest", "wilcoxontest_pval_0.025",
                       "wilcoxontest_pval_0.01", "wilcoxontest_pval_0.005", "wilcoxontest_holm", "wilcoxontest_bonferroni",
                       "wilcoxontest_BH", "wilcoxontest_BY", "rf", "ranger_perm", "ranger_impu", "ranger_impu_cor",
                       "mrmr10", "mrmr20", "mrmr30", "mrmr50", "mrmr75", "mrmr100", "mrmr_perc25", "mrmr_perc50", "mrmr_perc75")),
  
  ##################
  #ga_rf executions
  
  #1
  #GBM1 GBMVsCont
  #filter <- expression(Age > 55 & Sex == 'M')
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GBMvsCont",
       classes = c("Control", "GBM"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #2
  #GBM1 GBMvsGlioma
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GBMvsGlioma",
       classes = c("Glioma", "GBM"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #3
  #GBM1 GliomavsCont
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GliomavsCont",
       classes = c("Control", "Glioma"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #4
  #GBM2 GBMVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "GBMVsNC",
       classes = c("NonCancer", "GBM"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #5
  #GBM2 GBMVsAstro_Oligo
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "GBMVsAstro_Oligo",
       classes = c("Astro_Oligo", "GBM"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #6
  #GBM2 Astro_OligoVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "Astro_OligoVsNC",
       classes = c("NonCancer", "Astro_Oligo"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #7
  #LungCancer1 LUADVsControl
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer1.txt",
       read_count_dir_path = "data/LungCancer/1",
       read_count_file_name = "GSE111803_Readcount_TPM.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer1",
       classification_criteria = "LUADVsControl",
       classes = c("Control", "LUAD"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #8
  #LungCancer3 NSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "NSCLCVsCont",
       classes = c("control", "NSCLC"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #9
  #LungCancer3 ENSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "ENSCLCVsCont",
       classes = c("control", "earlystageNSCLC"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #10
  #LungCancer3 LNSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "LNSCLCVsCont",
       classes = c("control", "latestageNSCLC"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #11
  #LungCancer3 LNSCLCVsENSCLC
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "LNSCLCVsENSCLC",
       classes = c("earlystageNSCLC", "latestageNSCLC"),
       cores = 16,
       fems_to_run = c("ga_rf")),  
  
  #12
  #TEP2015 GBMVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "GBMVsHC",
       classes = c("HC", "GBM"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #13
  #TEP2015 NSCLCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "NSCLCVsHC",
       classes = c("HC", "NSCLC"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #14
  #TEP2015 CancerVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "CancerVsHC",
       classes = c("HC", "Cancer"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #15
  #TEP2017 NSCLCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2017.txt",
       read_count_dir_path = "data/LungCancer/TEP",
       read_count_file_name = "GSE89843_TEP_Count_Matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2017",
       classification_criteria = "NSCLCVsNC",
       classes = c("NonCancer", "NSCLC"),
       cores = 32,
       fems_to_run = c("ga_rf")),
  
  #16
  #TEP2015 CRCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "CRCVsHC",
       classes = c("HC", "CRC"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #17
  #TEP2015 BCsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "BCVsHC",
       classes = c("HC", "BC"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #18
  #TEP2015 PCsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "PCVsHC",
       classes = c("HC", "PancC"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #19
  #GSE71008 CRCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE71008.txt",
       read_count_dir_path = "data/GSE71008",
       read_count_file_name = "GSE71008_Data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GSE71008",
       classification_criteria = "CRCVsHC",
       classes = c("HC", "CRC"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #20
  #GSE83270 BCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE83270.txt",
       read_count_dir_path = "data/GSE83270",
       read_count_file_name = "GSE83270_series_matrix.txt",
       skip_row_count = 57,
       row_count = 2158,
       filter_expression = expression(TRUE),
       dataset_id = "GSE83270",
       classification_criteria = "BCVsHC",
       classes = c("HC", "BC"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  #21
  #GSE22981 EBCVsHC  (Early Stage Breast Cancer Vs Healthy Control)
  list(phenotype_file_name = "phenotype_info/phenotype_GSE22981.txt",
       read_count_dir_path = "data/GSE22981",
       read_count_file_name = "GSE22981_series_matrix.txt",
       skip_row_count = 64,
       row_count = 1145,
       filter_expression = expression(TRUE),
       dataset_id = "GSE22981",
       classification_criteria = "EBCVsHC",
       classes = c("HC", "EBC"),
       cores = 16,
       fems_to_run = c("ga_rf")),  
  
  #22
  #GSE73002 BCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE73002.txt",
       read_count_dir_path = "data/GSE73002",
       read_count_file_name = "GSE73002_series_matrix.txt",
       skip_row_count = 73,
       row_count = 2540,
       na_strings = "null",
       filter_expression = expression(TRUE),
       dataset_id = "GSE73002",
       classification_criteria = "BCVsNC",
       classes = c("NC", "BC"),
       cores = 16,
       fems_to_run = c("ga_rf")),    
  
  #23
  #GSE44281 BCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE44281.txt",
       read_count_dir_path = "data/GSE44281",
       read_count_file_name = "GSE44281_series_matrix.txt",
       skip_row_count = 67,
       row_count = 20180,
       filter_expression = expression(TRUE),
       dataset_id = "GSE44281",
       classification_criteria = "caseVsnoncase",
       classes = c("noncase", "case"),
       cores = 16,
       fems_to_run = c("ga_rf")),
  
  
  ############
  #RF_RFE executions
  
  
  #1
  #GBM1 GBMVsCont
  #filter <- expression(Age > 55 & Sex == 'M')
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GBMvsCont",
       classes = c("Control", "GBM"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #2
  #GBM1 GBMvsGlioma
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GBMvsGlioma",
       classes = c("Glioma", "GBM"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #3
  #GBM1 GliomavsCont
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GliomavsCont",
       classes = c("Control", "Glioma"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #4
  #GBM2 GBMVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "GBMVsNC",
       classes = c("NonCancer", "GBM"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #5
  #GBM2 GBMVsAstro_Oligo
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "GBMVsAstro_Oligo",
       classes = c("Astro_Oligo", "GBM"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #6
  #GBM2 Astro_OligoVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "Astro_OligoVsNC",
       classes = c("NonCancer", "Astro_Oligo"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #7
  #LungCancer1 LUADVsControl
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer1.txt",
       read_count_dir_path = "data/LungCancer/1",
       read_count_file_name = "GSE111803_Readcount_TPM.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer1",
       classification_criteria = "LUADVsControl",
       classes = c("Control", "LUAD"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #8
  #LungCancer3 NSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "NSCLCVsCont",
       classes = c("control", "NSCLC"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #9
  #LungCancer3 ENSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "ENSCLCVsCont",
       classes = c("control", "earlystageNSCLC"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #10
  #LungCancer3 LNSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "LNSCLCVsCont",
       classes = c("control", "latestageNSCLC"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #11
  #LungCancer3 LNSCLCVsENSCLC
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "LNSCLCVsENSCLC",
       classes = c("earlystageNSCLC", "latestageNSCLC"),
       cores = 16,
       fems_to_run = c("RF_RFE")),  
  
  #12
  #TEP2015 GBMVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "GBMVsHC",
       classes = c("HC", "GBM"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #13
  #TEP2015 NSCLCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "NSCLCVsHC",
       classes = c("HC", "NSCLC"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #14
  #TEP2015 CancerVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "CancerVsHC",
       classes = c("HC", "Cancer"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #15
  #TEP2017 NSCLCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2017.txt",
       read_count_dir_path = "data/LungCancer/TEP",
       read_count_file_name = "GSE89843_TEP_Count_Matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2017",
       classification_criteria = "NSCLCVsNC",
       classes = c("NonCancer", "NSCLC"),
       cores = 32,
       fems_to_run = c("RF_RFE")),
  
  #16
  #TEP2015 CRCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "CRCVsHC",
       classes = c("HC", "CRC"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #17
  #TEP2015 BCsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "BCVsHC",
       classes = c("HC", "BC"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #18
  #TEP2015 PCsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "PCVsHC",
       classes = c("HC", "PancC"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #19
  #GSE71008 CRCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE71008.txt",
       read_count_dir_path = "data/GSE71008",
       read_count_file_name = "GSE71008_Data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GSE71008",
       classification_criteria = "CRCVsHC",
       classes = c("HC", "CRC"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #20
  #GSE83270 BCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE83270.txt",
       read_count_dir_path = "data/GSE83270",
       read_count_file_name = "GSE83270_series_matrix.txt",
       skip_row_count = 57,
       row_count = 2158,
       filter_expression = expression(TRUE),
       dataset_id = "GSE83270",
       classification_criteria = "BCVsHC",
       classes = c("HC", "BC"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  #21
  #GSE22981 EBCVsHC  (Early Stage Breast Cancer Vs Healthy Control)
  list(phenotype_file_name = "phenotype_info/phenotype_GSE22981.txt",
       read_count_dir_path = "data/GSE22981",
       read_count_file_name = "GSE22981_series_matrix.txt",
       skip_row_count = 64,
       row_count = 1145,
       filter_expression = expression(TRUE),
       dataset_id = "GSE22981",
       classification_criteria = "EBCVsHC",
       classes = c("HC", "EBC"),
       cores = 16,
       fems_to_run = c("RF_RFE")),  
  
  #22
  #GSE73002 BCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE73002.txt",
       read_count_dir_path = "data/GSE73002",
       read_count_file_name = "GSE73002_series_matrix.txt",
       skip_row_count = 73,
       row_count = 2540,
       na_strings = "null",
       filter_expression = expression(TRUE),
       dataset_id = "GSE73002",
       classification_criteria = "BCVsNC",
       classes = c("NC", "BC"),
       cores = 16,
       fems_to_run = c("RF_RFE")),    
  
  #23
  #GSE44281 BCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE44281.txt",
       read_count_dir_path = "data/GSE44281",
       read_count_file_name = "GSE44281_series_matrix.txt",
       skip_row_count = 67,
       row_count = 20180,
       filter_expression = expression(TRUE),
       dataset_id = "GSE44281",
       classification_criteria = "caseVsnoncase",
       classes = c("noncase", "case"),
       cores = 16,
       fems_to_run = c("RF_RFE")),
  
  
  
  ########
  #dr executions
  
  #1
  #GBM1 GBMVsCont
  #filter <- expression(Age > 55 & Sex == 'M')
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GBMvsCont",
       classes = c("Control", "GBM"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #2
  #GBM1 GBMvsGlioma
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GBMvsGlioma",
       classes = c("Glioma", "GBM"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #3
  #GBM1 GliomavsCont
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GliomavsCont",
       classes = c("Control", "Glioma"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #4
  #GBM2 GBMVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "GBMVsNC",
       classes = c("NonCancer", "GBM"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #5
  #GBM2 GBMVsAstro_Oligo
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "GBMVsAstro_Oligo",
       classes = c("Astro_Oligo", "GBM"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #6
  #GBM2 Astro_OligoVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "Astro_OligoVsNC",
       classes = c("NonCancer", "Astro_Oligo"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #7
  #LungCancer1 LUADVsControl
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer1.txt",
       read_count_dir_path = "data/LungCancer/1",
       read_count_file_name = "GSE111803_Readcount_TPM.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer1",
       classification_criteria = "LUADVsControl",
       classes = c("Control", "LUAD"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #8
  #LungCancer3 NSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "NSCLCVsCont",
       classes = c("control", "NSCLC"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #9
  #LungCancer3 ENSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "ENSCLCVsCont",
       classes = c("control", "earlystageNSCLC"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #10
  #LungCancer3 LNSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "LNSCLCVsCont",
       classes = c("control", "latestageNSCLC"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #11
  #LungCancer3 LNSCLCVsENSCLC
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "LNSCLCVsENSCLC",
       classes = c("earlystageNSCLC", "latestageNSCLC"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),  
  
  #12
  #TEP2015 GBMVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "GBMVsHC",
       classes = c("HC", "GBM"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #13
  #TEP2015 NSCLCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "NSCLCVsHC",
       classes = c("HC", "NSCLC"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #14
  #TEP2015 CancerVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "CancerVsHC",
       classes = c("HC", "Cancer"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #15
  #TEP2017 NSCLCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2017.txt",
       read_count_dir_path = "data/LungCancer/TEP",
       read_count_file_name = "GSE89843_TEP_Count_Matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2017",
       classification_criteria = "NSCLCVsNC",
       classes = c("NonCancer", "NSCLC"),
       cores = 32,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #16
  #TEP2015 CRCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "CRCVsHC",
       classes = c("HC", "CRC"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #17
  #TEP2015 BCsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "BCVsHC",
       classes = c("HC", "BC"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #18
  #TEP2015 PCsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "PCVsHC",
       classes = c("HC", "PancC"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #19
  #GSE71008 CRCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE71008.txt",
       read_count_dir_path = "data/GSE71008",
       read_count_file_name = "GSE71008_Data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GSE71008",
       classification_criteria = "CRCVsHC",
       classes = c("HC", "CRC"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #20
  #GSE83270 BCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE83270.txt",
       read_count_dir_path = "data/GSE83270",
       read_count_file_name = "GSE83270_series_matrix.txt",
       skip_row_count = 57,
       row_count = 2158,
       filter_expression = expression(TRUE),
       dataset_id = "GSE83270",
       classification_criteria = "BCVsHC",
       classes = c("HC", "BC"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  #21
  #GSE22981 EBCVsHC  (Early Stage Breast Cancer Vs Healthy Control)
  list(phenotype_file_name = "phenotype_info/phenotype_GSE22981.txt",
       read_count_dir_path = "data/GSE22981",
       read_count_file_name = "GSE22981_series_matrix.txt",
       skip_row_count = 64,
       row_count = 1145,
       filter_expression = expression(TRUE),
       dataset_id = "GSE22981",
       classification_criteria = "EBCVsHC",
       classes = c("HC", "EBC"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),  
  
  #22
  #GSE73002 BCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE73002.txt",
       read_count_dir_path = "data/GSE73002",
       read_count_file_name = "GSE73002_series_matrix.txt",
       skip_row_count = 73,
       row_count = 2540,
       na_strings = "null",
       filter_expression = expression(TRUE),
       dataset_id = "GSE73002",
       classification_criteria = "BCVsNC",
       classes = c("NC", "BC"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),    
  
  #23
  #GSE44281 BCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE44281.txt",
       read_count_dir_path = "data/GSE44281",
       read_count_file_name = "GSE44281_series_matrix.txt",
       skip_row_count = 67,
       row_count = 20180,
       filter_expression = expression(TRUE),
       dataset_id = "GSE44281",
       classification_criteria = "caseVsnoncase",
       classes = c("noncase", "case"),
       cores = 16,
       fems_to_run = c("PCA_50", "PCA_75", "PCA_90", "PCA_95", "PCA_99", "PCA_100", "pca2", "pca5", "pca_var",
                       "phate2", "phate5", "phate_var", "phate_pcavar", "umap2", "umap5", "umap_var", "umap_pcavar", 
                       "plsda2", "plsda5", "plsda_var", "plsda_pcavar", "kpca_all", "kpca2", "kpca5", "kpca_var", "kpca_pcavar")),
  
  
  ########
  #experimental
  
  #1
  #GBM1 GBMVsCont
  #filter <- expression(Age > 55 & Sex == 'M')
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GBMvsCont",
       classes = c("Control", "GBM"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #2
  #GBM1 GBMvsGlioma
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GBMvsGlioma",
       classes = c("Glioma", "GBM"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #3
  #GBM1 GliomavsCont
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GliomavsCont",
       classes = c("Control", "Glioma"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #4
  #GBM2 GBMVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "GBMVsNC",
       classes = c("NonCancer", "GBM"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #5
  #GBM2 GBMVsAstro_Oligo
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "GBMVsAstro_Oligo",
       classes = c("Astro_Oligo", "GBM"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #6
  #GBM2 Astro_OligoVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "Astro_OligoVsNC",
       classes = c("NonCancer", "Astro_Oligo"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #7
  #LungCancer1 LUADVsControl
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer1.txt",
       read_count_dir_path = "data/LungCancer/1",
       read_count_file_name = "GSE111803_Readcount_TPM.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer1",
       classification_criteria = "LUADVsControl",
       classes = c("Control", "LUAD"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #8
  #LungCancer3 NSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "NSCLCVsCont",
       classes = c("control", "NSCLC"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #9
  #LungCancer3 ENSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "ENSCLCVsCont",
       classes = c("control", "earlystageNSCLC"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #10
  #LungCancer3 LNSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "LNSCLCVsCont",
       classes = c("control", "latestageNSCLC"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #11
  #LungCancer3 LNSCLCVsENSCLC
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "LNSCLCVsENSCLC",
       classes = c("earlystageNSCLC", "latestageNSCLC"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),  
  
  #12
  #TEP2015 GBMVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "GBMVsHC",
       classes = c("HC", "GBM"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #13
  #TEP2015 NSCLCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "NSCLCVsHC",
       classes = c("HC", "NSCLC"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #14
  #TEP2015 CancerVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "CancerVsHC",
       classes = c("HC", "Cancer"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #15
  #TEP2017 NSCLCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2017.txt",
       read_count_dir_path = "data/LungCancer/TEP",
       read_count_file_name = "GSE89843_TEP_Count_Matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2017",
       classification_criteria = "NSCLCVsNC",
       classes = c("NonCancer", "NSCLC"),
       cores = 32,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #16
  #TEP2015 CRCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "CRCVsHC",
       classes = c("HC", "CRC"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #17
  #TEP2015 BCsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "BCVsHC",
       classes = c("HC", "BC"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #18
  #TEP2015 PCsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "PCVsHC",
       classes = c("HC", "PancC"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #19
  #GSE71008 CRCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE71008.txt",
       read_count_dir_path = "data/GSE71008",
       read_count_file_name = "GSE71008_Data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GSE71008",
       classification_criteria = "CRCVsHC",
       classes = c("HC", "CRC"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #20
  #GSE83270 BCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE83270.txt",
       read_count_dir_path = "data/GSE83270",
       read_count_file_name = "GSE83270_series_matrix.txt",
       skip_row_count = 57,
       row_count = 2158,
       filter_expression = expression(TRUE),
       dataset_id = "GSE83270",
       classification_criteria = "BCVsHC",
       classes = c("HC", "BC"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  #21
  #GSE22981 EBCVsHC  (Early Stage Breast Cancer Vs Healthy Control)
  list(phenotype_file_name = "phenotype_info/phenotype_GSE22981.txt",
       read_count_dir_path = "data/GSE22981",
       read_count_file_name = "GSE22981_series_matrix.txt",
       skip_row_count = 64,
       row_count = 1145,
       filter_expression = expression(TRUE),
       dataset_id = "GSE22981",
       classification_criteria = "EBCVsHC",
       classes = c("HC", "EBC"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),  
  
  #22
  #GSE73002 BCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE73002.txt",
       read_count_dir_path = "data/GSE73002",
       read_count_file_name = "GSE73002_series_matrix.txt",
       skip_row_count = 73,
       row_count = 2540,
       na_strings = "null",
       filter_expression = expression(TRUE),
       dataset_id = "GSE73002",
       classification_criteria = "BCVsNC",
       classes = c("NC", "BC"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),    
  
  #23
  #GSE44281 BCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE44281.txt",
       read_count_dir_path = "data/GSE44281",
       read_count_file_name = "GSE44281_series_matrix.txt",
       skip_row_count = 67,
       row_count = 20180,
       filter_expression = expression(TRUE),
       dataset_id = "GSE44281",
       classification_criteria = "caseVsnoncase",
       classes = c("noncase", "case"),
       cores = 16,
       fems_to_run = c("mrmr_plsda", "mrmr_plsda_var", "mrmr_plsda_pcavar", "ranger_plsda2", "ranger_plsda5")),
  
  
  ############
  #no filter ones
  
  #1
  #GBM1 GBMVsCont
  #filter <- expression(Age > 55 & Sex == 'M')
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GBMvsCont",
       classes = c("Control", "GBM"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #2
  #GBM1 GBMvsGlioma
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GBMvsGlioma",
       classes = c("Glioma", "GBM"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #3
  #GBM1 GliomavsCont
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GliomavsCont",
       classes = c("Control", "Glioma"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #4
  #GBM2 GBMVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "GBMVsNC",
       classes = c("NonCancer", "GBM"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #5
  #GBM2 GBMVsAstro_Oligo
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "GBMVsAstro_Oligo",
       classes = c("Astro_Oligo", "GBM"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #6
  #GBM2 Astro_OligoVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "Astro_OligoVsNC",
       classes = c("NonCancer", "Astro_Oligo"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #7
  #LungCancer1 LUADVsControl
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer1.txt",
       read_count_dir_path = "data/LungCancer/1",
       read_count_file_name = "GSE111803_Readcount_TPM.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer1",
       classification_criteria = "LUADVsControl",
       classes = c("Control", "LUAD"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #8
  #LungCancer3 NSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "NSCLCVsCont",
       classes = c("control", "NSCLC"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #9
  #LungCancer3 ENSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "ENSCLCVsCont",
       classes = c("control", "earlystageNSCLC"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #10
  #LungCancer3 LNSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "LNSCLCVsCont",
       classes = c("control", "latestageNSCLC"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #11
  #LungCancer3 LNSCLCVsENSCLC
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "LNSCLCVsENSCLC",
       classes = c("earlystageNSCLC", "latestageNSCLC"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),  
  
  #12
  #TEP2015 GBMVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "GBMVsHC",
       classes = c("HC", "GBM"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #13
  #TEP2015 NSCLCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "NSCLCVsHC",
       classes = c("HC", "NSCLC"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #14
  #TEP2015 CancerVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "CancerVsHC",
       classes = c("HC", "Cancer"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #15
  #TEP2017 NSCLCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2017.txt",
       read_count_dir_path = "data/LungCancer/TEP",
       read_count_file_name = "GSE89843_TEP_Count_Matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2017",
       classification_criteria = "NSCLCVsNC",
       classes = c("NonCancer", "NSCLC"),
       cores = 32,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #16
  #TEP2015 CRCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "CRCVsHC",
       classes = c("HC", "CRC"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #17
  #TEP2015 BCsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "BCVsHC",
       classes = c("HC", "BC"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #18
  #TEP2015 PCsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "PCVsHC",
       classes = c("HC", "PancC"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #19
  #GSE71008 CRCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE71008.txt",
       read_count_dir_path = "data/GSE71008",
       read_count_file_name = "GSE71008_Data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GSE71008",
       classification_criteria = "CRCVsHC",
       classes = c("HC", "CRC"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #20
  #GSE83270 BCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE83270.txt",
       read_count_dir_path = "data/GSE83270",
       read_count_file_name = "GSE83270_series_matrix.txt",
       skip_row_count = 57,
       row_count = 2158,
       filter_expression = expression(TRUE),
       dataset_id = "GSE83270",
       classification_criteria = "BCVsHC",
       classes = c("HC", "BC"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),
  
  #21
  #GSE22981 EBCVsHC  (Early Stage Breast Cancer Vs Healthy Control)
  list(phenotype_file_name = "phenotype_info/phenotype_GSE22981.txt",
       read_count_dir_path = "data/GSE22981",
       read_count_file_name = "GSE22981_series_matrix.txt",
       skip_row_count = 64,
       row_count = 1145,
       filter_expression = expression(TRUE),
       dataset_id = "GSE22981",
       classification_criteria = "EBCVsHC",
       classes = c("HC", "EBC"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),  
  
  #22
  #GSE73002 BCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE73002.txt",
       read_count_dir_path = "data/GSE73002",
       read_count_file_name = "GSE73002_series_matrix.txt",
       skip_row_count = 73,
       row_count = 2540,
       na_strings = "null",
       filter_expression = expression(TRUE),
       dataset_id = "GSE73002",
       classification_criteria = "BCVsNC",
       classes = c("NC", "BC"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil")),    
  
  #23
  #GSE44281 BCVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GSE44281.txt",
       read_count_dir_path = "data/GSE44281",
       read_count_file_name = "GSE44281_series_matrix.txt",
       skip_row_count = 67,
       row_count = 20180,
       filter_expression = expression(TRUE),
       dataset_id = "GSE44281",
       classification_criteria = "caseVsnoncase",
       classes = c("noncase", "case"),
       cores = 16,
       fems_to_run = c("all_no_fil", "t-test_no_fil", "wilcoxontest_no_fil", "ranger_impu_cor_no_fil",
                       "mrmr30_no_fil", "mrmr50_no_fil", "mrmr100_no_fil", "mrmr_perc50_no_fil",
                       "plsda2_no_fil", "plsda5_no_fil"))
  
)



