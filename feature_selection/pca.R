get_first_position <- function(data, threshold) {
  return (Position(function(x) x >= threshold, data))
}


pca_transformation <- function(x.train, y.train, x.test, y.test, classes){
  
  transform.pca <- prcomp(x.train, center = TRUE, scale. = TRUE)
  x.train <- as.data.frame(transform.pca$x)
  x.test <- as.data.frame(predict(transform.pca, newdata = x.test))
  
  cumulative_proportion <- summary(transform.pca)$importance['Cumulative Proportion',]
  variance_threshold_values <- c()
  variance_thresholds <- c(0.5, 0.75, 0.9, 0.95, 0.99)
  for (vt in variance_thresholds) {
    variance_threshold_values[toString(vt)] <- get_first_position(cumulative_proportion, vt)
  }
  pcs <- variance_threshold_values['0.9']
  x.train <- x.train[, c(1:pcs), drop = FALSE]
  x.test <- x.test[, c(1:pcs), drop = FALSE]
  
  return (list(x.train, y.train, x.test, y.test, variance_threshold_values))
}
