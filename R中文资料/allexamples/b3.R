# Goal: Prices and returns

# I like to multiply returns by 100 so as to have "units in percent".
# In other words, I like it for 5% to be a value like 5 rather than 0.05.

###################################################################
# I. Simulate random-walk prices, switch between prices & returns.
###################################################################
# Simulate a time-series of PRICES drawn from a random walk
# where one-period returns are i.i.d. N(mu, sigma^2).
ranrw <- function(mu, sigma, p0=100, T=100) {
  cumprod(c(p0, 1 + (rnorm(n=T, mean=mu, sd=sigma)/100)))
}
prices2returns <- function(x) {
  100*diff(log(x))
}
returns2prices <- function(r, p0=100) {
  c(p0, p0 * exp(cumsum(r/100)))
}

cat("Simulate 25 points from a random walk starting at 1500 --\n")
p <- ranrw(0.05, 1.4, p0=1500, T=25)
    # gives you a 25-long series, starting with a price of 1500, where
    # one-period returns are N(0.05,1.4^2) percent.
print(p)

cat("Convert to returns--\n")
r <- prices2returns(p)
print(r)

cat("Go back from returns to prices --\n")
goback <- returns2prices(r, 1500)
print(goback)

###################################################################
# II. Plenty of powerful things you can do with returns....
###################################################################
summary(r); sd(r)                       # summary statistics
plot(density(r))                        # kernel density plot
acf(r)                                  # Autocorrelation function
ar(r)                                   # Estimate a AIC-minimising AR model
Box.test(r, lag=2, type="Ljung")        # Box-Ljung test
library(tseries)
runs.test(factor(sign(r)))              # Runs test
bds.test(r)                             # BDS test.

###################################################################
# III. Visualisation and the random walk
###################################################################
# I want to obtain intuition into what kinds of price series can happen,
# given a starting price, a mean return, and a given standard deviation.
# This function simulates out 10000 days of a price time-series at a time,
# and waits for you to click in the graph window, after which a second
# series is painted, and so on. Make the graph window very big and
# sit back and admire.
# The point is to eyeball many series and thus obtain some intuition
# into what the random walk does.
visualisation <- function(p0, s, mu, labelstring) {
  N <- 10000
  x <- (1:(N+1))/250                        # Unit of years
  while (1) {
    plot(x, ranrw(mu, s, p0, N), ylab="Level", log="y",
         type="l", col="red", xlab="Time (years)",
         main=paste("40 years of a process much like", labelstring))
    grid()
    z=locator(1)
  }
}

# Nifty -- assuming sigma of 1.4% a day and E(returns) of 13% a year 
visualisation(2600, 1.4, 13/250, "Nifty")

# The numerical values here are used to think about what the INR/USD
# exchange rate would have looked like if it started from 31.37, had
# a mean depreciation of 5% per year, and had the daily vol of a floating
# exchange rate like EUR/USD.
visualisation(31.37, 0.7, 5/365, "INR/USD (NOT!) with daily sigma=0.7")
# This is of course not like the INR/USD series in the real world -
# which is neither a random walk nor does it have a vol of 0.7% a day.

# The numerical values here are used to think about what the USD/EUR
# exchange rate, starting with 1, having no drift, and having the observed
# daily vol of 0.7. (This is about right).
visualisation(1, 0.7, 0, "USD/EUR with no drift")

###################################################################
# IV. A monte carlo experiment about the runs test
###################################################################
# Measure the effectiveness of the runs test when faced with an
# AR(1) process of length 100 with a coeff of 0.1
set.seed(101)
one.ts <- function() {arima.sim(list(order = c(1,0,0), ar = 0.1), n=100)}
table(replicate(1000, runs.test(factor(sign(one.ts())))$p.value < 0.05))
# We find that the runs test throws up a prob value of below 0.05
# for 91 out of 1000 experiments.
# Wow! :-)
# To understand this, you need to look up the man pages of:
#    set.seed, arima.sim, sign, factor, runs.test, replicate, table.
# e.g. say ?replicate
