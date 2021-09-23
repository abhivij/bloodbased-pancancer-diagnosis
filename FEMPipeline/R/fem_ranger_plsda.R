# source("R/feature_extraction/ranger_features.R")
# source("R/feature_extraction/plsda_transformation.R")

ranger_plsda_transformation <- function(x.train, y.train, x.test, y.test, classes,
                                        random_seed = 1000, imp, embedding_size, ...){
  
  ranger_output <- ranger_features(x.train, y.train, x.test, y.test, classes, 
                    imp = imp)
  
  x.train <- ranger_output[[1]]
  y.train <- ranger_output[[2]]
  x.test <- ranger_output[[3]]
  y.test <- ranger_output[[4]]
  
  plsda_output <- plsda_transformation(x.train, y.train, x.test, y.test, classes,
                                       embedding_size = embedding_size)
  
  return (plsda_output)
}