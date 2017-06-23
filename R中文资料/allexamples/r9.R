# Goal: Reading in a Microsoft .xls file directly

library(gdata)
a <- read.xls("file.xls", sheet=2)                # This reads in the 2nd sheet

# Look at what the cat dragged in
str(a)

# If you have a date column, you'll want to fix it up like this:
a$date <- as.Date(as.character(a$X), format="%d-%b-%y")
a$X <- NULL


# Also see http://tolstoy.newcastle.edu.au/R/help/06/04/25674.html for
# another path.
