#' Return a name comprised of an adjective animal word pair
#'
#' @name adjective_animal
#'
#' @param n number of word pairs to return
#'
#' @return vector of character values containting adjective_animal names
#' @export
#'
#' @examples
#' adjective_animal(3)

data('adjectives')
data('animals')

adjective_animal <- function(n = 1) {
x <- sample(length(adjectives) * length(animals), n * 2, replace = TRUE)
adj <- x[seq_along(x) %% 2 == 1] %% length(adjectives) + 1
ani <- x[seq_along(x) %% 2 == 0] %% length(animals) + 1
paste0(adjectives[adj], "_", animals[ani])
}

