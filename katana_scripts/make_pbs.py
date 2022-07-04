for arg in range(1, 520+1):
    file_name = "exec" + str(arg) + ".pbs"
    f = open(file_name, "w")

    f.write("#!/bin/bash\n\n")
    f.write("cd /srv/scratch/vafaeelab/AbhishekVijayan/bloodbased-pancancer-diagnosis\n\n")
    f.write("source ~/.venvs/forR/bin/activate\n\n")
    f.write("module load gcc/7.5.0\n")
    f.write("module load R/4.2.0-gcc7-clean\n\n")

    r_command = ("Rscript pipeline_executor.R --args " + str(arg))
    f.write(r_command)

    f.write("\n")

    f.close()
