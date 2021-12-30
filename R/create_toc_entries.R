#' Create table of contents entries from web page content
#'
#' Given a html file, parse throught the file looking for h3 html nodes. Each
#' node is formatted using format_toc_entry() and returned as a character
#' vector.
#'
#' create_toc_entries expects a flexdashboard with H3 headers (### in
#' rmarkdown). In addtion, the header should be followed by a tag identical to
#' the heading but without white space e.g., {#HeaderasisWithoutSpaces}.
#'
#' @details Use node_type = "h3" to find rmarkdown ### headers or node_type =
#'   "h1" to find rmarkdown page headers. node_type = "h2" refers to column or
#'   row oobjects in a flexdashboard.
#'
#' @param html_file a html file
#' @param node_type character string defaults to "h3"
#' @param prefix_map a named character vector used to map node types to prefix
#'   strings for the table of contents entry
#'
#' @return A character vector of table of formatted table contents entries
#' @export
#'
#' @examples
#' create_toc_entries(system.file("extdata", "curios-test-flexdashboard.html",
#' package = "curios"))
#'
#' create_toc_entries(system.file("extdata",
#' "curios-test-flexdashboard.html", package = "curios"), node_type = "h3")
#'
#' create_toc_entries(system.file("extdata", "curios-test-flexdashboard.html",
#' package = "curios"), prefix_map = c("h1" = "--", "h3" = "----"))
create_toc_entries <- function(html_file,
                               node_type = "h1, h3",
                               prefix_map = c("h1" = "", "h3" = "|    ")
){
  ### See ?"!!!" the big-bang operator forces-splits a list of objects
  elements <-  xml2::read_html(html_file) %>%
    rvest::html_elements(node_type)

  # purrr::map_df(~ data.frame(value = rvest::html_text(.x), prefix = rvest::html_name(.x) )) %>%
  entries <- data.frame(value = rvest::html_text(elements),
                        prefix = rvest::html_name(elements) )


  entries$prefix <- dplyr::recode(entries$prefix, !!!prefix_map)

  purrr::walk2(.x = entries$value,
               .y = entries$prefix,
               .f = ~ format_toc_entry(entry = .x, prefix = .y, html_file = html_file))
}
