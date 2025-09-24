x <- read.csv("input.txt", header=F, sep="")
sum(sapply(x[, 1], function(v) v*sum(v == x[, 2])))
