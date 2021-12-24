#' Format individual table of contents line
#'
#' @param x a HTML node
#' @param html_file URL for the page containing the node
#'
#' @return a character value with the table of contents entry
format_toc_entry <- function(x, html_file){
  cat("|    [", x, "](", html_file, "#", stringr::str_remove_all(x, " "),")\n", sep = "")
}

#' Create table of contents entries from web page content
#'
#' @param html_file a html file
#'
#' @return a character vector of table of formatted table contents entries
#' @export
create_toc_entries <- function(html_file){
  xml2::read_html(html_file) %>%
    rvest::html_nodes("h3") %>%
    rvest::html_text() %>%
    purrr::walk(format_toc_entry, html_file)
}


