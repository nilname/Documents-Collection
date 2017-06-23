# Goal: To make a latex table with results of an OLS regression.

# Get an OLS --
x1 = runif(100)
x2 = runif(100, 0, 2)
y = 2 + 3*x1 + 4*x2 + rnorm(100)
m = lm(y ~ x1 + x2)

# and print it out prettily --
library(xtable)
# Bare --
xtable(m)
xtable(anova(m))

# Better --
print.xtable(xtable(m, caption="My regression",
                    label="t:mymodel",
                    digits=c(0,3,2,2,3)),
             type="latex",
             file="xtable_demo_ols.tex",
             table.placement = "tp",
             latex.environments=c("center", "footnotesize"))

print.xtable(xtable(anova(m),
                    caption="ANOVA of my regression",
                    label="t:anova_mymodel"),
             type="latex",
             file="xtable_demo_anova.tex",
             table.placement = "tp",
             latex.environments=c("center", "footnotesize"))

# Read the documentation of xtable. It actually knows how to generate
# pretty latex tables for a lot more R objects than just OLS results.
# It can be a workhorse for making tabular out of matrices, and
# can also generate HTML.
