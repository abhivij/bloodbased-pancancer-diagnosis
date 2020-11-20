#!/bin/bash

cd $HOME/bloodbased-pancancer-diagnosis/katana_scripts

qsub -l select=1:ncpus=16:mem=124gb,walltime=48:00:00 -J 1-11 exec.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=100:00:00 -J 12-15 exec.pbs