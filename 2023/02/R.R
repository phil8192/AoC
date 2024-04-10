x <- readLines("input.txt")

# ffs.
df <- cbind(id=1:length(x), do.call(rbind, lapply(x, function(v) {
  sets <- strsplit(sub("^.*:", "", v), ";")
  rgb <- list(red=0, green=0, blue=0)
  for(set in sets) {
    cubes <- sub(" ", "", unlist(strsplit(set, ",")))
    for(cube in cubes) {
      cube <- unlist(strsplit(cube, " "))
      col <- cube[2]
      val <- cube[1]
      rgb[col] <- max(rgb[[col]], as.integer(val))
    }
  }
  data.frame(rgb)
})))

# 1: 2593
sum(df[with(df, red <= 12 & green <= 13 & blue <= 14), ]$id)

# 2: 54699
sum(apply(df[, -1], 1, prod))
