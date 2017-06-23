## BASICS
  # Setup some scalars
  x <- 3
  y <- 4
  z <- sqrt(x*x + y*y)
  use.dots.in.names <- z - 5

  # Print out z
  print(z)
  # The default action is print()
  z

  # So you have a neat scientific calculator
  sin(log(2.718281828)*pi)

## SCALARS
  # The basic scalar types
  x <- 3
  take.me <- FALSE
  s <- "this is a string"
  x
  take.me
  s

  # Exploring objects using str() --
  str(x)
  str(take.me)
  str(s)

## DATES: A SPECIAL KIND OF SCALAR
  s <- "2004-04-22"
  d <- as.Date(s)
  d
  str(d)
  s <- "22-Apr-2004"
  d <- as.Date(s, format="%d-%b-%Y")
  d
  as.Date("22-04-2004", format="%d-%m-%Y")
  as.Date("22-04-04", format="%d-%m-%y")
  as.Date("22-Apr-04", format="%d-%b-%y")

## VECTORS
  x <- c(2,3,7, 9, 10, 11)                # the c() operator, for concatenation
  x[1]
  x[6]
  length(x)

  # Help about all R functions is online:
  ?length

  # Arithmetic that gobbles a vector at a time
  x
  x+2
  y <- log(x)
  y

  # Clever vector addressing
  x[1]
  x[6]
  x[c(1,6)]
  indexes <- c(1,3,5)
  x[indexes]

  # Another shorthand
  1:4
  x[1:4]
  indexes <- 1:4
  x[indexes]

  # Another shorthand
  switches <- c(TRUE,FALSE,FALSE,FALSE,FALSE,TRUE)
  x[switches]

  # Dropping some elements
  x
  x[-2]
  x[c(-2,-3)]

  # Bottom line: Very nice mechanisms for addressing.

  # Let's stay in touch with how to explore objects --
  str(x)
  str(x[1])

## FACTORS: A SPECIAL KIND OF SCALAR
  names  <- c("Payal", "Shraddha", "Aditi", "Kritika", "Diwakar")
  attire <- c("Sari",  "Salwar",   "Sari",  "Sari",    "Kurta")
  # attire is a "categorical variable"
  attire <- factor(attire)
  attire
  table(attire)
  table(names, attire)

  # Internally, a factor is just stored as an integer
  as.numeric(attire)

## NOT AVAILABLE: A SPECIAL SCALAR
  x <- c(2,3,NA,4,5,NA)
  x
  x + 2                                   # Automatic rules about NA arithmetic

## MATRICES
  X <- matrix(NA, nrow=7, ncol=3)
  X
  X[4,] <- c(2,3,4)
  X
  X[,3] <- 1:7
  X
  str(X)
  nrow(X)
  ncol(X)

  # As with vectors, arithmetic that attacks a full matrix at a time!
  X + 1

## LISTS
  # Ability to make a parcel of apparently unrelated materials.
  results <- list(mu=0.2, sigma=0.9, x=c(1,2,3,9))
  str(results)
  # Accessing elements --
  results$mu
  results$sigma <- 9
  results$new <- "Hello"
  results

## DAILY TIME-SERIES USING THE `ZOO' PACKAGE
  # Zoo is a very powerful, high-level time-series system. To learn more:
  library(help=zoo)
  vignette("zoo-quickref")

  # Let's do a daily time-series
  dates <- as.Date(c("2004-04-01", "2004-04-02", "2004-04-03", "2004-04-05"))
  values <- rnorm(4)
  library(zoo)
  z <- zoo(values, order.by=dates)
  z
  plot(z)

## DATASET, TERMED `DATA FRAME' in R
  # A dataset is a list of vectors, all of the same length.
  names <- c("Payal", "Shraddha", "Aditi", "Kritika", "Diwakar")
  age <-   c(15,      17,         15,      19,        20)
  iq <-    c(90,      100,        110,     120,       160)
  # By default, data.frame() forces the names to be factors...
  D <- data.frame(names=names, age=age, iq=iq)
  str(D)
  D
  nrow(D)
  ncol(D)
  summary(D)
  # Accessing a column in a data frame
  D$age
  # Accessing an observation in a data frame - use matrix-like notation
  D[3,]
  # Accessing the 3rd value of age
  D$age[3]

## WRITING AND THEN READING FILES
  D
  write.csv(D, file="demo.csv")
  system("cat demo.csv")                  # Say "type" if you're on DOS
  E <- read.table("demo.csv", skip=1, sep=",",
                  col.names=c("obsnum","name","age","iq"))
  E
  E$obsnum <- NULL
  E
  # Compare against --
  D

## Shift gears from here on.
## REGRESSION
  m <- lm(iq ~ age, D)
  m
  summary(m)
  # Remember that shoe size is strongly correlated with IQ
  plot(D$age, D$iq, xlab="Age (years)", ylab="IQ")
  abline(h=100, lty=3)
  lines(D$age, fitted.values(m), col="blue", lwd=2)

## SIMULATION
  runif(10)
  runif(10)
  set.seed(133); runif(10)
  set.seed(133); runif(10)
  summary(runif(100))
  summary(runif(1000))
  summary(runif(10000))
  summary(runif(100000))

  cat("See how large datasets stabilise sample statistics\n")
  summary(runif(100)); summary(runif(100))
  summary(runif(10000)); summary(runif(10000))

  plot(density(runif(1000)))
  plot(density(rnorm(1000)))
  x <- seq(-4,4,0.01)
  lines(x, dnorm(x), col="blue", lwd=2)

## SIMPLE SUMMARY STATISTICS
  x <- rnorm(10000)
  summary(x)
  quantile(x, probs=c(0.01, 0.025, 0.25, 0.5, 0.75, 0.975, 0.99))
  IQR(x)
  fivenum(x)
  sd(x)
  range(x)
  mean(x)
  mean(x, trim=0.1)                     # Delete 10% of data at each end first

## REGRESSION ON A SIMULATED DATASET
  x <- 2 + 3*runif(100)
  summary(x)
  y <- -7 + 4*x + rnorm(100)
  summary(lm(y ~ x))                    # Convince yourself the intercept is ok
  # Most statistical functions give back results of results.
  res.1 <- lm(y ~ x)
  str(res.1)                            # There's a lot of goodies here!
  res.1$coefficients
  # In this case, detailed calculations require summary() to get what
  # I call "level 2 results".
  res.2 <- summary(res.1)
  str(res.1)                            # There's even more goodies here!!
  res.2$coefficients
  res.2$r.squared
  res.2$sigma
  # There are useful generic functions which work for a lot of models --
  logLik(res.1)
  AIC(res.1)

## TIME SERIES ANALYSIS
  # ACF of white noise
  z <- rnorm(100)
  acf(z)
  z <- rnorm(1000)
  acf(z)

  # Simulate data from an AR(1) process
  x <- arima.sim(model=list(ar=c(0.5)), n=1000)
  arima(x, order=c(1,0,0))
  acf(x)
  # Let's try to estimate a wrong model --
  arima(x, order=c(3,0,0))
