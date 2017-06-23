# Goal: To do sorting.
#
# The approach here needs to be explained. If `i' is a vector of
# integers, then the data frame D[i,] picks up rows from D based
# on the values found in `i'.
#
# The order() function makes an integer vector which is a correct
# ordering for the purpose of sorting.

D <- data.frame(x=c(1,2,3,1), y=c(7,19,2,2))
D

# Sort on x
indexes <- order(D$x)
D[indexes,]

# Print out sorted dataset, sorted in reverse by y
D[rev(order(D$y)),]
