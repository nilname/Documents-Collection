# Goal: Display of a macroeconomic time-series, with a filled colour
#       bar showing a recession.

years <- 1950:2000
timeseries <- cumsum(c(100, runif(50)*5))
hilo <- range(timeseries)
plot(years, timeseries, type="l", lwd=3)
# A recession from 1960 to 1965 --
polygon(x=c(1960,1960, 1965,1965),
        y=c(hilo, rev(hilo)),
        density=NA, col="orange", border=NA)
lines(years, timeseries, type="l", lwd=3) # paint again so line comes on top

# alternative method -- though not as good looking --
# library(plotrix)
# gradient.rect(1960, hilo[1], 1965, hilo[2],
#               reds=c(0,1), greens=c(0,0), blues=c(0,0),
#               gradient="y")
