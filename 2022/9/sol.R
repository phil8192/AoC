knots <- 1 #9 
f <- read.csv("x.txt", header=F, sep=" ")

t_positions <- data.frame(x=0, y=0)

t_x <- rep(0, knots)
t_y <- rep(0, knots)

h_x <- 0
h_y <- 0


for (i in 1:nrow(f)) {
  cmd <- f[i, ]
  dir <- cmd$V1
  amt <- cmd$V2
 
  for (step in 1:amt) {
 
    switch(dir,
        "U" = h_y <- h_y + 1,
	"R" = h_x <- h_x + 1,
	"D" = h_y <- h_y - 1,
	"L" = h_x <- h_x - 1)

    hh_x <- h_x
    hh_y <- h_y
    for (knot in 1:knots) {
        
      if (knot > 1) {
        hh_x <- t_x[knot-1]
        hh_y <- t_y[knot-1]
      }

      d_x <- hh_x - t_x[knot]
      d_y <- hh_y - t_y[knot]

      if (abs(d_x) <= 1 && abs(d_y) <= 1) {
	  next
      }

      if (abs(d_x) > 1 && abs(d_y) >= 1 || abs(d_y) > 1 && abs(d_x) >= 1) {
	t_x[knot] <- t_x[knot] + sign(d_x)
        t_y[knot] <- t_y[knot] + sign(d_y)
      } else if (abs(d_x) > 1) {
	t_x[knot] <- t_x[knot] + sign(d_x)
      } else {
        t_y[knot] <- t_y[knot] + sign(d_y)
      }
      if (knot == knots) {
        t_positions <- rbind(t_positions, list(t_x[knot], t_y[knot]))
      }
    }
  }
}

print(nrow(unique(t_positions)))
