# Goal: Show the efficiency of the mean when compared with the median
#       using a large simulation where both estimators are applied on
#       a sample of U(0,1) uniformly distributed random numbers.

one.simulation <- function(N=100) {     # N defaults to 100 if not supplied
  x <- runif(N)
  return(c(mean(x), median(x)))
}

# Simulation --
results <- replicate(100000, one.simulation(20)) # Gives back a 2x100000 matrix

# Two kernel densities --
k1 <- density(results[1,])              # results[1,] is the 1st row
k2 <- density(results[2,])

# A pretty picture --
xrange <- range(k1$x, k2$x)
plot(k1$x, k1$y, xlim=xrange, type="l", xlab="Estimated value", ylab="")
grid()
lines(k2$x, k2$y, col="red")
abline(v=.5)
legend(x="topleft", bty="n",
       lty=c(1,1), 
       col=c("black", "red"),
       legend=c("Mean", "Median"))
