#' Round value based on magnitude
#'
#' @param x A numeric value to be rounded. Values >= 100 are rounded to 1
#'   decimal place. Values < 100 and >=1 are rounded to two decimal places.
#'   Values <1 are rounded to three decimal places.
#'
#' @return A numeric value rounded based on the magnitude of `x`
#' @export
#'
#' @examples
#' library(curios)
#' # Note: R will display right padded zero's below. This is a display manifestation only.
#' roundx_n(c(0.1234, 1.1234, 100.123))
#' # Verify rounding does not add right hand padding
#' roundx_n(c(0.1234, 1.1234, 100.123))[3]
roundx_n <- function(x) {
  dplyr::case_when(abs(x) >= 100 ~ round(x, 1),
                   abs(x) >= 1 ~ round(x, 2),
                   TRUE ~ round(x, 3))
}
