x <- strsplit(readLines("x.txt",),"")[[1]]

# base-r
which(!unlist(lapply(length(x):4,  function(i) anyDuplicated(head(tail(x, i),  4)))))[1]+3
which(!unlist(lapply(length(x):14, function(i) anyDuplicated(head(tail(x, i), 14)))))[1]+13

# generic base-r
roll <- function(x, n, f) unlist(lapply(length(x):n, function(i) f(head(tail(x, i), n))))
which.min(roll(x, 4, anyDuplicated))+3
which.min(roll(x, 14, anyDuplicated))+13

# zoo rollapply
library(zoo)
which.min(rollapply(x,4,anyDuplicated))+3
which.min(rollapply(x,14,anyDuplicated))+13

# tidyverse slide
library(slider)
which.min(slide_vec(x, anyDuplicated, .before=3, .complete=T))
which.min(slide_vec(x, anyDuplicated, .before=13, .complete=T))
