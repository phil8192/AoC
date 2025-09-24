x<-read.csv("x.txt",header=F,sep=" ")
x$V2[is.na(x$V2)] <- 0 # nop arg = 0

# 1
reg <- 1+cumsum(x$V2) # reg after exec
cyc <- cumsum(ifelse(x$V2 == 0, 1, 2)) # what cycle it happens
idx <- c(20, seq(60, 220, 40))
sum(unlist(lapply(idx, function(x) x * reg[min(which(cyc == x | cyc == x-1 | cyc == x-2))])))


# 2
c.reg <- 1
for (i in 0:239) {
  if (i %in% cyc) c.reg <- reg[match(i, cyc)]
  if (i%%40 >= c.reg-1 && i%%40 <= c.reg+1) cat("#")
  else cat(".")
  if ((i+1) %% 40 == 0) cat("\n")
}

