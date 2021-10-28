setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis")

# devtools::create("FEMPipeline")

setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/FEMPipeline")
devtools::document()
devtools::install()
devtools::check()

#use while debugging
devtools::load_all()

library(FEMPipeline)
welcome()
?welcome
?i_am
i_am("Abhishek")
?execute_pipeline
?show_allowed_fems

devtools::install_github("abhivij/bloodbased-pancancer-diagnosis/FEMPipeline")

# library(usethis)
# use_pipe(export = TRUE)