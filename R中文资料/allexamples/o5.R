# Goal: Using data from Yahoo finance, estimate the beta of Sun Microsystems
#       for weekly returns.
# This is the `elaborate version' (36 lines), also see terse version (16 lines)

library(tseries)

# I know that the yahoo symbol for the common stock of Sun Microsystems
# is "SUNW" and for the S&P 500 index is "^GSPC".
prices <- cbind(get.hist.quote("SUNW", quote="Adj", start="2003-01-01", retclass="zoo"),
                get.hist.quote("^GSPC", quote="Adj", start="2003-01-01", retclass="zoo"))
colnames(prices) <- c("SUNW", "SP500")
prices <- na.locf(prices)               # Copy last traded price when NA

# To make weekly returns, you must have this incantation:
nextfri.Date <- function(x) 7 * ceiling(as.numeric(x - 1)/7) + as.Date(1)
# and then say
weekly.prices <- aggregate(prices, nextfri.Date,tail,1)

# Now we can make weekly returns --
r <- 100*diff(log(weekly.prices))

# Now shift out of zoo to become an ordinary matrix --
r <- coredata(r)
rj <- r[,1]
rM <- r[,2]
d <- lm(rj ~ rM)               # Market model estimation.
print(summary(d))

# Make a pretty picture
big <- max(abs(c(rj, rM)))
range <- c(-big, big)
plot(rM, rj, xlim=range, ylim=range,
     xlab="S&P 500 weekly returns (%)", ylab="SUNW weekly returns (%)")
grid()
abline(h=0, v=0)
lines(rM, d$fitted.values, col="blue")
