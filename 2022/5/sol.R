move <- function(x, v, from, to, r=T) {
  pop <- tail(x[[from]], v)
  if(r) pop <- rev(pop)
  x[[to]] <- c(x[[to]], pop)
  x[[from]] <- head(x[[from]], -v)
  x
}

move.all <- function(stacks, moves, r=T) {
  for (i in 1:nrow(moves))
    stacks <- move(stacks, moves[i, 1], moves[i, 2], moves[i, 3], r)
  paste0(unlist(lapply(stacks, function(x) tail(x, 1))), collapse="")
}

stacks <- strsplit(c("QMGCL","RDLCTFHG","VJFNMTWR","JFDVQP","NFMSLBT","RNVHCDP","HCT","GSJVZNHP","ZFHG"),"")
moves <- read.csv("x.txt", header=F, sep=" ")[, c(2,4,6)]

print(move.all(stacks, moves, r=T))
print(move.all(stacks, moves, r=F))
