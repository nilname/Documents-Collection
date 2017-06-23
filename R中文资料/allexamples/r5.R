# Goals: Lots of times, you need to give an R object to a friend,
#        or embed data into an email.

# First I invent a little dataset --
set.seed(101)   # To make sure you get the same random numbers as me
                # FYI -- runif(10) yields 10 U(0,1) random numbers.
A = data.frame(x1=runif(10), x2=runif(10), x3=runif(10))
# Look at it --
print(A)

# Writing to a binary file that can be transported
save(A, file="/tmp/my_data_file.rda")   # You can give this file to a friend
load("/tmp/my_data_file.rda")

# Plan B - you want pure ascii, which can be put into an email --
dput(A)
# This gives you a block of R code. Let me utilise that generated code
# to create a dataset named "B".
B <- structure(list(x1 = c(0.372198376338929, 0.0438248154241592, 
0.709684018278494, 0.657690396532416, 0.249855723232031, 0.300054833060130, 
0.584866625955328, 0.333467143354937, 0.622011963743716, 0.54582855431363
), x2 = c(0.879795730113983, 0.706874740775675, 0.731972594512627, 
0.931634427979589, 0.455120594473556, 0.590319729177281, 0.820436094887555, 
0.224118480458856, 0.411666829371825, 0.0386105608195066), x3 = c(0.700711545301601, 
0.956837461562827, 0.213352001970634, 0.661061500199139, 0.923318882007152, 
0.795719761401415, 0.0712125543504953, 0.389407767681405, 0.406451216200367, 
0.659355078125373)), .Names = c("x1", "x2", "x3"), row.names = c("1", 
"2", "3", "4", "5", "6", "7", "8", "9", "10"), class = "data.frame")

# Verify that A and B are near-identical --
A-B
# or,
all.equal(A,B)
