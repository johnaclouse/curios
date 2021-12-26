#' Check to see if a numeric vector is discrete based number of unique values
#'
#' A simple test intended to distinguish between discrete and continuous values
#' for the purpose of choosing analytics visualization selection. The selection
#' of a cutoff value is purely subjective.
#'
#' @param x a vector of numeric values
#' @param cutoff maximum number of unique values in x before x is considered not discrete
#'
#' @return logical
#' @export
#'
#' @examples
#' is_discrete(1:10)
#' is_discrete(runif(1000))
is_discrete <- function (x, cutoff = 100){
  stopifnot("x is not numeric" = is.numeric(x))
  unique_value_count <- length(unique(stats::na.omit(x)))
  ifelse(unique_value_count < cutoff, TRUE, FALSE)
}
