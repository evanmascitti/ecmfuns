#' Parse a Panalytical XRDML file
#'
#' Produces a tibble of intensity and 2-theta vales
#'
#' @param path Character. full path to file
#' @param scaled Logical. Whether to normalize intensity to maximum value (default `TRUE`)
#' @param min_tth minimum value for 2-theta to keep (default 4)
#' @param max_tth maximum value for 2-theta to keep (default 40)
#'
#' @return Tibble with 2 columns
#' @export
#'
read_xrd <- function(path, scaled = TRUE, min_tth = 4, max_tth = 40){

  # browser()

  full_text <- stringr::str_c(readLines(path), collapse = "\n")

  start_tth <- stringr::str_extract(
    full_text,
    pattern = '(?<=<startPosition>)\\d*\\.\\d*(?=</startPosition>)') %>%
    as.numeric()

  end_tth <- stringr::str_extract(
    full_text,
    pattern = '(?<=<endPosition>)\\d*\\.\\d*(?=</endPosition>)') %>%
    as.numeric()

  counts <-stringr::str_extract(
    full_text,
    pattern = '(?<="counts">).*(?=</(counts|intensities)>)'
  ) %>%
    stringr::str_split(pattern = "\\s") %>%
    unlist() %>%
    as.numeric()

  n_steps <- length(counts)

  raw_xrd_intensity_table <- tibble::tibble(
    tth = seq(
      from = start_tth,
      to = end_tth,
      length.out = n_steps),
    intensity = counts
  )

  # filter to include only the desired range of 2-theta
  filtered_xrd_intensity_table <- raw_xrd_intensity_table %>%
    dplyr::filter(.data$tth >= min_tth,
                  .data$tth <= max_tth)

  if(scaled) {
    filtered_xrd_intensity_table <- filtered_xrd_intensity_table %>%
      dplyr::mutate(
        intensity = .data$intensity / max(filtered_xrd_intensity_table$intensity,
                                    na.rm = TRUE)
      )
  }

  return(filtered_xrd_intensity_table)

}
