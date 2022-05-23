#old exec_main.py

#currently not using -J option and creating array jobs

# #!/bin/bash
# 
# cd $HOME/bloodbased-pancancer-diagnosis/katana_scripts
# 
# qsub -l select=1:ncpus=16:mem=124gb,walltime=48:00:00 -J 1-11 exec.pbs
# qsub -l select=1:ncpus=16:mem=124gb,walltime=100:00:00 -J 12-14 exec.pbs
# qsub -l select=1:ncpus=16:mem=124gb,walltime=200:00:00 -J 15-16 exec.pbs
# qsub -l select=1:ncpus=16:mem=124gb,walltime=12:00:00 exec25.pbs
# qsub -l select=1:ncpus=16:mem=124gb,walltime=100:00:00 -J 17-22 exec.pbs
# qsub -l select=1:ncpus=16:mem=124gb,walltime=200:00:00 -J 23-24 exec.pbs
# 
# qsub -l select=1:ncpus=16:mem=124gb,walltime=12:00:00 -M a.vijayan@unsw.edu.au -m ae exec1.pbs


file_name = "exec_main.sh"
f = open(file_name, "w")

f.write("#!/bin/bash\n\n")
f.write("cd /srv/scratch/vafaeelab/AbhishekVijayan/bloodbased-pancancer-diagnosis/katana_scripts\n\n")

for method_type in range(1, 6+1):
  for arg in range(1, 23+1):
    if arg == 15 or arg == 22 or arg == 23:
      resources = "ncpus=32:mem=248gb,walltime=200:00:00"
    elif arg > 11:
      resources = "ncpus=16:mem=124gb,walltime=100:00:00"
    else:
      resources = "ncpus=16:mem=124gb,walltime=48:00:00"
      
    q_command = ("qsub -l select=1:" + resources 
    + " -M a.vijayan@unsw.edu.au -m ae exec" + str(23*(method_type-1) + arg)
    + ".pbs")
    f.write(q_command + "\n")
  f.write("\n")
    
# qsub -l select=1:ncpus=16:mem=124gb,walltime=12:00:00 -M a.vijayan@unsw.edu.au -m ae exec1.pbs

for arg in range(138+1, 138+6+1):
  resources = "ncpus=16:mem=124gb,walltime=48:00:00"
  q_command = ("qsub -l select=1:" + resources 
    + " -M a.vijayan@unsw.edu.au -m ae exec" + str(arg)
    + ".pbs")
  f.write(q_command)
  f.write("\n")
  
f.write("\n")

for arg in range(144+1, 144+6+1):
  resources = "ncpus=16:mem=124gb,walltime=48:00:00"
  q_command = ("qsub -l select=1:" + resources 
    + " -M a.vijayan@unsw.edu.au -m ae exec" + str(arg)
    + ".pbs")
  f.write(q_command)
  f.write("\n")
  
f.write("\n")

for arg in range(150+1, 150+6+1):
  resources = "ncpus=16:mem=124gb,walltime=48:00:00"
  q_command = ("qsub -l select=1:" + resources 
    + " -M a.vijayan@unsw.edu.au -m ae exec" + str(arg)
    + ".pbs")
  f.write(q_command)
  f.write("\n")
  
f.write("\n")
  
for arg in range(156+1, 156+30+1):
  resources = "ncpus=16:mem=124gb,walltime=48:00:00"
  q_command = ("qsub -l select=1:" + resources 
    + " -M a.vijayan@unsw.edu.au -m ae exec" + str(arg)
    + ".pbs")
  f.write(q_command)
  f.write("\n")

f.write("\n")
f.close()
