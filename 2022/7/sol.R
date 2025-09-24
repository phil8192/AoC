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

