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
       classes = c("Control", "GBM")),
  
  #2
  #GBM1 GBMvsGlioma
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GBMvsGlioma",
       classes = c("Glioma", "GBM")),
  
  #3
  #GBM1 GliomavsCont
  list(phenotype_file_name = "phenotype_info/phenotype_GBM1.txt",
       read_count_dir_path = "data/GBM/1",
       read_count_file_name = "GSE122488_normalized_microRNA_counts.txt",
       skip_row_count = 3,
       filter_expression = expression(TRUE),
       dataset_id = "GBM1",
       classification_criteria = "GliomavsCont",
       classes = c("Control", "Glioma")),
  
  #4
  #GBM2 GBMVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "GBMVsNC",
       classes = c("NonCancer", "GBM")),

  #5
  #GBM2 GBMVsAstro_Oligo
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "GBMVsAstro_Oligo",
       classes = c("Astro_Oligo", "GBM")),

  #6
  #GBM2 Astro_OligoVsNC
  list(phenotype_file_name = "phenotype_info/phenotype_GBM2.txt",
       read_count_dir_path = "data/GBM/2",
       read_count_file_name = "GSE112462.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "GBM2",
       classification_criteria = "Astro_OligoVsNC",
       classes = c("NonCancer", "Astro_Oligo")),

  #7
  #LungCancer1 LUADVsControl
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer1.txt",
       read_count_dir_path = "data/LungCancer/1",
       read_count_file_name = "GSE111803_Readcount_TPM.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer1",
       classification_criteria = "LUADVsControl",
       classes = c("Control", "LUAD")),

  #8
  #LungCancer3 NSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "NSCLCVsCont",
       classes = c("control", "NSCLC")),

  #9
  #LungCancer3 ENSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "ENSCLCVsCont",
       classes = c("control", "earlystageNSCLC")),

  #10
  #LungCancer3 LNSCLCVsCont
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "LNSCLCVsCont",
       classes = c("control", "latestageNSCLC")),

  #11
  #LungCancer3 LNSCLCVsENSCLC
  list(phenotype_file_name = "phenotype_info/phenotype_LungCancer3.txt",
       read_count_dir_path = "data/LungCancer/3",
       read_count_file_name = "GSE114711.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "LungCancer3",
       classification_criteria = "LNSCLCVsENSCLC",
       classes = c("earlystageNSCLC", "latestageNSCLC")),  

  #12
  #TEP2015 GBMVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "GBMVsHC",
       classes = c("HC", "GBM")),

  #13
  #TEP2015 NSCLCVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "NSCLCVsHC",
       classes = c("HC", "NSCLC")),

  #14
  #TEP2015 CancerVsHC
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2015.txt",
       read_count_dir_path = "data/GBM/TEP",
       read_count_file_name = "GSE68086_TEP_data_matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2015",
       classification_criteria = "CancerVsHC",
       classes = c("HC", "Cancer")),

  #15
  #TEP2017 NSCLCVsNonCancer
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2017.txt",
       read_count_dir_path = "data/LungCancer/TEP",
       read_count_file_name = "GSE89843_TEP_Count_Matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2017",
       classification_criteria = "NSCLCVsNC",
       classes = c("NonCancer", "NSCLC"))
)



