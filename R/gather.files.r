#'\lifecycle{experimental}
#'
#'Prepare a set of files to be iteratively read into R
#'
#'This is a helper function to remove friction when reading multiple data files
#'in one step. Using `list.files()` is not intuitive for reading files because it
#'returns only the base file name and none of the parent directories. A standard
#'method would require a `paste()` or `paste0()` call to concatenate the root path
#'and the base file name.
#'
#'`gather.files()` reduces opacity and eyesore during this common task. It
#'leverages the functionality of `list.files()` with the `str_sub()` function from
#'**stringr** to remove both the parent directory and the file
#'extensions from the names assigned upon import.
#'
#'@param tabbed_directory The quoted directory in which the files reside, as
#'  understood from the auto-complete hosted in R Studio. For .Rmd files this is
#'  a relative path from the directory housing the .Rmd file.
#'@param filetype a quoted 3-letter file extension, \strong{without} the "." Be
#'  sure to use correct capitalization for the file type of interest.
#'
#'@details This function is designed to be used with the pipe (`%>%`) from
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
#' tabbed_directory= "data/raw_data/2020-10-25_Atterberg_limits",
#' filetype= "csv") %>%
#' map(read_csv) %>%
#' enframe(value= "raw_data_file") }

gather.files <- function(tabbed_directory = " ", filetype = " ") {

  parent_dirs <- paste0(here::here(tabbed_directory), '/')
  file_names <- list.files(path= parent_dirs, pattern = filetype, recursive = F)
  full_paths <- paste0(parent_dirs, file_names ) %>%
    purrr::set_names(stringr::str_sub(basename(.), end = -5) )

  if (length(stringr::str_detect(string = file_names, pattern = filetype) ) == 0 ) {
    stop("\n\n\nDirectory does not contain any files with this extension.
      Check thefollowing:\n\n 1.  Did you specify the correct sub-folder?
      This function does not search recursively.\n\n 2.  Did you type the
      file extension correctly? This includes capitilization! Don't use
      a \".\" before the 3-letter extension.")
  }
  return(full_paths)

}
