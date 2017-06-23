# Goal: To show amazing R indexing notation, and the use of is.na()

x <- c(2,7,9,2,NA,5)                 # An example vector to play with.

# Give me elems 1 to 3 --
x[1:3]

# Give me all but elem 1 --
x[-1]

# Odd numbered elements --
indexes <- seq(1,6,2)
x[indexes]
# or, more compactly,
x[seq(1,6,2)]

# Access elements by specifying "on" / "off" through booleans --
require <- c(TRUE,TRUE,FALSE,FALSE,FALSE,FALSE)
x[require]
# Short vectors get reused! So, to get odd numbered elems --
x[c(TRUE,FALSE)]

# Locate missing data --
is.na(x)

# Replace missing data by 0 --
x[is.na(x)] <- 0
x

# Similar ideas work for matrices --
y <- matrix(c(2,7,9,2,NA,5), nrow=2)
y

# Make a matrix containing columns 1 and 3 --
y[,c(1,3)]

# Let us see what is.na(y) does --
is.na(y)
str(is.na(y))
# So is.na(y) gives back a matrix with the identical structure as that of y.
# Hence I can say
y[is.na(y)] <- -1
y
