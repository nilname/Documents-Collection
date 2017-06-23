# Goals: A first look at R objects - vectors, lists, matrices, data frames.

# To make vectors "x" "y" "year" and "names"
x <- c(2,3,7,9)
y <- c(9,7,3,2)
year <- 1990:1993
names <- c("payal", "shraddha", "kritika", "itida")
# Accessing the 1st and last elements of y --
y[1]
y[length(y)]

# To make a list "person" --
person <- list(name="payal", x=2, y=9, year=1990)
person
# Accessing things inside a list --
person$name
person$x

# To make a matrix, pasting together the columns "year" "x" and "y"
# The verb cbind() stands for "column bind"
cbind(year, x, y)

# To make a "data frame", which is a list of vectors of the same length --
D <- data.frame(names, year, x, y)
nrow(D)
# Accessing one of these vectors
D$names
# Accessing the last element of this vector
D$names[nrow(D)]
# Or equally,
D$names[length(D$names)]
