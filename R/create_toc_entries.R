#' Format individual table of contents line
#'
#' @param x a HTML node
#' @param html_file URL for the page containing the node
#'
#' @keywords internal
#'
#' @return a character value with the table of contents entry
format_toc_entry <- function(x, html_file){
  cat("|    [", x, "](", html_file, "#", stringr::str_remove_all(x, " "),")\n", sep = "")
}

#' Create table of contents entries from web page content
#'
#' Given a html file, parse throught the file looking for h3 html nodes.
#' Each node is formatted using format_toc_entry() and returned as a character vector.
#'
#' create_toc_entries expects a flexdashboard with H3 headers (### in rmarkdown).
#' In addtion, the header should be followed by a tag identical to the heading
#' but without white space e.g., {#HeaderasisWithoutSpaces}.
#'
#'
#' @param html_file a html file
#'
#' @return A character vector of table of formatted table contents entries
#' @export
#'
#' @examples
#' create_toc_entries(system.file("extdata", "curios-test-flexdashboard.html", package = "curios"))
create_toc_entries <- function(html_file){
  xml2::read_html(html_file) %>%
    rvest::html_nodes("h3") %>%
    rvest::html_text() %>%
    purrr::walk(format_toc_entry, html_file)
}


