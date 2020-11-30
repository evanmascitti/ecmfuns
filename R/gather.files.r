#'\lifecycle{experimental}
#'
#'Prepare a set of files to be iteratively read into R
#'
#'This is a helper function to remove friction and reduce eyesore when reading
#'multiple data files in one step. A base method with `list.files()` works fine
#'but requires more arguments than I want to remember for this very common task.
#'This wrapper cleans the path strings to assign nice names to the files as they
#'are imported.
#'
#'@param dir Relative path to directory where the files reside (includes the
#'  trailing `/`). For .Rmd files this begins at the same level as the .Rmd
#'  file, which is usually good but can be annoying when the file you need to
#'  read resides above the .Rmd file in the directory structure. In this case
#'  you can look one directory upward with `/..` or to the top-level directory with
#'  `/`.
#'@param extension quoted file extension, accepts 3-letter extension with OR
#'  without a preceding "." Verify capitalization.
#'@param recursive whether to search sub-directories
#'
#'@details Output is easily piped to [`read.files()`] to read the files and
#'  compile them in a tibble. Because `gather.files` gives nice names to its
#'  elements, the list is more human-readable.
#'
#'@return A named character vector of file paths to read. The element names are
#'  the base file names with the file extension stripped.
#'@export
#'
#' @examples  \dontrun{
#' gather.files(dir = "data/raw_data/2020-10-25_Atterberg_limits",
#' extension= ".csv")}
#'
#'

gather.files <- function(dir = ".", extension = NULL, recursive = FALSE) {

  if(missing(extension)){
    stop('\nNo file extension provided, please specify the type of file to find.')
  }

  # if file name has the dot, leave it alone. If not, paste a dot and the three letters.
  if(stringr::str_detect(extension, pattern = ".")) {
    ext <- extension } else {
      ext <- paste0(".", extension)}

  full_paths <- list.files(path= dir, pattern = ext, recursive = recursive)

  if (length(stringr::str_detect(string = full_paths, pattern = ext) ) == 0 ) {
    stop("\n\nDirectory does not contain any files with this extension.
      Check the following:\n\n 1.  Did you specify the correct sub-folder?
      By default, this function does not search recursively.\n\n 2.  Did you type the
      file extension correctly? Check capitalization and remember to use quotes.")
  }

  full_paths %>%
    purrr::set_names(stringr::str_remove(string = basename(.), pattern = ext) )


  return(full_paths)
}
