# Goal: R syntax where model specification is an argument to a function.

# Invent a dataset
x <- runif(100); y <- runif(100); z <- 2 + 3*x + 4*y + rnorm(100)
D <- data.frame(x=x, y=y, z=z)

amodel <- function(modelstring) {
  summary(lm(modelstring, D))
}

amodel(z ~ x)
amodel(z ~ y)
