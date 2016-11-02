fitness = function(data, podstawienie) {
  a <- 1
  for (i in 1:nrow(data)) {
    b <- 0
    for (j in 1:ncol(data))
      b <- b + data[i, j]
    
    a <- a * b
  }
}