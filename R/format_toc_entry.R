#' Format individual table of contents line
#'
#' @param entry a character string to be converted to a Table of Contents entry.
#' @param prefix a character string to be added to the front of the entry string
#'   typically for indentation purposes.
#' @param html_file URL for the page containing the node. Defaults to \code{""}
#'   indicating current page.
#'
#' @keywords internal
#'
#' @return a character value with the table of contents entry
#' @export
#'
#' @examples
#' format_toc_entry(c("Header 1", "Header 2"))
#' format_toc_entry("Header 1", "---->", "mypage.html")
format_toc_entry <- function(entry,
                             prefix = "|    ",
                             html_file = ""){

  transformed_entry <-
    stringr::str_replace_all(tolower(entry), " ", "-")

  cat(prefix,
      "[", entry, "](", html_file, "#", transformed_entry,")\n",
      sep = "")
}
