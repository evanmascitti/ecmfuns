#'\lifecycle{experimental}
#' Compute the average hex color of an image file
#'
#'Use this function to quickly extract the average color of an image for display on screens. Helpful for visualization purposes and making realistic drawings in vector graphics software such as Adobe Illustrator.
#'
#' @param image
#'
#' @return A character vector of length 1, containing average hexidecimal color of all pixels in the image
#' @export
#'
#' @example
hex_extract <- function(image) {
  image %>%
    PictureResults() %>%
    .[["const"]] %>%
    .[["color"]]
}
