#' Multiple gsub
#' 
#' \code{multigsub} - A wrapper for \code{\link[base]{gsub}} that takes a vector 
#' of search terms and a vector or single value of replacements.
#' Code originally from the qdap package: https://rdrr.io/cran/qdap/src/R/multigsub.R
#' 
#' @param pattern Character string to be matched in the given character vector. 
#' @param replacement Character string equal in length to pattern or of length 
#' one which are  a replacement for matched pattern. 
#' @param text.var The text variable.
#' @param leadspace logical.  If \code{TRUE} inserts a leading space in the 
#' replacements.
#' @param trailspace logical.  If \code{TRUE} inserts a trailing space in the 
#' replacements.
#' @param fixed logical. If \code{TRUE}, pattern is a string to be matched as is. 
#' Overrides all conflicting arguments.
#' @param trim logical.  If \code{TRUE} leading and trailing white spaces are 
#' removed and multiple white spaces are reduced to a single white space.
#' @param order.pattern logical.  If \code{TRUE} and \code{fixed = TRUE}, the 
#' \code{pattern} string is sorted by number of characters to prevent substrings 
#' replacing meta strings (e.g., \code{pattern = c("the", "then")} resorts to 
#' search for "then" first).
#' @param \dots Additional arguments passed to \code{\link[base]{gsub}}.
#' @rdname multigsub
#' @return \code{multigsub} - Returns a vector with the pattern replaced.
#' @seealso \code{\link[base]{gsub}}
#' @export
#' @examples
#' \dontrun{
#' ## ======================
#' ##    `mgsub` Function
#' ## ======================
#' 
#'df = data.frame(
#'word = c("foo", "bar", "foobar",
#'         "energy", "skippito"),
#'stringsAsFactors = F)
#'
#'
#'thesauraus = data.frame(
#'  word = c("skippito", "foobar"),
#'  replacement = c("Skipper Cat", "foo__bar"),
#'  stringsAsFactors = F)
#'
#'df$word
#'multigsub(thesauraus$word, thesauraus$replacement,df$word)
#'
#'
multigsub <-
  function (pattern, replacement, text.var, leadspace = FALSE, 
            trailspace = FALSE, fixed = TRUE, trim = TRUE, order.pattern = fixed, 
            ...) {
    
    if (leadspace | trailspace) replacement <- spaste(replacement, trailing = trailspace, leading = leadspace)
    
    if (fixed && order.pattern) {
      ord <- rev(order(nchar(pattern)))
      pattern <- pattern[ord]
      if (length(replacement) != 1) replacement <- replacement[ord]
    }
    if (length(replacement) == 1) replacement <- rep(replacement, length(pattern))
    
    for (i in seq_along(pattern)){
      text.var <- gsub(pattern[i], replacement[i], text.var, fixed = fixed, ...)
    }
    
    if (trim) text.var <- gsub("\\s+", " ", gsub("^\\s+|\\s+$", "", text.var, perl=TRUE), perl=TRUE)
    text.var
  }
