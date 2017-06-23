# Goal: Some of the standard tests

# A classical setting --
x <- runif(100, 0, 10)                  # 100 draws from U(0,10)
y <- 2 + 3*x + rnorm(100)               # beta = [2, 3] and sigma is 1
d <- lm(y ~ x)
# CLS results --
summary(d)

library(sandwich)
library(lmtest)
# Durbin-Watson test --
dwtest(d, alternative="two.sided")
# Breusch-Pagan test --
bptest(d)
# Heteroscedasticity and autocorrelation consistent (HAC) tests
coeftest(d, vcov=kernHAC)

# Tranplant the HAC values back in --
library(xtable)
sum.d <- summary(d)
xtable(sum.d)
sum.d$coefficients[1:2,1:4] <- coeftest(d, vcov=kernHAC)[1:2,1:4]
xtable(sum.d)
