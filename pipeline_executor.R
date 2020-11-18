setwd("~/bloodbased-pancancer-diagnosis/")
source("pipeline.R")
source("dataset_pipeline_arguments.R")

args = commandArgs(trailingOnly = TRUE)
if (length(args) > 1) {
  print('Executing pipeline on all datasets')
  for (dparg in dataset_pipeline_arguments) {
    do.call(execute_pipeline, dparg)
  }
} else {
  print(paste('Executing pipeline on dataset', args[2]))
  dparg = dataset_pipeline_arguments[[args[2]]]
  do.call(execute_pipeline, dparg)
}



