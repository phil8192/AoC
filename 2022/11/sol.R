read_monkeys <- function(x) {
  monkeys=list()
  monkey <- NA
  for (x in trimws(readLines(x))) {
    if (startsWith(x, "Monkey")) {
      monkey <- list(n=as.integer(sub(":", "", sub("Monkey ", "", x))))
    } else if (startsWith(x, "Starting")) {
      monkey[["items"]] <- as.integer(unlist(strsplit(sub("Starting items: ", "", x), ", ")))
    } else if (startsWith(x, "Operation")) {
      monkey[["op"]] <- eval(parse(text=(sub("Operation: new = ", "function(old) ", x))))
    } else if (startsWith(x, "Test")) {
      monkey[["test"]] <- eval(parse(text=paste("function(x) x %%", sub("Test: divisible by ", "", x), "== 0")))
    } else if (startsWith(x, "If true")) {
      monkey[["true"]] <- as.integer(sub("If true: throw to monkey ", "", x))
    } else if (startsWith(x, "If false")) {
      monkey[["false"]] <- as.integer(sub("If false: throw to monkey ", "", x))
      monkeys[[length(monkeys)+1]] <- monkey
    }
  }
  monkeys
}

#monkeys <- read_monkeys("test.txt")
#z <- prod(c(23,19,13,17))
monkeys <- read_monkeys("x.txt")
z <- prod(c(7,11,13,3,17,2,5,19))
rounds <- 10000 

counts <- rep(0, length(monkeys))

for (round in 1:rounds) {
  for (i in 1:length(monkeys)) {
    with(monkeys[[i]], {
      if (exists("items") && length(items) > 0) {
        ops <- op(items) %% z #floor(op(items) / 3)
        tested <- test(ops)
        monkeys[[n+1]]$items <<- c()
        monkeys[[true+1]]$items <<- c(monkeys[[true+1]]$items, ops[tested])
        monkeys[[false+1]]$items <<- c(monkeys[[false+1]]$items, ops[!tested])      
        counts[i] <<- counts[i] + length(items)
      }
    })
  }
}

activity <- rev(sort(counts))
print(activity[1] * activity[2])

