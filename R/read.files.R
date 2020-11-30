#' Read multiple files into R
#'
#' Wraps `purrr::map()` with an option to specify whether the list of files `.l`
#' should be compiled with [`tibble::enframe()`]. Use after [`gather.files()`] to
#' pipe in a vector of file paths with human-readable names.
#'
#' @param .x a vector of file paths to read
#' @param read_fn un-quoted file reading function (specific to the file type; i.e. `read_csv` or `vcgImport`)
#' @param enframe whether to create a tibble with a name column and a list-column of the files
#' @param value column name for the files held (ignored if `enframe = FALSE`)
#'
#' @return a list or tibble of the files. Use [`gather.files()`] to give them nice name before importing.
#' @export
#'

read.files <- function(.x, read_fn, enframe= TRUE, value = "file") {

  if(missing(.x)){
    stop('\n No vector of file paths provided. Please specify which files to read.')
  }

  if(missing(read_fn)){
    stop('\n No `read_fn` provided. Please specify an unquoted data import function such as `read_csv`.')
  }

  if(enframe == FALSE){
    files <- purrr::map(.x = .x, .f= {{read_fn}})
  } else{
    files <- purrr::map(.x = .x, .f= {{read_fn}}) %>%
      tibble::enframe(value= value)
  }

  return(files)

}
