# Goal: To do `moving window volatility' of returns.

library(zoo)

# Some data to play with (Nifty on all fridays for calendar 2004) --
p <- structure(c(1946.05, 1971.9, 1900.65, 1847.55, 1809.75, 1833.65, 1913.6, 1852.65, 1800.3, 1867.7, 1812.2, 1725.1, 1747.5, 1841.1, 1853.55, 1868.95, 1892.45, 1796.1, 1804.45, 1582.4, 1560.2, 1508.75, 1521.1, 1508.45, 1491.2, 1488.5, 1537.5, 1553.2, 1558.8, 1601.6, 1632.3, 1633.4, 1607.2, 1590.35, 1609, 1634.1, 1668.75, 1733.65, 1722.5, 1775.15, 1820.2, 1795, 1779.75, 1786.9, 1852.3, 1872.95, 1872.35, 1901.05, 1996.2, 1969, 2012.1, 2062.7, 2080.5), index = structure(c(12419, 12426, 12433, 12440, 12447, 12454, 12461, 12468, 12475, 12482, 12489, 12496, 12503, 12510, 12517, 12524, 12531, 12538, 12545, 12552, 12559, 12566, 12573, 12580, 12587, 12594, 12601, 12608, 12615, 12622, 12629, 12636, 12643, 12650, 12657, 12664, 12671, 12678, 12685, 12692, 12699, 12706, 12713, 12720, 12727, 12734, 12741, 12748, 12755, 12762, 12769, 12776, 12783), class = "Date"), frequency = 0.142857142857143, class = c("zooreg", "zoo"))

# Shift to returns --
r <- 100*diff(log(p))
head(r)
summary(r)
sd(r)

# Compute the moving window vol --
vol <- sqrt(250) * rollapply(r, 20, sd, align = "right")

# A pretty plot --
plot(vol, type="l", ylim=c(0,max(vol,na.rm=TRUE)),
     lwd=2, col="purple", xlab="2004",
     ylab=paste("Annualised sigma, 20-week window"))
grid()
legend(x="bottomleft", col=c("purple", "darkgreen"),
       lwd=c(2,2), bty="n", cex=0.8,
       legend=c("Annualised 20-week vol (left scale)", "Nifty (right scale)"))
par(new=TRUE)
plot(p, type="l", lwd=2, col="darkgreen",
     xaxt="n", yaxt="n", xlab="", ylab="")
axis(4)
