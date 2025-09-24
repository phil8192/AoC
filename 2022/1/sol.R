##' cumulative sequence of sequence changes.
##'
##' assigns a cumulative sum to a sequential occurrence in a vector.
##' 
##' @param x a vector containing sequences.
##' @return a vector containing change counts. 
##' @author phil https://gist.github.com/phil8192/0675493ff1a92f6f0ce2263f2d6aa1a2
##' @examples
##'
##' my.seq                   <- c(6, 6, 6, 20, 20, 5, 3, 3, 3, 3, 6, 6)
##' stopifnot(cumseq(my.seq) == c(1, 1, 1, 2,  2,  3, 4, 4, 4, 4, 5, 5))
cumseq <- function(x) {
  rle.x <- rle(x)
  rle.x$values <- 1:length(rle.x$values)
  inverse.rle(rle.x)
}

x <- read.csv("input.txt", header=F, blank.lines.skip=F)[ ,1]
s <- tapply(x, cumseq(is.na(x)), sum)

print(max(s, na.rm=T))
print(sum(tail(sort(s), 3)))
