stacks <- strsplit(c("QMGCL",
		     "RDLCTFHG",
		     "VJFNMTWR",
		     "JFDVQP",
		     "NFMSLBT",
		     "RNVHCDP",
		     "HCT",
		     "GSJVZNHP",
		     "ZFHG"),"")

top_stack <- function() paste0(unlist(lapply(stacks, function(x) tail(x, 1))), collapse="")

`%from%` <- function(v, i) {
  pop <- tail(stacks[[i]], v)
  stacks[[i]] <<- head(stacks[[i]], -v)
  rev(pop)
}

`%to%` <- function(v, i) stacks[[i]] <<- c(stacks[[i]], v)

comp <- function(x) sub("move ", "", sub("to", "%to%", sub("from", "%from%", x)))

src <- function(x) {
  exprs <- lapply(readLines(x), function(x) parse(text=comp(x)))
  for (i in seq_along(exprs)) eval(exprs[[i]])
}

# eval single expression
eval(parse(text=comp("move 2 from 6 to 7")))
print(top_stack())

# put back
2 %from% 7 %to% 6
print(top_stack())

# exec all expressions
src("x.txt")
print(top_stack())
