# Goal: To make latex tabular out of an R matrix

# Setup a nice R object:
m <- matrix(rnorm(8), nrow=2)
rownames(m) <- c("Age", "Weight")
colnames(m) <- c("Person1", "Person2", "Person3", "Person4")
m

# Translate it into a latex tabular:
library(xtable)
xtable(m, digits=rep(3,5))

# Production latex code that goes into a paper or a book --
print(xtable(m,
             caption="String",
             label="t:"),
             type="latex",
             file="blah.gen",
             table.placement="tp",
             latex.environments=c("center", "footnotesize"))
# Now you do \input{blah.gen} in your latex file.



# You're lazy, and want to use R to generate latex tables for you?
data <- cbind(
              c(7,9,11,2),
              c(2,4,19,21)
              )
colnames(data) <- c("a","b")
rownames(data) <- c("x","y","z","a")
xtable(data)

# or you could do
data <- rbind(
              c(7,2),
              c(9,4),
              c(11,19),
              c(2,21)
              )
# and the rest goes through identically.
