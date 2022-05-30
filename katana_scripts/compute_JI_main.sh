#!/bin/bash

cd /srv/scratch/vafaeelab/AbhishekVijayan/bloodbased-pancancer-diagnosis/katana_scripts

qsub -J 1-23 compute_JI.pbs
qsub compute_JI_139.pbs
qsub compute_JI_145.pbs
qsub compute_JI_151.pbs
qsub compute_JI_197.pbs
qsub compute_JI_270.pbs