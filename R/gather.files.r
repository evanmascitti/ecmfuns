#'\lifecycle{experimental}
#'
#'Prepare a set of files to be iteratively read into R
#'
#'This is a helper function to remove friction and reduce eyesore when reading multiple data files
#'in one step. A base
#'method with `list.files()` works fine but requires more arguments than I want to remember for this very common task.
#' This wrapper cleans the path strings to assign nice names to the files as they are imported.
#'
#'@param dir Relative path to directory where the files reside. For .Rmd files
#'  this begins at the same level as the .Rmd file
#'@param type a quoted file extension, accepts 3-letter extension with or without a preceding "." Verify capitilization.
#'@param read_fn unquoted function for reading files (no parentheses), for example `read_csv`
#'@param enframe whether to actually read the files into the current R session and compile them with `tibble::enframe()`
#'@param value column title for the files, if using `enframe` argument
#'@param recursive whether to search sub-directories
#'
#' @details This function is designed to be used with the pipe (`%>%`) from
#'  \strong{magrittr} and two additional functions: \itemize{ \item{`map()` in the
#'  \strong{purrr} package, which allows the read-in operation to be performed
#'  for all files in one step} \item{a user-supplied function, such as
#'  `read_csv()` for comma-delimited value files or `vcgImport()` for 3D mesh
#'  files} .}
#'
#'  A recommended step to complete this pipeline is to call
#'  `tibble::enframe()` after the `map(<reading function>)` call. This condenses
#'  the list to a nested tibble, with each file as a row. Optionally, use the
#'  `value` argument inside the call to `enframe()` to add a useful description
#'  to what the file (i.e. value) actually is. Because `gather.files` provides
#'  human-friendly names to its elements, there should not be a need to adjust
#'  the `name` argument inside `enframe()`.
#'
#'@import here
#'@return A named character vector of file paths to read. The element names are
#'  the file name with the directories and file extension stripped.
#'@export
#'
#' @examples \dontrun{
#' gather.files(
#' dir = "data/raw_data/2020-10-25_Atterberg_limits",
#' type= "csv") %>%
#' map(read_csv) %>%
#' enframe(value= "raw_data_file") }

gather.files <- function(dir = " ", type = " ", read_fn = NULL, enframe= TRUE, value = "file", recursive = FALSE) {

  if (length(stringr::str_detect(string = file_names, pattern = type) ) == 0 ) {
    stop("\n\nDirectory does not contain any files with this extension.
      Check the following:\n\n 1.  Did you specify the correct sub-folder?
      By default, this function does not search recursively.\n\n 2.  Did you type the
      file extension correctly? This includes capitilization!")
  }

  parent_dirs <- paste0(here::here(dir), '/')

  if(stringr::str_detect(type, pattern = ".")) {
    extension <- type } else {
      extension <- paste0(".", type)}

  file_names <- list.files(path= parent_dirs, pattern = extension, recursive = recursive)


  full_paths <- paste0(parent_dirs, file_names ) %>%
    purrr::set_names(stringr::str_remove(basename(.), pattern = extension) )

  if(enframe){
files_tibble <- full_paths %>%
  purrr::map({{readfn}}) %>%
  tibble::enframe(value = value)
  }

  return(if(enframe){full_paths} else{files_tibble})

}
