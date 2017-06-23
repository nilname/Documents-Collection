# Goal: A histogram with tails shown in red.

# This happened on the R mailing list on 7 May 2004.
# This is by Martin Maechler <maechler@stat.math.ethz.ch>, who was
# responding to a slightly imperfect version of this by 
# "Guazzetti Stefano" <Stefano.Guazzetti@ausl.re.it>

x <- rnorm(1000)
hx <- hist(x, breaks=100, plot=FALSE)
plot(hx, col=ifelse(abs(hx$breaks) < 1.669, 4, 2))
         # What is cool is that "col" is supplied a vector.
