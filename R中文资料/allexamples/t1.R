# Goals: ARMA modeling - estimation, diagnostics, forecasting.


# 0. SETUP DATA
rawdata <- c(-0.21,-2.28,-2.71,2.26,-1.11,1.71,2.63,-0.45,-0.11,4.79,5.07,-2.24,6.46,3.82,4.29,-1.47,2.69,7.95,4.46,7.28,3.43,-3.19,-3.14,-1.25,-0.50,2.25,2.77,6.72,9.17,3.73,6.72,6.04,10.62,9.89,8.23,5.37,-0.10,1.40,1.60,3.40,3.80,3.60,4.90,9.60,18.20,20.60,15.20,27.00,15.42,13.31,11.22,12.77,12.43,15.83,11.44,12.32,12.10,12.02,14.41,13.54,11.36,12.97,10.00,7.20,8.74,3.92,8.73,2.19,3.85,1.48,2.28,2.98,4.21,3.85,6.52,8.16,5.36,8.58,7.00,10.57,7.12,7.95,7.05,3.84,4.93,4.30,5.44,3.77,4.71,3.18,0.00,5.25,4.27,5.14,3.53,4.54,4.70,7.40,4.80,6.20,7.29,7.30,8.38,3.83,8.07,4.88,8.17,8.25,6.46,5.96,5.88,5.03,4.99,5.87,6.78,7.43,3.61,4.29,2.97,2.35,2.49,1.56,2.65,2.49,2.85,1.89,3.05,2.27,2.91,3.94,2.34,3.14,4.11,4.12,4.53,7.11,6.17,6.25,7.03,4.13,6.15,6.73,6.99,5.86,4.19,6.38,6.68,6.58,5.75,7.51,6.22,8.22,7.45,8.00,8.29,8.05,8.91,6.83,7.33,8.52,8.62,9.80,10.63,7.70,8.91,7.50,5.88,9.82,8.44,10.92,11.67)

# Make a R timeseries out of the rawdata: specify frequency & startdate
gIIP <- ts(rawdata, frequency=12, start=c(1991,4))
print(gIIP)
plot.ts(gIIP, type="l", col="blue", ylab="IIP Growth (%)", lwd=2,
        main="Full data")
grid()

# Based on this, I decide that 4/1995 is the start of the sensible period.
gIIP <- window(gIIP, start=c(1995,4))
print(gIIP)
plot.ts(gIIP, type="l", col="blue", ylab="IIP Growth (%)", lwd=2,
        main="Estimation subset")
grid()

# Descriptive statistics about gIIP
mean(gIIP); sd(gIIP); summary(gIIP);
plot(density(gIIP), col="blue", main="(Unconditional) Density of IIP growth")
acf(gIIP)


# 1. ARMA ESTIMATION
m.ar2 <- arima(gIIP, order = c(2,0,0))
print(m.ar2)                       # Print it out


# 2. ARMA DIAGNOSTICS
tsdiag(m.ar2)                      # His pretty picture of diagnostics
## Time series structure in errors
print(Box.test(m.ar2$residuals, lag=12, type="Ljung-Box")); 
## Sniff for ARCH
print(Box.test(m.ar2$residuals^2, lag=12, type="Ljung-Box"));
## Eyeball distribution of residuals
plot(density(m.ar2$residuals), col="blue", xlim=c(-8,8),
     main=paste("Residuals of AR(2)"))


# 3. FORECASTING
## Make a picture of the residuals
plot.ts(m.ar2$residual, ylab="Innovations", col="blue", lwd=2)
s <- sqrt(m.ar2$sigma2)
abline(h=c(-s,s), lwd=2, col="lightGray")

p <- predict(m.ar2, n.ahead = 12)         # Make 12 predictions.
print(p)

## Watch the forecastability decay away from fat values to 0.
## sd(x) is the naive sigma. p$se is the prediction se.
gain <- 100*(1-p$se/sd(gIIP))
plot.ts(gain, main="Gain in forecast s.d.", ylab="Per cent",
        col="blue", lwd=2)

## Make a pretty picture that puts it all together
ts.plot(gIIP, p$pred, p$pred-1.96*p$se, p$pred+1.96*p$se,
        gpars=list(lty=c(1,1,2,2), lwd=c(2,2,1,1),
          ylab="IIP growth (%)", col=c("blue","red", "red", "red")))
grid()
abline(h=mean(gIIP), lty=2, lwd=2, col="lightGray")
legend(x="bottomleft", cex=0.8, bty="n",
       lty=c(1,1,2,2), lwd=c(2,1,1,2),
       col=c("blue", "red", "red", "lightGray"),
       legend=c("IIP", "AR(2) forecasts", "95% C.I.", "Mean IIP growth"))
