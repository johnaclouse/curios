#' Include Custom HTML Style Elements Into Active Document
#'
#' Generate inline style components to modify the standard flexdashboard
#' \emph{css}. Original functionality updated based on example from
#' \code{st_css()} from \url{https://github.com/dcomtois/summarytools}
#'
#' @details The style formatting is intended to be used with bootsrap's
#'   \code{readable} theme.
#'
#' @param main Logical. Include \emph{summarytools.css} file. \code{TRUE} by
#'   default. This will affects only \strong{summarytools} objects, for one
#'   exception: two properties of the \code{img} tag are redefined to have
#'   \code{background-color: transparent} and \code{border: 0}.
#' @param \dots Character. Path to additional \emph{css} file(s) to include.
#'
#' @return The style content and \emph{css} file(s) returned silently as a
#'   character vector, and printed (using \code{cat()}).
#'
#' @details The function may be called in an \emph{R markdown} document code
#'   chunk having options \code{echo=FALSE} and \code{results="asis"}.
#'
#' @export
add_custom_style <- function(main = TRUE,
                             ...) {

  output <- character()

  output <- append(output, "<style type=\"text/css\">\n")

  if (isTRUE(main)) {
    output <- append(output, "/*
.navbar-inverse .navbar-nav>.active>a, .navbar-inverse .navbar-nav>.active>a:hover, .navbar-inverse .navbar-nav>.active>a:focus {
color: #fbb034;
background-color: #00467f;
border-color: #002a4c;
font-weight: 900;
}
*/

/* Overwrite flexdashboard readable theme */
body {
  background: #ffffff;
}

.navbar-brand  {
/* align flexdashboard title (aka brand) with logo */
 padding: 15px 0px 0px 15px;
}

pre {
  background-color:white; border:0; /* background for sidebar*/
}

.chart-title {
/* border-bottom: 1px solid #d7d7d7; */
  border-bottom: none;
  color: #333333;
  font-size: 22px;
  font-weight: 700;
  padding: 7px 10px 4px;
  margin-top: 25px; /* fixes realative link landing on page and hiding heading*/
}

.chart-wrapper, .nav-tabs-custom, .sbframe-commentary {
    background: #fff;
    border: none;
    border-radius: 3px;
    margin-bottom: 8px;
    margin-right: 8px;
}

.heading-level1 {  /* chart_title  */
/* color: #00467f; */
color:red;
font-size: 18px;
font-weight: 500;
}

h3, .h3 {
  color: #002a4c;
  font-size: 24px;
  font-weight: 650;
  margin-top:24px;
  margin-bottom:4px;
}

h4, .h4 {
  color: #002a4c;
  font-size: 18px;
  font-weight: 550;
  margin-top:24px;
  margin-bottom:4px;
}

a:link {
color: blue;
}

a:visited {
color: blue;
}

.table>thead>tr>th {
  border-color: black;
}


/** Remove borders within the table body **/
.table>tbody>tr>td {
  border: none;
}


/** Add a top border to the table header row **/
.table thead tr:first-child {
  border-top: 2px solid black;
}


/** Add a bottom border to the table body
.table tbody tr:last-child {
  border-bottom: 2px solid black;
}
**/

/** Make the table header row a normal weight; not bold **/
.table th{
  font-weight: normal;
}


/** Make the caption italic and black **/
.table caption{
  font-style: italic;
  color: black;
}

.image-container {
  background-position: center top !important;
}

.scroll_chunk {
  max-height: 425px;
  float: left;
  overflow-y: auto;
}

mark {
  background-color: yellow;
  color: black;
}")
  }


dotArgs <- list(...)
for (f in dotArgs) {
  output <- append(output, readLines(f))
}

output <- append(output, "</style>\n")

output <- paste(output, sep = "\n")
cat(output)
return(invisible(output))
}
