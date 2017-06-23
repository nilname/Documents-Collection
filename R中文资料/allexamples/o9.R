# Goal: Experiment with fitting nonlinear functional forms in
#       OLS, using orthogonal polynomials to avoid difficulties with
#       near-singular design matrices that occur with ordinary polynomials.
#       Shriya Anand, Gabor Grothendieck, Ajay Shah, March 2006.

# We will deal with noisy data from the d.g.p. y = sin(x) + e
x <- seq(0, 2*pi, length.out=50)
set.seed(101)
y <- sin(x) + 0.3*rnorm(50)
basicplot <- function(x, y, minx=0, maxx=3*pi, title="") {
  plot(x, y, xlim=c(minx,maxx), ylim=c(-2,2), main=title)
  lines(x, sin(x), col="blue", lty=2, lwd=2)
  abline(h=0, v=0)
}
x.outsample <- seq(0, 3*pi, length.out=100)

# Severe multicollinearity with ordinary polynomials
x2 <- x*x
x3 <- x2*x
x4 <- x3*x
cor(cbind(x, x2, x3, x4))
# and a perfect design matrix using orthogonal polynomials
m <- poly(x, 4)
all.equal(cor(m), diag(4))              # Correlation matrix is I.

par(mfrow=c(2,2))
# Ordinary polynomial regression --
  p <- lm(y ~ x + I(x^2) + I(x^3) + I(x^4))
  summary(p)
  basicplot(x, y, title="Polynomial, insample") # Data
  lines(x, fitted(p), col="red", lwd=3)  # In-sample
  basicplot(x, y, title="Polynomial, out-of-sample")
  predictions.p <- predict(p, list(x = x.outsample))    # Out-of-sample
  lines(x.outsample, predictions.p, type="l", col="red", lwd=3)
  lines(x.outsample, sin(x.outsample), type="l", col="blue", lwd=2, lty=2)
  # As expected, polynomial fitting gives terrible results out of sample.

# These IDENTICAL things using orthogonal polynomials
  d <- lm(y ~ poly(x, 4))
  summary(d)
  basicplot(x, y, title="Orth. poly., insample") # Data
  lines(x, fitted(d), col="red", lwd=3)  # In-sample
  basicplot(x, y, title="Orth. poly., out-of-sample")
  predictions.op <- predict(d, list(x = x.outsample))    # Out-of-sample
  lines(x.outsample, predictions.op, type="l", col="red", lwd=3) 
  lines(x.outsample, sin(x.outsample), type="l", col="blue", lwd=2, lty=2)

# predict(d) is magical! See ?SafePrediction
# The story runs at two levels. First, when you do an OLS model,
# predict()ion requires applying coefficients to an appropriate
# X matrix. But one level deeper, the polynomial or orthogonal-polynomial
# needs to be utilised for computing the X matrix based on the
# supplied x.outsample data.
# If you say p <- poly(x, n)
# then you can say predict(p, new) where predict.poly() gets invoked.
# And when you say predict(lm()), the full steps are worked out for
# you automatically: predict.poly() is used to make an X matrix and
# then prediction based on the regression results is done.

all.equal(predictions.p, predictions.op) # Both paths are identical for this
                                         # (tame) problem.
