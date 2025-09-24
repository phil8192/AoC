# 2
n.vis <- function(v) {
  if(length(v) <= 1) return(0)
  pm <- pmin(cummax(v[-1]), v[1])
  ifelse(max(pm) < v[1], length(pm), match(v[1], pm))
}
v.vis <- function(v) unlist(lapply(seq_along(v), function(i) n.vis(c(v[i], tail(v, -i)))))

