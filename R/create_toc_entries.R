#' Create table of contents entries from web page content
#'
#' Given a html file, parse throught the file looking for h3 html nodes. Each
#' node is formatted using format_toc_entry() and returned as a character
#' vector.
#'
#' The function create_toc_entries expects a flexdashboard with H3 headers (###
#' in rmarkdown). In addtion, the header should be followed by a tag identical
#' to the heading but without white space e.g., {#HeaderasisWithoutSpaces}. The
#' function is used for the side-effect of directly printing table of contents
#' entries.
#'
#' @details Use node_type = "h3" to find rmarkdown ### headers or node_type =
#'   "h1" to find rmarkdown page headers. node_type = "h2" refers to column or
#'   row oobjects in a flexdashboard.
#'
#' @param html_file a html file
#' @param node_type character string defaults to "h3"
#' @param prefix_map a named character vector used to map node types to prefix
#'   strings for the table of contents entry
#' @param include_page_name a logical if true, the table of contents begins with
#'   a link to the page as the first entry.
#'
#' @return NULL
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
                               prefix_map = c("h1" = "", "h3" = "|    "),
                               include_page_name = TRUE
){
  if (include_page_name == TRUE) {
    base_name <- fs::path_file(html_file) %>%
      stringr::str_sub(1, (stringr::str_length(.) - 5))
    format_toc_entry(
      entry = base_name,
      prefix = dplyr::recode("h1",!!!prefix_map),
      html_file = html_file
    )
  }

  ### See ?"!!!" the big-bang operator forces-splits a list of objects
  elements <-  xml2::read_html(html_file) %>%
    rvest::html_elements(node_type)

  entries <- data.frame(value = rvest::html_text(elements),
                        prefix = rvest::html_name(elements) )


  entries$prefix <- dplyr::recode(entries$prefix,!!!prefix_map)
  purrr::walk2(.x = entries$value,
               .y = entries$prefix,
               .f = ~ format_toc_entry(
                 entry = .x,
                 prefix = .y,
                 html_file = html_file
               )
  )
}
