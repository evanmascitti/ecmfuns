#' Remove empty rows
#'
#' @param df a data frame
#'
#' @return a data frame
strip_empty_rows <- function(df){
  df %>%
    dplyr::filter(dplyr::if_all(.fns = ~!is.na(.)))
}

#' Remove empty columns
#'
#' @inheritParams strip_empty_rows
#'

# @example inst/examples/strip_empty_exmaple.R

strip_empty_cols <- function(df){
  df %>%
    dplyr::select(tidyselect::where(~!all(is.na(.))))
}


#' Remove both empty rows and columns
#'
#' @inheritParams strip_empty_rows
#'
strip_both <- function(df){
  df %>%
    strip_empty_cols() %>%
    strip_empty_rows()
}


#' Remove columns or rows containing only NA values
#'
#' @param df Data frame.
#' @param type Character (length 1). Whether to remove empty rows, columns, or both.
#'
#' @return Data frame with any empty columns/rows removed
#'
strip_empty <- function(df, type = c("both", "rows", "cols")){

  type <- match.arg(which)

  clean_df <- switch (type,
    'both' = strip_both(),
    'rows' = strip_empty_rows(),
    'cols' = strip_empty_cols()
  )

  return(clean_df)


}
