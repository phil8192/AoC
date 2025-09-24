x <- read.csv("input.txt", header=F, sep="")
sum(abs(diff(t(apply(x, 2, sort)))))
