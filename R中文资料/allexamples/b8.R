# Goal: Associative arrays (as in awk) or hashes (as in perl).
#       Or, more generally, adventures in R addressing.

# Here's a plain R vector:
x <- c(2,3,7,9)
# But now I tag every elem with labels:
names(x) <- c("kal","sho","sad","aja")
# Associative array operations:
x["kal"] <- 12
# Pretty printing the entire associative array:
x

# This works for matrices too:
m <- matrix(runif(10), nrow=5)
rownames(m) <- c("violet","indigo","blue","green","yellow")
colnames(m) <- c("Asia","Africa")
# The full matrix --
m
# Or even better --
library(xtable)
xtable(m)

# Now address symbolically --
m[,"Africa"]
m["indigo",]
m["indigo","Africa"]

# The "in" operator, as in awk --
for (colour in c("yellow", "orange", "red")) {
  if (colour %in% rownames(m)) {
    cat("For Africa and ", colour, " we have ", m[colour, "Africa"], "\n")
  } else {
    cat("Colour ", colour, " does not exist in the hash.\n")
  }
}

# This works for data frames also --
D <- data.frame(m)
D
# Look closely at what happened --
str(D)                                  # The colours are the rownames(D).

# Operations --
D$Africa
D[,"Africa"]
D["yellow",]
# or
subset(D, rownames(D)=="yellow")

colnames(D) <- c("Antarctica","America")
D
D$America
