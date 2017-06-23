# Goal:
#       A stock is traded on 2 exchanges.
#       Price data is missing at random on both exchanges owing to non-trading.
#       We want to make a single price time-series utilising information
#          from both exchanges. I.e., missing data for exchange 1 will
#          be replaced by information for exchange 2 (if observed).

# Let's create some example data for the problem.
e1 <- runif(15)                         # Prices on exchange 1
e2 <- e1 + 0.05*rnorm(15)               # Prices on exchange 2.
cbind(e1, e2)
# Blow away 5 points from each at random.
e1[sample(1:15, 5)] <- NA
e2[sample(1:15, 5)] <- NA
cbind(e1, e2)

# Now how do we reconstruct a time-series that tries to utilise both?
combined <- e1                          # Do use the more liquid exchange here.
missing <- is.na(combined)
combined[missing] <- e2[missing]        # if it's also missing, I don't care.
cbind(e1, e2, combined)
# There you are.
