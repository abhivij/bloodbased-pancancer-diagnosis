#!/bin/bash

cd /srv/scratch/vafaeelab/AbhishekVijayan/bloodbased-pancancer-diagnosis/katana_scripts

qsub -l select=1:ncpus=16:mem=124gb,walltime=48:00:00 -M a.vijayan@unsw.edu.au -m ae exec1.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=48:00:00 -M a.vijayan@unsw.edu.au -m ae exec2.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=48:00:00 -M a.vijayan@unsw.edu.au -m ae exec3.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=48:00:00 -M a.vijayan@unsw.edu.au -m ae exec4.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=48:00:00 -M a.vijayan@unsw.edu.au -m ae exec5.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=48:00:00 -M a.vijayan@unsw.edu.au -m ae exec6.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=48:00:00 -M a.vijayan@unsw.edu.au -m ae exec7.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=48:00:00 -M a.vijayan@unsw.edu.au -m ae exec8.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=48:00:00 -M a.vijayan@unsw.edu.au -m ae exec9.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=48:00:00 -M a.vijayan@unsw.edu.au -m ae exec10.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=48:00:00 -M a.vijayan@unsw.edu.au -m ae exec11.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=100:00:00 -M a.vijayan@unsw.edu.au -m ae exec12.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=100:00:00 -M a.vijayan@unsw.edu.au -m ae exec13.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=100:00:00 -M a.vijayan@unsw.edu.au -m ae exec14.pbs
qsub -l select=1:ncpus=32:mem=248gb,walltime=200:00:00 -M a.vijayan@unsw.edu.au -m ae exec15.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=100:00:00 -M a.vijayan@unsw.edu.au -m ae exec16.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=100:00:00 -M a.vijayan@unsw.edu.au -m ae exec17.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=100:00:00 -M a.vijayan@unsw.edu.au -m ae exec18.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=100:00:00 -M a.vijayan@unsw.edu.au -m ae exec19.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=100:00:00 -M a.vijayan@unsw.edu.au -m ae exec20.pbs
qsub -l select=1:ncpus=16:mem=124gb,walltime=100:00:00 -M a.vijayan@unsw.edu.au -m ae exec21.pbs
qsub -l select=1:ncpus=32:mem=248gb,walltime=200:00:00 -M a.vijayan@unsw.edu.au -m ae exec22.pbs
qsub -l select=1:ncpus=32:mem=248gb,walltime=200:00:00 -M a.vijayan@unsw.edu.au -m ae exec23.pbs