#' Find all figures inserted using `insert_fig()` to allow easy uploading for manuscript submission
#'
#' Looks in the `.Rmd` for any calls to this function and extracts the figure file names
#'
#' @param file `.Rmd` file to search
#'
#' @return character vector of file stems
#' @export
#'
find_paper_figures <- function(file) {

  x <- readLines(
    con = file
  )

  return_vector <- stringr::str_extract(x[stringr::str_detect(x, 'insert_fig')], "(?<=['\"]).*(?=['\"])")

  return(return_vector)

}
