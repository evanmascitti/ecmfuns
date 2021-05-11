#' Tell user to install missing packages
#'
#' A helper function to allow fewer packages to be listed in Imports section of DESCRIPTION file
#'
#' @param pkgs Character vector of packages to look for
#'
#' @return error message listing the missing packages
#' @export
#'
pkg_check <- function(pkgs){

required_pkgs <- pkgs

missing_pkgs <- vapply(
  X = required_pkgs,
  FUN = function(x) !invisible(requireNamespace(x, quietly = T)),
  FUN.VALUE = TRUE)

pkg_check <- any(missing_pkgs)

if(pkg_check){
  stop(
    glue::glue("Missing {length(missing_pkgs)} required packages for this function:"),
    "\n",
  paste0(names(missing_pkgs), sep = "  "),
  "\n",
  "Please install these from CRAN with the `install.packages()` function."
  )
}

}
