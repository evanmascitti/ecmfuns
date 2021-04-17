#' Constructs a path to write an empty delimited file for collecting data
#'
#' Used as a helper by my other packages; automatically appends the date to the
#' end of the file path (prefixed by an underscore)
#'
#' @param stem character vector of file stems, without extension
#' @param base root of file; i.e. directory where it should be saved. Defaults
#'   to `here::here()` if not supplied
#' @param date date for collection, defaults to today's date
#' @param ext file extension, defaults to "csv" but also accepts "tsv" or
#'   "xlsx"; period optional; accepts a character vector of multiple formats if
#'   desired
#'
#' @return character vector of paths with length matching that of the `stem`
#'   argument
#' @export
#'
#' @example R/examples/build_datasheet_path_example.R
#'
#' @importFrom rlang %||%
#'
build_datasheet_path <- function(stem,
                                 base = NULL,
                                 date = NULL,
                                 ext = "csv") {

  # match file extension to user input

  ext <- match.arg(ext, choices = c("csv", "tsv", "xlsx"), several.ok = TRUE)

  # add a period before file name if it was not supplied by the user
  if(!all(stringr::str_detect(string = ext, pattern = "^\\."))){
    ext <- paste0(".", ext)
  }

  # if user has not supplied a base for the file name, set its value to the current
  # working directory
  base <- base %||% here::here()

  # if user does not supply the date, use today's date
  date <- date %||% Sys.Date()

  # implicitly return the vector of file paths

  c(outer(paste0(base, "/", stem, "_", date), ext, paste0))

}


