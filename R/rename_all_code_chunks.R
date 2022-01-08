#' Remove generic code chunk names from an RMD file
#'
#' This function is a wrapper for /code{namer::unname_all_chunks}
#'
#' @param x a complete path, filename, and extension to a .Rmd file
#'
#' @return NULL
remove_code_chunk_names <- function(x) {
  name_prefix <- fs::path_ext_remove(fs::path_file(x))
  name_prefix <- stringr::str_replace_all(name_prefix, "_| ", "-")
  namer::unname_all_chunks(x,
                           chunk_name_prefix = name_prefix
  )
}


#' Rename all generic code chunks in current directory
#'
#' This function changes source code files! All generic code chunks created
#' using the file name as a prefix will be removed and new code chunks names
#' created using /code{namer::name_chunks}. Code chunks with specific names
#' should not be effected.
#'
#' @return NULL
#' @export
#'
#' @examples
#' # rename_all_code_chunks()
rename_all_code_chunks <- function(){
  response <- readline(prompt = "This will remove and replace all generic code chunk names. Do you want to continue (y)?")
  if (response == "y"){
    message("Removing generic names...")
    list.files(
      pattern = "*.Rmd",
      full.names = TRUE,
      recursive = TRUE
    ) %>%
      purrr::walk(~ remove_code_chunk_names(.x))

    message("Adding new generic names...")
    list.files(
      pattern = "*.Rmd",
      full.names = TRUE,
      recursive = TRUE
    ) %>%
      purrr::walk(~ namer::name_chunks(.x))
    message("Code chunks renamed.")
  } else {
    "No changes made."
  }
}
