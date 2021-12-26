#' Right align numeric values
#'
#' Evaluate a numeric value and optionally perform \code{roundx_n} before
#' padding the decimal portion of the number to n digits. Note: this coverts the
#' numeric value to a character. The function is intended only for final display
#' purposes.
#'
#' @param x numeric value to be right justified
#' @param num_dec number of decimal places to justify
#' @param pad_char padding character defaults to \code{&numsp;}
#' @param do_roundx_n logical to determine if \code{roundx_n} is performed.
#'   Defaults to True
#' @return character
#' @export
#'
#' @examples
#' library(curios)
#' cat(alignx_n(c(0.12345, 1.123344, 100.12345)), sep = "\n")
#'
#' # Without \code{roundx_n}
#' cat(alignx_n(c(100.123, 100.23, 100.1), do_roundx_n = FALSE), sep = "\n")
alignx_n <-
  function(x,
           num_dec = 3,
           pad_char = "&numsp;",
           do_roundx_n = TRUE) {
    if (do_roundx_n == TRUE)
      x <- roundx_n(x)
    splitlist <- strsplit(as.character(x), "[.]")
    ints <- unlist(lapply(splitlist, "[", 1))
    ints[is.na(ints)] <- "0"
    decs <- unlist(lapply(splitlist, "[", 2))
    decs <- ifelse(is.na(decs), "d", paste0(".", decs))


    decs <- stringr::str_pad(decs, num_dec + 1, side = "right", pad = "z")
    paste0(ints, decs) %>%
      stringr::str_replace("d", "&nbsp;") %>%
      stringr::str_replace_all("z", pad_char)
  }
