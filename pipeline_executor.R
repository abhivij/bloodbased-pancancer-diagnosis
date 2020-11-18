setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/")
source("pipeline.R")
source("dataset_pipeline_arguments.R")

args = commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
  print('Executing pipeline on all datasets')
  for (dparg in dataset_pipeline_arguments) {
    do.call(execute_pipeline, dparg)
  }
} else {
  print(paste('Executing pipeline on dataset', args[1]))
  dparg = dataset_pipeline_arguments[[args[1]]]
  do.call(execute_pipeline, dparg)
}



