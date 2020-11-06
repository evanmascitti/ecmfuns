#' Return today's date in a professional format
#'
#' The \strong{lubridate} package does an excellent job of parsing dates which are in messy formats back to POSIX format. However it is not so good for printing dates in the way the people typically read or think about them. This function prints the current date in a format more amenable to professional reports and presentations.
#'
#' @param month_abb Whether the month should be abbreviated or printed in full
#'
#' @return A professionally formatted character string containing the current system date.
#' @export
#'

today_ecm <- function(month_abb= TRUE) {
  weekday <- lubridate::wday(lubridate::today(), abbr = F, label = T)
  day <- scales::ordinal(lubridate::day(lubridate::today()))
  month <- lubridate::month(lubridate::today(), abbr = month_abb, label = T)
  year <- lubridate::year(lubridate::today())

  full_date <- paste0(weekday, ', ', month, ' ', day, ' ', year)

  return(full_date)
}
