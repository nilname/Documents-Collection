# Goal: Joint distributions, marginal distributions, useful tables.

# First let me invent some fake data
set.seed(102)                           # This yields a good illustration.
x <- sample(1:3, 15, replace=TRUE)
education <- factor(x, labels=c("None", "School", "College"))
x <- sample(1:2, 15, replace=TRUE)
gender <- factor(x, labels=c("Male", "Female"))
age <- runif(15, min=20,max=60)

D <- data.frame(age, gender, education)
rm(x,age,gender,education)
print(D)

# Table about education
table(D$education)

# Table about education and gender --
table(D$gender, D$education)
# Joint distribution of education and gender --
table(D$gender, D$education)/nrow(D)

# Add in the marginal distributions also
addmargins(table(D$gender, D$education))
addmargins(table(D$gender, D$education))/nrow(D)

# Generate a good LaTeX table out of it --
library(xtable)
xtable(addmargins(table(D$gender, D$education))/nrow(D),
       digits=c(0,2,2,2,2))             # You have to do | and \hline manually.

# Study age by education category
by(D$age, D$gender, mean)
by(D$age, D$gender, sd)
by(D$age, D$gender, summary)

# Two-way table showing average age depending on education & gender
a <- matrix(by(D$age, list(D$gender, D$education), mean), nrow=2)
rownames(a) <- levels(D$gender)
colnames(a) <- levels(D$education)
print(a)
# or, of course,
print(xtable(a))
