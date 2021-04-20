#' \lifecycle{maturing}
#'
#' Return today's date in a professional format
#'
#' The \strong{lubridate} package does an excellent job of parsing dates which
#' are in messy formats back to POSIX format. However it is not so good for
#' printing dates in the way the people typically read or think about them. This
#' function prints the current date in a format more amenable to professional
#' reports and presentations. The date can be printed in typical shorthand or in
#' a formal manner. Both the month and weekday can be included or excluded, and
#' if they are included they can be either printed in full or abbreviated.
#'
#' @param dash_format Whether the month should be printed as a month/day/year
#'   string or in formal language
#' @param month_abb Whether the month should be abbreviated or printed in full
#' @param weekday Whether the day of week should be included
#' @param weekday_abb Whether the day of week (if included) should be
#'   abbreviated
#'
#' @return A professionally formatted character string containing the current
#'   system date.
#' @export
#' @examples
#' # print full date with weekday name
#' today_ecm()
#'
#' # print full date with abbreviated weekday name
#' today_ecm(weekday = TRUE, weekday_abb = TRUE)
#'
#' # print date without the weekday
#' today_ecm(weekday_abb = FALSE)
#'
#' # print date with shorthand notation
#' today_ecm(dash_format= TRUE)
#'
#'

today_ecm <- function(dash_format= FALSE, month_abb = TRUE,
                      weekday = TRUE, weekday_abb = FALSE) {
  if(weekday == FALSE & weekday_abb == TRUE) {
    stop("\nYou specified that the weekday should be abbreviated, but also indicated that the weekday should not be included at all. Did you intend to print the weekday?")
  }
  if(dash_format == TRUE) {
  full_date <-paste(lubridate::month(lubridate::today()),
                 lubridate::day(lubridate::today()),
                 stringr::str_sub(string = lubridate::year(lubridate::today()),
                                  start = 3),
                 sep = '-')
  } else{

  weekday <- if (weekday == TRUE){
    if(weekday_abb == FALSE) {
      lubridate::wday(lubridate::today(), abbr = F, label = T)}
        else {
          lubridate::wday(lubridate::today(), abbr = T, label = T)}
    } else{
    weekday <- ""
  }

  if(!requireNamespace('scales')){
    stop("This function requires the `scales` package. Please install from CRAN or GitHub.")
  }

  day <- scales::ordinal(lubridate::day(lubridate::today()))

  month <-lubridate::month(lubridate::today(), abbr = month_abb, label = T)

  year <- lubridate::year(lubridate::today())

  full_date <- paste0(weekday, ' ', month, ' ', day, ', ', year)
}
  return(full_date)
}

