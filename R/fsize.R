#' Print a file size in a human-readable format
#'
#' @param path quoted path to file
#' @param digits number of decimal places to pring
#'
#' @return The file size, formatted with appropriate prefix
#' @export
#'
#' @seealso [`file.size()`], \link[gdata]{humanReadable}
#'
fsize <- function(path, digits = 0){

  pkg_check('gdata')

  gdata::humanReadable(x = base::file.size(path), standard = "SI", digits = digits)
}
