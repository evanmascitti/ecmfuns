#' Construct a URL Path to Content on Google Drive
#'
#' Makes it simple to access content hosted on Google Drive in output from R Markdown and friends
#'
#' @param id Character. Unique Google Drive ID, easily obtained with [googledrive::as_id()] from the [googledrive](https://googledrive.tidyverse.org) package.
#'
#' @return Character vector with boilerplate url and ID
#' @export
#'
#' @references
#'
#' [Blog post by P. Aboyi](https://blog.usejournal.com/host-static-images-for-your-apps-or-website-on-google-drive-hotlink-to-gdrive-images-358d6fcf8ef7)
#'
#' @examples
#' \dontrun{
#' \# save url as a variable
#' baseball <- build_drive_url("1lKrIWe3QaotbHZ0eJSC57UNf2mJTRAoh")
#' \# display in default browser
#' browseURL(baseball)}
#'
#'
#'
#'
#'
build_drive_url <- function(id){
  paste0("https://drive.google.com/uc?id=", id)
}
