# Goal: Display two series on one plot, one with a left y axis
#       and another with a right y axis.

y1 <- cumsum(rnorm(100))
y2 <- cumsum(rnorm(100, mean=0.2))

par(mai=c(.8, .8, .2, .8))
plot(1:100, y1, type="l", col="blue", xlab="X axis label", ylab="Left legend")
par(new=TRUE)
plot(1:100, y2, type="l", ann=FALSE, yaxt="n")
axis(4)
legend(x="topleft", bty="n", lty=c(1,1), col=c("blue","black"),
       legend=c("String 1 (left scale)", "String 2 (right scale)"))
