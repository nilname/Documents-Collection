# Goals: Simulate a dataset from a "fixed effects" model, and
#        obtain "least squares dummy variable" (LSDV) estimates.
#
# We do this in the context of a familiar "earnings function" -
#  log earnings is quadratic in log experience, with parallel shifts by
#  education category.

# Create an education factor with 4 levels --
education <- factor(sample(1:4,1000, replace=TRUE),
                    labels=c("none", "school", "college", "beyond"))
# Simulate an experience variable with a plausible range --
experience <- 30*runif(1000)            # experience from 0 to 20 years
# Make the intercept vary by education category between 4 given values --
intercept <- c(0.5,1,1.5,2)[education]

# Simulate the log earnings --
log.earnings <- intercept +
  2*experience - 0.05*experience*experience + rnorm(1000)
A <- data.frame(education, experience, e2=experience*experience, log.earnings)
summary(A)

# The OLS path to LSDV --
summary(lm(log.earnings ~ -1 + education + experience + e2, A))
