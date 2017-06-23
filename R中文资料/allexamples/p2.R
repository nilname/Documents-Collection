# Goals: Do bootstrap inference, as an example, for a sample median.

library(boot)

samplemedian <- function(x, d) {        # d is a vector of integer indexes
  return(median(x[d]))                  # The genius is in the x[d] notation
}

data <- rnorm(50)                          # Generate a dataset with 50 obs
b  <-  boot(data, samplemedian, R=2000)    # 2000 bootstrap replications
cat("Sample median has a sigma of ", sd(b$t[,1]), "\n")
plot(b)

# Make a 99% confidence interval
boot.ci(b, conf=0.99, type="basic")
