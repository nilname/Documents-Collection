# Goal: To make a panel of pictures.

par(mfrow=c(3,2))                       # 3 rows, 2 columns.

# Now the next 6 pictures will be placed on these 6 regions. :-)

# Let me take some pains on the 1st
plot(density(runif(100)), lwd=2)
text(x=0, y=0.2, "100 uniforms")        # Showing you how to place text at will
abline(h=0, v=0)
              # All these statements effect the 1st plot.

x=seq(0.01,1,0.01)
par(col="blue")                         # default colour to blue.

# 2 --
plot(x, sin(x), type="l")
lines(x, cos(x), type="l", col="red")

# 3 --
plot(x, exp(x), type="l", col="green")
lines(x, log(x), type="l", col="orange")

# 4 --
plot(x, tan(x), type="l", lwd=3, col="yellow")

# 5 --
plot(x, exp(-x), lwd=2)
lines(x, exp(x), col="green", lwd=3)

# 6 --
plot(x, sin(x*x), type="l")
lines(x, sin(1/x), col="pink")
