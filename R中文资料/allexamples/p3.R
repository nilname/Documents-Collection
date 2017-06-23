# Goal: To do OLS by MLE.

# OLS likelihood function
# Note: I am going to write the LF using sigma2=sigma^2 and not sigma.
ols.lf1 <- function(theta, y, X) {
  beta <- theta[-1]
  sigma2 <- theta[1]
  if (sigma2 <= 0) return(NA)
  n <- nrow(X)
  e <- y - X%*%beta                                  # t() = matrix transpose
  logl <- ((-n/2)*log(2*pi)) - ((n/2)*log(sigma2)) - ((t(e)%*%e)/(2*sigma2))
  return(-logl) # since optim() does minimisation by default.
}

# Analytical derivatives
ols.gradient <- function(theta, y, X) {
  beta <- theta[-1]
  sigma2 <- theta[1]
  e <- y - X%*%beta
  n <- nrow(X)

  g <- numeric(length(theta))  
  g[1] <- (-n/(2*sigma2)) + (t(e)%*%e)/(2*sigma2*sigma2) # d logl / d sigma
  g[-1] <- (t(X) %*% e)/sigma2                           # d logl / d beta

  return(-g)
}

X <- cbind(1, runif(1000))
theta.true <- c(2,4,6) # error variance = 2, intercept = 4, slope = 6.
y <- X %*% theta.true[-1] + sqrt(theta.true[1]) * rnorm(1000)

# Estimation by OLS --
d <- summary(lm(y ~ X[,2]))
theta.ols <- c(sigma2 = d$sigma^2, d$coefficients[,1])
cat("OLS theta = ", theta.ols, "\n\n")

cat("\nGradient-free (constrained optimisation) --\n")
optim(c(1,1,1), method="L-BFGS-B", fn=ols.lf1,
      lower=c(1e-6,-Inf,-Inf), upper=rep(Inf,3), y=y, X=X)

cat("\nUsing the gradient (constrained optimisation) --\n")
optim(c(1,1,1), method="L-BFGS-B", fn=ols.lf1, gr=ols.gradient,
      lower=c(1e-6,-Inf,-Inf), upper=rep(Inf,3), y=y, X=X)

cat("\n\nYou say you want a covariance matrix?\n")
p <- optim(c(1,1,1), method="L-BFGS-B", fn=ols.lf1, gr=ols.gradient,
           lower=c(1e-6,-Inf,-Inf), upper=rep(Inf,3), hessian=TRUE,
           y=y, X=X)
inverted <- solve(p$hessian)
results <- cbind(p$par, sqrt(diag(inverted)), p$par/sqrt(diag(inverted)))
colnames(results) <- c("Coefficient", "Std. Err.", "t")
rownames(results) <- c("Sigma", "Intercept", "X")
cat("MLE results --\n")
print(results)
cat("Compare with the OLS results --\n")
d$coefficients

# Picture of how the loglikelihood changes if you perturb the sigma
theta <- theta.ols
delta.values <- seq(-1.5, 1.5, .01)
logl.values <- as.numeric(lapply(delta.values,
                                 function(x) {-ols.lf1(theta+c(x,0,0),y,X)}))
plot(sqrt(theta[1]+delta.values), logl.values, type="l", lwd=3, col="blue",
     xlab="Sigma", ylab="Log likelihood")
grid()
