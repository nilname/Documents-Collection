# Get the data in place --
load(file="demo.rda")
summary(firms)

# Look at it --
plot(density(log(firms$mktcap)))
plot(firms$mktcap, firms$spread, type="p", cex=.2, col="blue", log="xy",
     xlab="Market cap (Mln USD)", ylab="Bid/offer spread (bps)")
m=lm(log(spread) ~ log(mktcap), firms)
summary(m)

# Making deciles --
library(gtools)
library(gdata)
                                      # for deciles (default=quartiles)
size.category = quantcut(firms$mktcap, q=seq(0, 1, 0.1), labels=F)
table(size.category)
means = aggregate(firms, list(size.category), mean)
print(data.frame(means$mktcap,means$spread))

# Make a picture combining the sample mean of spread (in each decile)
# with the weighted average sample mean of the spread (in each decile),
# where weights are proportional to size.
wtd.means = by(firms, size.category,
  function(piece) (sum(piece$mktcap*piece$spread)/sum(piece$mktcap)))
lines(means$mktcap, means$spread, type="b", lwd=2, col="green", pch=19)
lines(means$mktcap, wtd.means, type="b", lwd=2, col="red", pch=19)
legend(x=0.25, y=0.5, bty="n", 
       col=c("blue", "green", "red"), 
       lty=c(0, 1, 1), lwd=c(0,2,2), 
       pch=c(0,19,19),
       legend=c("firm", "Mean spread in size deciles",
         "Size weighted mean spread in size deciles"))

# Within group standard deviations --
aggregate(firms, list(size.category), sd)

# Now I do quartiles by BOTH mktcap and spread.
size.quartiles = quantcut(firms$mktcap, labels=F)
spread.quartiles = quantcut(firms$spread, labels=F)
table(size.quartiles, spread.quartiles)
# Re-express everything as joint probabilities
table(size.quartiles, spread.quartiles)/nrow(firms)
# Compute cell means at every point in the joint table:
aggregate(firms, list(size.quartiles, spread.quartiles), mean)

# Make pretty two-way tables
aggregate.table(firms$mktcap, size.quartiles, spread.quartiles, nobs)
aggregate.table(firms$mktcap, size.quartiles, spread.quartiles, mean)
aggregate.table(firms$mktcap, size.quartiles, spread.quartiles, sd)
aggregate.table(firms$spread, size.quartiles, spread.quartiles, mean)
aggregate.table(firms$spread, size.quartiles, spread.quartiles, sd)
