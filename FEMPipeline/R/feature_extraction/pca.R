get_first_position <- function(data, threshold) {
  return (Position(function(x) x >= threshold, data))
}


pca_transformation <- function(x.train, y.train, x.test, y.test, classes,
                               variance_threshold = NA, embedding_size = NA, ...){
  
  transform.pca <- prcomp(x.train, center = TRUE, scale. = TRUE)
  x.train <- as.data.frame(transform.pca$x)
  x.test <- as.data.frame(predict(transform.pca, newdata = x.test))
  
  cumulative_proportion <- summary(transform.pca)$importance['Cumulative Proportion',]
  variance_threshold_values <- c()
  variance_threshold_vector <- c(0.5, 0.75, 0.9, 0.95, 0.99)
  for (vt in variance_threshold_vector) {
    variance_threshold_values[toString(vt)] <- get_first_position(cumulative_proportion, vt)
  }
  if (!is.na(variance_threshold)) {
    pcs <- get_first_position(cumulative_proportion, variance_threshold)
    x.train <- x.train[, c(1:pcs), drop = FALSE]
    x.test <- x.test[, c(1:pcs), drop = FALSE]    
  } else if(!is.na(embedding_size)) {
    x.train <- x.train[, c(1:embedding_size), drop = FALSE]
    x.test <- x.test[, c(1:embedding_size), drop = FALSE]
  }

  return (list(x.train, y.train, x.test, y.test, variance_threshold_values))
}
