get_first_position <- function(data, threshold) {
  return (Position(function(x) x >= threshold, data))
}


pca_transformation <- function(x.train, y.train, x.test, y.test, classes){
  
  transform.pca <- prcomp(x.train, center = TRUE, scale. = TRUE)
  x.train <- transform.pca$x
  x.test <- predict(transform.pca, newdata = x.test)
  
  cumulative_proportion <- summary(transform.pca)$importance['Cumulative Proportion',]
  variance_threshold_values <- c()
  variance_thresholds <- c(0.5, 0.75, 0.9, 0.95, 0.99)
  for (vt in variance_thresholds) {
    variance_threshold_values[toString(vt)] <- get_first_position(cumulative_proportion, vt)
  }
  
  return (list(x.train, y.train, x.test, y.test, variance_threshold_values))
}
