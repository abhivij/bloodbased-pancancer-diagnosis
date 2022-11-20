# library(edgeR)
# library(caret)

#   x.train, x.test format : (samples x transcripts)
#   y.train, y.test format : (2 columns : Sample, Label)
filter_and_normalize <- function(x.train, y.train, x.test, y.test, filter = TRUE,
                                 perform_filter = TRUE,
                                 norm = c("norm_log_cpm", "norm_log_cpm_simple",
                                          "quantile", "norm_quantile", 
                                          "vsn", "norm_log_tmm", "log_tmm", "none")){
  
  x.train <- as.data.frame(t(as.matrix(x.train)))
  x.test <- as.data.frame(t(as.matrix(x.test)))
  
  if (perform_filter && filter) {
    filtered_list <- perform_filter(x.train, y.train, x.test, y.test)
    x.train <- filtered_list[[1]]
    x.test <- filtered_list[[3]]
  }
  
  #transpose on x.train, x.test done in perform_norm
  #so result : x.train, x.test format : (samples x transcripts)
  preprocessed_data_list <- perform_norm(norm, x.train, y.train, x.test, y.test)

  return (preprocessed_data_list)
}


# test_data <- matrix(rep(1:20), nrow = 4, ncol = 5,
#                     dimnames = list(c("r1", "r2", "r3", "r4"),
#                                     c("c1", "c2", "c3", "c4", "c5")))
# edgeR::filterByExpr(test_data)
# edgeR::cpm(test_data)
# rowSums(edgeR::cpm(test_data))
# colSums(edgeR::cpm(test_data))
# 
# scale(test_data)
# param <- caret::preProcess(test_data)
# predict(param, test_data)


# test_data <- matrix(rep(9:-10), nrow = 4, ncol = 5,
#                     dimnames = list(c("r1", "r2", "r3", "r4"),
#                                     c("c1", "c2", "c3", "c4", "c5")))
# edgeR::filterByExpr(test_data)
# #fails
# edgeR::cpm(test_data)
# #fails
# scale(test_data)
# param <- caret::preProcess(test_data)
# predict(param, test_data)


# test_data <- matrix(sample(-100:100, 20), nrow = 4, ncol = 5,
#                     dimnames = list(c("r1", "r2", "r3", "r4"),
#                                     c("c1", "c2", "c3", "c4", "c5")))
# scale_col <- scale(test_data)
# scale_col_t <- t(scale_col)
# param <- caret::preProcess(scale_col_t) 
# scale_col_t <- predict(param, scale_col_t)


# test_func <- function(arg1 = c(FALSE, "arg1", "arg12"), arg2 = "arg2"){
#   print(paste("arg1", arg1))
#   print(paste("arg2", arg2))
# }
# 
# test_func(arg1 = FALSE)
