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
       cores = 16 ),
  
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
       cores = 16 ),
  
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
       cores = 16 ),
  
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
       cores = 16 ),
  
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
       cores = 16 ),
  
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
       cores = 16 ),
  
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
       cores = 16 ),
  
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
       cores = 16 ),
  
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
       cores = 16 ),
  
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
       cores = 16 ),
  
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
       cores = 16 ),  
  
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
       cores = 16 ),
  
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
       cores = 16 ),
  
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
       cores = 16 ),
  
  #15
  #TEP2017 NSCLCVsNonCancer
  list(phenotype_file_name = "phenotype_info/phenotype_TEP2017.txt",
       read_count_dir_path = "data/LungCancer/TEP",
       read_count_file_name = "GSE89843_TEP_Count_Matrix.txt",
       skip_row_count = 0,
       filter_expression = expression(TRUE),
       dataset_id = "TEP2017",
       classification_criteria = "NSCLCVsNC",
       classes = c("NonCancer", "NSCLC"),
       cores = 16 ),
  
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
       cores = 16 ),
  
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
       cores = 16 ),
  
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
       cores = 16 ),
  
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
       cores = 16 ),
  
  # not possible to use PCVsHC and CancerVsHC, because some samples 
  #                               are differently named in datafile as shown below
  # > setdiff(GSE71008_data$Sample, GSE71008_meta_data$Sample)
  # [1] "TB.549"  "TB.650"  "TB.670"  "TB.535"  "TB.01.1" "S021"   
  # > setdiff(GSE71008_meta_data$Sample, GSE71008_data$Sample)
  # [1] "Pan01" "Pan02" "Pan03" "Pan04" "Pan05" "Pan06"
  
  # these commented #20 to #23 have -ve values. can't use
  # #20
  # #GSE41526 preBCVsHC
  # list(phenotype_file_name = "phenotype_info/phenotype_GSE41526.txt",
  #      read_count_dir_path = "data/GSE41526",
  #      read_count_file_name = "GSE41526_series_matrix.txt",
  #      skip_row_count = 64,
  #      row_count = 1145,
  #      filter_expression = expression(TRUE),
  #      dataset_id = "GSE41526",
  #      classification_criteria = "preBCVsHC",
  #      classes = c("HC", "preBC"),
  cores = 16 ),  
# 
# #21
# #GSE41526 postBCVsHC
# list(phenotype_file_name = "phenotype_info/phenotype_GSE41526.txt",
#      read_count_dir_path = "data/GSE41526",
#      read_count_file_name = "GSE41526_series_matrix.txt",
#      skip_row_count = 64,
#      row_count = 1145,
#      filter_expression = expression(TRUE),
#      dataset_id = "GSE41526",
#      classification_criteria = "postBCVsHC",
#      classes = c("HC", "postBC"),
cores = 16 ),  
# 
# #22
# #GSE41526 BCVsHC
# list(phenotype_file_name = "phenotype_info/phenotype_GSE41526.txt",
#      read_count_dir_path = "data/GSE41526",
#      read_count_file_name = "GSE41526_series_matrix.txt",
#      skip_row_count = 64,
#      row_count = 1145,
#      filter_expression = expression(TRUE),
#      dataset_id = "GSE41526",
#      classification_criteria = "BCVsHC",
#      classes = c("HC", "BC"),
cores = 16 ),
# 
# #23
# #GSE41526 CancerVsHC
# list(phenotype_file_name = "phenotype_info/phenotype_GSE41526.txt",
#      read_count_dir_path = "data/GSE41526",
#      read_count_file_name = "GSE41526_series_matrix.txt",
#      skip_row_count = 64,
#      row_count = 1145,
#      filter_expression = expression(TRUE),
#      dataset_id = "GSE41526",
#      classification_criteria = "CancerVsHC",
#      classes = c("HC", "Cancer"),
cores = 16 )  

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
     cores = 16 ),

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
     cores = 16 ),  

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
     cores = 16 ),    

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
     cores = 16 )      

)



