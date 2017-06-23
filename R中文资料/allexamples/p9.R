# Goal: Standard computations with well-studied distributions.

# The normal distribution is named "norm". With this, we have:

# Normal density
dnorm(c(-1.96,0,1.96))

# Cumulative normal density
pnorm(c(-1.96,0,1.96))

# Inverse of this
qnorm(c(0.025,.5,.975))
pnorm(qnorm(c(0.025,.5,.975)))

# 1000 random numbers from the normal distribution
summary(rnorm(1000))


# Here's the same ideas, for the chi-squared distribution with 10 degrees
# of freedom.
dchisq(c(0,5,10), df=10)

# Cumulative normal density
pchisq(c(0,5,10), df=10)

# Inverse of this
qchisq(c(0.025,.5,.975), df=10)

# 1000 random numbers from the normal distribution
summary(rchisq(1000, df=10))
