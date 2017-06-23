# Goal: Special cases in reading files

# Reading in a .bz2 file --
read.table(bzfile("file.text.bz2"))           # Requires you have ./file.text.bz2

# Reading in a .gz file --
read.table(gzfile("file.text.gz"))            # Requires you have ./file.text.bz2

# Reading from a pipe --
mydata <- read.table(pipe("awk -f filter.awk input.txt"))

# Reading from a URL --
read.table(url("http://www.mayin.org/ajayshah/A/demo.text"))

# This also works --
read.table("http://www.mayin.org/ajayshah/A/demo.text")

# Hmm, I couldn't think of how to read a .bz2 file from a URL. How about:
read.table(pipe("links -source http://www.mayin.org/ajayshah/A/demo.text.bz2 | bunzip2"))

# Reading binary files from a URL --
load(url("http://www.mayin.org/ajayshah/A/nifty_weekly_returns.rda"))
