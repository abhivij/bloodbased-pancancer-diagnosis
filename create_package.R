setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis")

# devtools::create("FEMPipeline")

setwd("~/UNSW/VafaeeLab/bloodbased-pancancer-diagnosis/FEMPipeline")
devtools::document()
devtools::install()

library(FEMPipeline)
welcome()
?welcome
?i_am
i_am("Abhishek")
