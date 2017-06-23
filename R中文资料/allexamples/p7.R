# Goals: Scare the hell out of children with the Cauchy distribution.

# A function which simulates N draws from one of two distributions,
# and returns the mean obtained thusly.
one.simulation <- function(N=100, distribution="normal") {
  if (distribution == "normal") {
    x <- rnorm(N)
  } else {
    x <- rcauchy(N)
  }
  mean(x)
}

k1 <- density(replicate(1000, one.simulation(20)))
k2 <- density(replicate(1000, one.simulation(20, distribution="cauchy")))

xrange <- range(k1$x, k2$x)
plot(k1$x, k1$y, xlim=xrange, type="l", xlab="Estimated value", ylab="")
grid()
lines(k2$x, k2$y, col="red")
abline(v=.5)
legend(x="topleft", bty="n",
       lty=c(1,1), 
       col=c("black", "red"),
       legend=c("Mean of Normal", "Mean of Cauchy"))
# The distribution of the mean of normals collapses into a point;
# that of the cauchy does not.

# Here's more scary stuff --
for (i in 1:10) {
  cat("Sigma of distribution of 1000 draws from mean of normal - ",
      sd(replicate(1000, one.simulation(20))), "\n")
}
for (i in 1:10) {
  cat("Sigma of distribution of 1000 draws from mean of cauchy - ",
      sd(replicate(1000, one.simulation(20, distribution="cauchy"))), "\n")
}

# Exercise for the reader: Compare the distribution of the median of
# the Normal against the distribution of the median of the Cauchy.
