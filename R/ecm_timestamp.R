#' Print a time stamp including specific information
#'
#' Calls [base::Sys.time()] with a particular `format` argument. Use for keeping track of .Rmd knitting.
#'
#' @return character vector with formatted weekday abbreviation, date, and time
#' @export
#'
#' @examples ecm_timestamp()
ecm_timestamp <- function(){
  strftime(Sys.time(), format = "%a. %F, %l:%M %p")
  }
