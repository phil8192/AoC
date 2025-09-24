x <- read.csv("input.txt", header=F, sep="")

safe <- function(x) {
  x <- diff(x[!is.na(x)])
  (all(x < 0) | all(x > 0)) & all(abs(x) <= 3)
}

sfix <- function(x) {
  if(safe(x)) return(T)
  for(i in 1:length(x))
    if(safe(x[-i])) return(T)
  F
}

sum(apply(x, 1, safe))
sum(apply(x, 1, sfix))
