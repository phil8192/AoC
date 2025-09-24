# this does not work (for some reason they want to double count the values):
#  To begin, find all of the directories with a total size of at most 100000,
#  then calculate the sum of their total sizes. In the example above, these 
#  directories are a and e; the sum of their total sizes is
#  95437 (94853 + 584). (As in this example, this process can count files more
#  than once!)
#
# ..think they got the answer they expect from recursion 
#
if(F) {
x <- readLines("x.txt")[-1]
f <- list()
p <- c("root")

for (l in x) {
  s <- unlist(strsplit(l, " "))
  if (s[1] == "dir") next
  if (s[2] == "ls")  next
  if (s[2] == "cd") {
    if (s[3] == "..") p <- head(p, -1)
    else              p <- c(p, s[3])
  } else {
    f[paste0(paste0(p, collapse="_"), "_F", s[2])] <- as.integer(s[1])
  }
}

u <- unique(unlist(lapply(strsplit(names(f), "_"), function(x) paste0(head(x, -1), collapse="_"))))
s <- unlist(lapply(u, function(x) sum(unlist(f[startsWith(names(f), x)]))))

# 1
print(sum(s[s <= 100000]))

# 2
used <- 70000000-max(s)
need <- 30000000-used
print(min(s[s >= need]))
}


if(T){
directory <- function(parent=emptyenv()) {
  e <- new.env(parent=parent)
  e$children <- list()
  e$files <- list()
  e
}

get_parent <- function(directory) parent.env(directory)
has_parent <- function(directory) !identical(parent.env(directory), emptyenv())


root <- directory()
cdir <- root

for (x in readLines("x.txt")) {
  s <- unlist(strsplit(x, " "))
  if (s[1] == "dir") next
  if (s[2] == "ls") next
  if (s[2] == "cd") {
    if (s[3] == "/") {
      cdir <- root
    } else if (s[3] == ".." && has_parent(cdir)) {
      cdir <- get_parent(cdir)
    } else {
       if (!s[3] %in% names(cdir$children)) {
         cdir$children[[s[3]]] <- directory(cdir)
       }
       cdir <- cdir$children[[s[3]]]
    }
  } else {
    cdir$files[[s[2]]] <- as.integer(s[1])
  }
}

found <- c()
size <- function(directory) {
  s <- sum(unlist(directory$files))
  if (length(directory$children) == 0) {
    found <<- c(found, s)
    s
  } else {
    cs <- s + sum(unlist(lapply(directory$children, size)))
    found <<- c(found, cs)
    cs
  }
}

# 1
ts <- size(root)
print(sum(found[found <= 100000]))

# 2
used <- 70000000-ts
need <- 30000000-used
print(min(found[found >= need]))
}
