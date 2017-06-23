# Goal: To read in files produced by CMIE's "Business Beacon".
#       This assumes you have made a file of MONTHLY data using CMIE's
#       Business Beacon program. This contains 2 columns: M3 and M0.

A <- read.table(
                # Generic to all BB files --
                sep="|",                # CMIE's .txt file is pipe delimited
                skip=3,                 # Skip the 1st 3 lines
                na.strings=c("N.A.","Err"),  # The ways they encode missing data
                # Specific to your immediate situation --
                file="bb_data.text",
                col.names=c("junk", "date", "M3", "M0")
                )
A$junk <- NULL                          # Blow away this column

# Parse the CMIE-style "Mmm yy" date string that's used on monthly data
A$date <- as.Date(paste("1", as.character(A$date)), format="%d %b %Y")
