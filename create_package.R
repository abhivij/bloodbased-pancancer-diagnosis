setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis")

# devtools::create("FEMPipeline")

setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/FEMPipeline")
devtools::document()
devtools::install()
devtools::check()

library(FEMPipeline)
welcome()
?welcome
?i_am
i_am("Abhishek")
?execute_pipeline


devtools::install_github("abhivij/bloodbased-pancancer-diagnosis/FEMPipeline",
                         ref = "packagify")

# library(usethis)
# use_pipe(export = TRUE)