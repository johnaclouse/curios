data('adjectives')
data('animals')
adjective_animal <- function(n = 1) {
x <- sample(length(adjectives) * length(animals), n * 2, replace = TRUE)
adj <- x[seq_along(x) %% 2 == 1] %% length(adjectives) + 1
ani <- x[seq_along(x) %% 2 == 0] %% length(animals) + 1
paste0(adjectives[adj], "_", animals[ani])
}

# adjective_animal()
