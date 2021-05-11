#' Convert a JPG image to png format
#'
#' A common task for photos captured with iPhone
#'
#' @param path Character. Path to one or more images to convert.
#'
#' @return Writes a copy of the JPG file as a png in the same directory.
#' @export
#'
jpg2png <- function(path){

  new_path <- stringr::str_replace(path, stringr::regex(pattern = 'jpg|jpeg', ignore_case = T), replacement = 'png')

  convert <- function(path = path){
    magick::image_read(path = path) %>%
      magick::image_convert(format = "png")
  }

  converted <- purrr::map(path, convert)

  args <- list(path = new_path, image = converted)

  purrr::pwalk(args, magick::image_write)

}

