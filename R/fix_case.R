#' Fix word case
#'
#' Attempt to convert words from given format to sentence, title, lower, or
#' upper case while being mindful of APA style guidelines, acronyms, and custom
#' word replacement lists.
#'
#' @details Note: word replacement is done in a case sensitive manner.  For
#'   example, "usDA" would be replaced with "USDA" as would "UsDA" or "usda".
#'
#' @param x character string.
#' @param to_lower_first logical,indicating character string should first be converted to all lower case.
#' @param replace_underscores logical determines replacement of underscore characters.
#' @param underscore_replacement character string to replace underscores.
#' @param to_lower_minor_words logical determines if minor words are all lower case.
#' @param minor_words named character vector of minor words that will be converted to lower case.
#' @param to_upper_known_acronyms logical determines if known acronyms are replaced with case correct versions.
#' @param known_acronyms named character vector of acronyms that will be converted to proper case.
#' @param replace_named_words logical determines if a set of \code{named_words} are replaced with case correct versions.
#' @param named_words named character vector of words that will be replaced with alternate words or word case
#' @param case character designating the overall case structure: title (default), sentence, lower, upper.
#'
#' @return character string
#' @export
#'
#' @examples
#' fix_case("the hba1c level was reported as a1C", case = "sentence")
fix_case <- function(x,
                     to_lower_first = FALSE,
                     replace_underscores = TRUE,
                     underscore_replacement = " ",
                     to_lower_minor_words = TRUE,
                     minor_words = curios::minor_words,
                     to_upper_known_acronyms = TRUE,
                     known_acronyms = curios::known_acronyms,
                     replace_named_words = FALSE,
                     named_words = NA,
                     case = c("title", "sentence", "lower", "upper")
){

  cap_first_letter <- function(x) {
    paste(toupper(substring(x, 1, 1)), substring(x, 2),
          sep = "", collapse = " ")
  }

  to_title <- function(x) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1, 1)), substring(s, 2),
          sep = "", collapse = " ")
  }

  stopifnot("Case must be one of: title, sentence, lower, upper" = case %in% c("title", "sentence", "lower", "upper"))

  if (to_lower_first == TRUE) {
    x <- stringr::str_to_lower(x)
  }

  if (replace_underscores == TRUE) {
    x <- stringr::str_replace_all(x, "_", underscore_replacement)
  }

  if (replace_named_words == TRUE) {
    x <- stringr::str_replace_all(x, stringr::fixed(named_words, ignore_case = TRUE))
  }

  case <- match.arg(case)
  x <- switch(case,
              title = to_title(x),
              sentence = cap_first_letter(x),
              lower = tolower(x),
              upper = toupper(x)
  )

  if (to_lower_minor_words == TRUE)
    x <- stringr::str_replace_all(x, minor_words)

  if (to_upper_known_acronyms == TRUE) {
    x <- stringr::str_replace_all(x, stringr::fixed(known_acronyms, ignore_case = TRUE))
  }

  if (case != "lower") {
    x <- cap_first_letter(x)
  }

  return(x)
}
