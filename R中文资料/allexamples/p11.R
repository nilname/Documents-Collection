# Goal: Simulation to study size and power in a simple problem.

set.seed(101)

# The data generating process: a simple uniform distribution with stated mean
dgp <- function(N,mu) {runif(N)-0.5+mu}

# Simulate one FIXED hypothesis test for H0:mu=0, given a true mu for a sample size N
one.test <- function(N, truemu) {
  x <- dgp(N,truemu)
  muhat <- mean(x)
  s <- sd(x)/sqrt(N)
  # Under the null, the distribution of the mean has standard error s
  threshold <- 1.96*s
  (muhat < -threshold) || (muhat > threshold)
} # Return of TRUE means reject the null

# Do one experiment, where the fixed H0:mu=0 is run Nexperiments times with a sample size N.
# We return only one number: the fraction of the time that H0 is rejected.
experiment <- function(Nexperiments, N, truemu) {
  sum(replicate(Nexperiments, one.test(N, truemu)))/Nexperiments
}

# Measure the size of a test, i.e. rejections when H0 is true
experiment(10000, 50, 0)
# Measurement with sample size of 50, and true mu of 0.

# Power study: I.e. Pr(rejection) when H0 is false
# (one special case in here is when the H0 is actually true)

muvalues <- seq(-.15,.15,.01)
  # When true mu < -0.15 and when true mu > 0.15,
  # the Pr(rejection) veers to 1 (full power) and it's not interesting.

# First do this with sample size of 50
results <- NULL
for (truth in muvalues) {
  results <- c(results, experiment(10000, 50, truth))
}
par(mai=c(.8,.8,.2,.2))
plot(muvalues, results, type="l", lwd=2, ylim=c(0,1),
     xlab="True mu", ylab="Pr(Rejection of H0:mu=0)")
abline(h=0.05, lty=2)

# Now repeat this with sample size of 100 (should yield a higher power)
results <- NULL
for (truth in muvalues) {
  results <- c(results, experiment(10000, 100, truth))
}
lines(muvalues, results, lwd=2, col="blue")
legend(x=-0.15, y=.2, lwd=c(2,1,2), lty=c(1,2,1), cex=.8,
       col=c("black","black","blue"), bty="n",
       legend=c("N=50", "Size, 0.05", "N=100"))
