#' Convert an Excel date to `POSIXct` object
#'
#' @param x Integer corresponding to Excel convention, where day 1 is Jan 1, 1900
#'
#' @returns POSIXct object
#' @export
#'
#' @examples
#' convert_excel_date(1) # First day of Excel time scale
#' convert_excel_date(46113) # April 2026

convert_excel_date <- function(x) {
  as.POSIXct(as.Date("1899-12-31") + x, origin = "1899-12-31")
}
