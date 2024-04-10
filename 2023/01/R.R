x <- read.csv("input.txt", header=F)$V1

sum_it <- function(x) {
  sum(sapply(x, function(v) {
    s <- unlist(strsplit(gsub("[a-z]", "", v), ""))
    as.numeric(paste(head(s, 1), tail(s, 1), sep=""))
  }))
}

# 1: 55130 
sum_it(x)

x <- gsub("oneight", "18", x)
x <- gsub("threeight", "38", x)
x <- gsub("fiveight", "58", x)
x <- gsub("nineight", "98", x)
x <- gsub("twone", "21", x)
x <- gsub("sevenine", "79", x)
x <- gsub("eightwo", "82", x)
x <- gsub("one", "1", x)
x <- gsub("two", "2", x)
x <- gsub("three", "3", x)
x <- gsub("four", "4", x)
x <- gsub("five", "5", x)
x <- gsub("six", "6", x)
x <- gsub("seven", "7", x)
x <- gsub("eight", "8", x)
x <- gsub("nine", "9", x)

# 2: 54985
sum_it(x)
