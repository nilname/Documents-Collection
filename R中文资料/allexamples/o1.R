# Goal: Simulate a dataset from the OLS model and obtain
#       obtain OLS estimates for it.

x <- runif(100, 0, 10)                  # 100 draws from U(0,10)
y <- 2 + 3*x + rnorm(100)               # beta = [2, 3] and sigma = 1

# You want to just look at OLS results?
summary(lm(y ~ x))

# Suppose x and y were packed together in a data frame --
D <- data.frame(x,y)
summary(lm(y ~ x, D))

# Full and elaborate steps --
d <- lm(y ~ x)
# Learn about this object by saying ?lm and str(d)
# Compact model results --
print(d)
# Pretty graphics for regression diagnostics --
par(mfrow=c(2,2))
plot(d)

d <- summary(d)
# Detailed model results --
print(d)
# Learn about this object by saying ?summary.lm and by saying str(d)
cat("OLS gave slope of ", d$coefficients[2,1],
    "and a error sigma of ", d$sigma, "\n")


## I need to drop down to a smaller dataset now --
x <- runif(10)
y <- 2 + 3*x + rnorm(10)
m <- lm(y ~ x)

# Now R supplies a wide range of generic functions which extract
# useful things out of the result of estimation of many kinds of models.

residuals(m)
fitted(m)
AIC(m)
AIC(m, k=log(10))                        # SBC
vcov(m)
logLik(m)
