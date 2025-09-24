x <- read.csv(text=system("cat test.txt |awk '{print $3 $4 $9 $10}' |sed 's/x=//g;s/y=//g;s/:/,/'", intern=T), header=F)
colnames(x) <- c("x1","y1","x2","y2")

manhattan <- function(x1, y1, x2, y2) abs(x1-x2) + abs(y1-y2)

# x: m = 3
#             0
#         -1, 0, 1
#     -2, -1, 0, 1, 2
# -3, -2, -1, 0, 1, 2, 3
#     -2, -1, 0, 1, 2
#         -1, 0, 1
#             0
# -3
# -2,-2,-2,
# -1,-1,-1,-1,-1
#  0, 0, 0, 0, 0, 0, 0
#  1, 1, 1, 1, 1, 1
#  2, 2, 2
#  3
xs <- function(x, m) x + rep(-m:m, c(seq(1,m*2+1,2), seq(m*2-1,1,-2)))

# y: m = 3
#             -3
#         -2, -2, -2
#     -1, -1, -1, -1, -1
#  0,  0,  0,  0,  0,  0, 0
#      1,  1,  1,  1,  1
#          2,  2,  2
#              3
#  0,
#  -1, 0, 1
#  -2,-1, 0, 1, 2
#  -3,-2,-1, 0, 1, 2, 3
#  -2,-1, 0, 1, 2
#  -1, 0, 1
#  0
ys <- function(y, m) y + unlist(mapply(":", c(0:-m, -(m-1):0), c(0:m, (m-1):0)))

np <- function(x, y, m) data.frame(x=xs(x, m), y=ys(y, m))

all.np <- unique(do.call("rbind", apply(x, 1, function(x) np(x[1], x[2], manhattan(x[1], x[2], x[3], x[4])))))

sum(all.np$y == 10) - 1
