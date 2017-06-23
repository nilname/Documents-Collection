# Goal: Reading and writing ascii files, reading and writing binary files.
#       And, to measure how much faster it is working with binary files.

# First manufacture a tall data frame:
                # FYI -- runif(10) yields 10 U(0,1) random numbers.
B = data.frame(x1=runif(100000), x2=runif(100000), x3=runif(100000))
summary(B)

# Write out ascii file:
write.table(B, file = "/tmp/foo.csv", sep = ",", col.names = NA)
# Read in this resulting ascii file:
C=read.table("/tmp/foo.csv", header = TRUE, sep = ",", row.names=1)
# Write a binary file out of dataset C:
save(C, file="/tmp/foo.binary")
# Delete the dataset C:
rm(C)
# Restore from foo.binary:
load("/tmp/foo.binary")
summary(C)                              # should yield the same results
                                        # as summary(B) above.


# Now we time all these operations --
cat("Time creation of dataset:\n")
system.time({
  B = data.frame(x1=runif(100000), x2=runif(100000), x3=runif(100000))
})

cat("Time writing an ascii file out of dataset B:\n")
system.time(
            write.table(B, file = "/tmp/foo.csv", sep = ",", col.names = NA)
            )

cat("Time reading an ascii file into dataset C:\n")
system.time(
            {C=read.table("/tmp/foo.csv", header = TRUE, sep=",", row.names=1)
           })

cat("Time writing a binary file out of dataset C:\n")
system.time(save(C, file="/tmp/foo.binary"))

cat("Time reading a binary file + variablenames from /tmp/foo.binary:\n")
system.time(load("/tmp/foo.binary"))    # and then read it in from binary file
