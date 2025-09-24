x <- paste(readLines("input.txt"), collapse=" ")

# 1.
mul <- function(x, y) x*y

exe <- function(x) {
  mat <- gregexpr("mul\\((\\d+),(\\d+)\\)", x) 
  sum(sapply(unlist(regmatches(x, mat)), function(x) eval(parse(text=x))))
}

exe(x)

# 2.
dos <- unlist(gregexpr("do\\(\\)", x)[1])
donts <- unlist(gregexpr("don't\\(\\)", x)[1])

x_split <- unlist(strsplit(x, ""))
for(dont in donts) {
  end <- head(dos[dos > dont], 1)
  x_split[dont:end] <- "_"
}

x <- paste(x_split, collapse="")

exe(x)
