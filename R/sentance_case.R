#' sentance_case
#'
#' @param x character
#'
#' @return character
#' @export
#'
#' @examples
#' sentance_case("the CAT's name is Skipper")
sentance_case <- function(x) {
  paste0(toupper(substr(x, 1, 1)), tolower(substring(x, 2)))
}
