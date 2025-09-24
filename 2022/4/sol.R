x <- read.csv("x.txt", header=F)
m <- matrix(apply(x, 1, function(x) as.integer(unlist(strsplit(x, "-")))), ncol=4, byrow=T)
sum(apply(m, 1, function(x) x[1] >= x[3] & x[2] <= x[4] | x[1] <= x[3] & x[2] >= x[4]))
sum(apply(m, 1, function(x) length(intersect(x[1]:x[2], x[3]:x[4]))) > 0)

# or
sum(m[,1] >= m[,3] & m[,2] <= m[,4] | m[,1] <= m[,3] & m[,2] >= m[,4])
sum(m[,2] >= m[,3] & m[,1] <= m[,3] | m[,4] >= m[,1] & m[,3] <= m[,1])
