# Goal: The amazing R vector notation.

cat("EXAMPLE 1: sin(x) for a vector --\n")
# Suppose you have a vector x --
x = c(0.1,0.6,1.0,1.5)

# The bad way --
n = length(x)
r = numeric(n)
for (i in 1:n) {
  r[i] = sin(x[i])
}
print(r)

# The good way -- don't use loops --
print(sin(x))


cat("\n\nEXAMPLE 2: Compute the mean of every row of a matrix --\n")
# Here's another example. It isn't really about R; it's about thinking in
# matrix notation. But still.
# Let me setup a matrix --
N=4; M=100;
r = matrix(runif(N*M), N, M)

# So I face a NxM matrix 
#               [r11 r12 ... r1N]
#               [r21 r22 ... r2N]
#               [r32 r32 ... r3N]
# My goal: each column needs to be reduced to a mean.

# Method 1 uses loops:
mean1 = numeric(M)
for (i in 1:M) {
  mean1[i] = mean(r[,i])
}

# Alternatively, just say:
mean2 = rep(1/N, N) %*% r               # Pretty!

# The two answers are the same --
all.equal(mean1,mean2[,])
#
# As an aside, I should say that you can do this directly by using
# the rowMeans() function. But the above is more about pedagogy rather
# than showing you how to get rowmeans.


cat("\n\nEXAMPLE 3: Nelson-Siegel yield curve\n")
# Write this asif you're dealing with scalars --
# Nelson Siegel function
nsz <- function(b0, b1, b2, tau, t) {
  tmp = t/tau
  tmp2 = exp(-tmp)
  return(b0 + ((b1+b2)*(1-tmp2)/(tmp)) - (b2*tmp2))
}

timepoints <- c(0.01,1:5)

# The bad way:
z <- numeric(length(timepoints))
for (i in 1:length(timepoints)) {
  z[i] <- nsz(14.084,-3.4107,0.0015,1.8832,timepoints[i])
}
print(z)

# The R way --
print(z <- nsz(14.084,-3.4107,0.0015,1.8832,timepoints))


cat("\n\nEXAMPLE 3: Making the NPV of a bond--\n")
# You know the bad way - sum over all cashflows, NPVing each.
# Now look at the R way.
C = rep(100, 6)
nsz(14.084,-3.4107,0.0015,1.8832,timepoints)        # Print interest rates
C/((1.05)^timepoints)                               # Print cashflows discounted @ 5%
C/((1 + (0.01*nsz(14.084,-3.4107,0.0015,1.8832,timepoints))^timepoints)) # Using NS instead of 5%
# NPV in two different ways --
C %*% (1 + (0.01*nsz(14.084,-3.4107,0.0015,1.8832,timepoints)))^-timepoints
sum(C * (1 + (0.01*nsz(14.084,-3.4107,0.0015,1.8832,timepoints)))^-timepoints)
# You can drop back to a flat yield curve at 5% easily --
sum(C * 1.05^-timepoints)

# Make a function for NPV --
npv <- function(C, timepoints, r) {
  return(sum(C * (1 + (0.01*r))^-timepoints))
}
npv(C, timepoints, 5)

# Bottom line: Here's how you make the NPV of a bond with cashflows C
# at timepoints timepoints when the zero curve is a Nelson-Siegel curve --
npv(C, timepoints, nsz(14.084,-3.4107,0.0015,1.8832,timepoints))
# Wow!

# ---------------------------------------------------------------------------
# Elegant vector notation is amazingly fast (in addition to being beautiful)
N <- 1e5
x <- runif(N, -3,3)
y <- runif(N)

method1 <- function(x,y) {
  tmp <- NULL 
  for (i in 1:N) {
    if (x[i] < 0) tmp <- c(tmp, y[i])
  }
  tmp
}

method2 <- function(x,y) {
  y[x < 0]
}

s1 <- system.time(ans1 <- method1(x,y))
s2 <- system.time(ans2 <- method2(x,y))
all.equal(ans1,ans2)
s1/s2           # On my machine it's 2000x faster
