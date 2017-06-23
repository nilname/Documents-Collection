# Goal: Make a time-series object using the "zoo" package

A <- data.frame(date=c("1995-01-01", "1995-01-02", "1995-01-03", "1995-01-06"),
                x=runif(4),
                y=runif(4))
A$date <- as.Date(A$date) # yyyy-mm-dd is the default format
# So far there's nothing new - it's just a data frame. I have hand-
# constructed A but you could equally have obtained it using read.table().

# I want to make a zoo matrix out of the numerical columns of A
library(zoo)
B <- A
B$date <- NULL
z <- zoo(as.matrix(B), order.by=A$date)
rm(A, B)

# So now you are holding "z", a "zoo" object. You can do many cool
# things with it.
# See http://www.google.com/search?hl=en&q=zoo+quickref+achim&btnI=I%27m+Feeling+Lucky

# To drop down to a plain data matrix, say
C <- coredata(z)
rownames(C) <- as.character(time(z))
# Compare --
str(C)
str(z)

# The above is a tedious way of doing these things, designed to give you
# an insight into what is going on. If you just want to read a file
# into a zoo object, a very short path is something like:
#        z <- read.zoo(filename, format="%d %b %Y")
