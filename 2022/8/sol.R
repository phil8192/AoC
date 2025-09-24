x <- strsplit(readLines("x.txt"), "")
x <- matrix(as.integer(unlist(x)), ncol=length(x[[1]]), byrow=T)

# 1
visible <- function(v) c(T, diff(cummax(v)) > 0)
any.vis <- function(v) visible(v) | rev(visible(rev(v)))
sum(t(apply(x, 1, any.vis)) | apply(x, 2, any.vis))


# 2
v.vis <- function(v) {
  m <- matrix(v, ncol=length(v), nrow=length(v), byrow=T)
  apply(upper.tri(m) & v - m <= 0, 1, function(x) min(which(x), length(x))) - seq_along(v)
}

s <- function(v) v.vis(v) * rev(v.vis(rev(v)))
max(t(apply(x, 1, s)) * apply(x, 2, s))

