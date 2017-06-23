# Goal: "Dummy variables" in regression.

# Suppose you have this data:
people = data.frame(
  age =       c(21,62,54,49,52,38),
  education = c("college", "school", "none", "school", "college", "none"),
  education.code = c(  2,        1,      0,        1,         2,      0 )
  )
# Here people$education is a string categorical variable and
# people$education.code is the same thing, with a numerical coding system.
people

# Note the structure of the dataset --
str(people)
# The strings supplied for `education' have been treated (correctly) as
# a factor, but education.code is being treated as an integer and not as
# a factor.


# We want to do a dummy variable regression. Normally you would have:
#  1 Chosen college as the omitted category
#  2 Made a dummy for "none" named educationnone
#  3 Made a dummy for "school" named educationschool
#  4 Ran a regression like lm(age ~ educationnone + educationschool, people)
# But this is R. Things are cool:
lm(age ~ education, people)

# ! :-)
# When you feed him an explanatory variable like education, he does all
# these steps automatically. (He chose college as the omitted category).

# If you use an integer coding, then the obvious thing goes wrong --
lm(age ~ education.code, people)
# because he's thinking that education.code is an integer explanatory
# variable. So you need to:

lm(age ~ factor(education.code), people)
# (he choose a different omitted category)

# Alternatively, fix up the dataset --
people$education.code <- factor(people$education.code)
lm(age ~ education.code, people)

#
# Bottom line:
# Once the dataset has categorical variables correctly represented as factors, i.e. as
str(people)
# doing OLS in R induces automatic generation of dummy variables while leaving one out:
lm(age ~ education, people)
lm(age ~ education.code, people)

# But what if you want the X matrix?
m <- lm(age ~ education, people)
model.matrix(m)
# This is the design matrix that went into the regression m.
