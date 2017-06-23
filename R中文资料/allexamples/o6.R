# Goal : Terse version of estimating the beta of Sun Microsystems
#        using weekly returns and data from Yahoo finance.
#        By Gabor Grothendieck.

library(tseries)

getstock <- function(x)
   c(get.hist.quote(x, quote = "Adj", start = "2003-01-01", compress = "w"))
r <- diff(log(cbind(sp500 = getstock("^gspc"), sunw = getstock("sunw"))))

mm <- lm(sunw ~ ., r)
print(summary(mm))

range <- range(r, -r)
plot(r[,1], r[,2], xlim = range, ylim = range,
     xlab = "S&P 500 weekly returns (%)", ylab = "SUNW weekly returns (%)")
grid()
abline(mm, h = 0, v = 0, col = "blue")
