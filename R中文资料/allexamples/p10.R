# Goal: Given two vectors of data,
#       superpose their CDFs
#       and show the results of the two-sample Kolmogorov-Smirnoff test

# The function consumes two vectors x1 and x2.
# You have to provide a pair of labels as `legendstrings'.
# If you supply an xlab, it's used
# If you specify log - e.g. log="x" - this is passed on to plot.
# The remaining args that you specify are sent on into ks.test()
two.cdfs.plot <- function(x1, x2, legendstrings, xlab="", log="", ...) {
  stopifnot(length(x1)>0,
            length(x2)>0,
            length(legendstrings)==2)
  hilo <- range(c(x1,x2))

  par(mai=c(.8,.8,.2,.2))
  plot(ecdf(x1), xlim=hilo, verticals=TRUE, cex=0,
       xlab=xlab, log=log, ylab="Cum. distribution", main="")
  grid()
  plot(ecdf(x2), add=TRUE, verticals=TRUE, cex=0, lwd=3)
  legend(x="bottomright", lwd=c(1,3), lty=1, bty="n",
         legend=legendstrings)

  k <- ks.test(x1,x2, ...)
  text(x=hilo[1], y=c(.9,.85), pos=4, cex=.8,
     labels=c(
       paste("KS test statistic: ", sprintf("%.3g", k$statistic)),
       paste("Prob value: ", sprintf("%.3g", k$p.value))
       )
     )
  k
}

x1 <- rnorm(100, mean=7, sd=1)
x2 <- rnorm(100, mean=9, sd=1)

# Check error detection --
two.cdfs.plot(x1,x2)

# Typical use --
two.cdfs.plot(x1, x2, c("X1","X2"), xlab="Height (metres)", log="x")

# Send args into ks.test() --
two.cdfs.plot(x1, x2, c("X1","X2"), alternative="less")
