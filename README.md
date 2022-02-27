# Blood-based transcriptomic signature panel identification for cancer diagnosis: Benchmarking of feature extraction methods

## Problem 
Compare feature extraction methods for binary classification of cancer types and subtypes using blood-based biomarkers.

### Approach
Build a generic pipeline to run any biomarker dataset on multiple feature extraction methods and classification models

### Type of data used
* microRNAs from Extra Cellular Vesicles
* Total RNA from Tumour Educated Platelets
* microRNAs from blood
* microRNAs from serum

### Pipeline
![pipeline](pipeline.svg)

The Feature Extraction Method comparison pipeline code is made available as an R package, inside the directory FEMPipeline.

To use this in your project :
```
devtools::install_github("abhivij/bloodbased-pancancer-diagnosis/FEMPipeline")
```
And within R :
```
library(FEMPipeline)
```

### Code & Directory Structure
The R script files outside the FEMPipeline directory calls the FEMPipeline package for datasets relevant to this study

* [pipeline_executor.R](pipeline_executor.R) : starting point to call pipeline
* [dataset_pipeline_arguments.R](dataset_pipeline_arguments.R) : list of datasets and its meta-data, used by pipeline_executor.R as arguments to call pipeline
* katana_scripts/ : scripts to call pipeline_executor.R in Katana computational cluster
* data/ : contains source data, extracted data and preprocessed data
* phenotype_info/ : contains currently used phenotype files and the script used in some steps of phenotype file creation
* data_extraction/ : data extraction step in the pipeline
* results_processing/ : scripts to generate plots from results, statistically analyze results, compute pairwise Jaccard Index, combine results, analyze results specifically of that of Ranger feature selection method
* install.R : list of packages to be installed to run this pipeline
