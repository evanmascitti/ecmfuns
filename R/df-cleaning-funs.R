#' Remove empty rows
#'
#' Returns a new data frame with **rows** containing purely `NA` values removed
#'
#' @param df Tibble (or data frame)
#'
#' @return Tibble (or data frame)
#'
#' @export
#'
row_clean <- function(df){

  if(!requireNamespace("tidyselect", quietly = TRUE)){
    stop("This function requires the tidyselect package; please install from CRAN or GitHub")
  }

  df %>%
    dplyr::filter(dplyr::if_any(.fns = ~!is.na(.)))
}

#' Remove empty columns
#'
#'#' Returns a new data frame with **columns** containing purely `NA` values removed
#'
#' @inheritParams row_clean
#'
#' @example R/examples/df_clean_example.R
#'
#' @export
#'
col_clean <- function(df){

  if(!requireNamespace("tidyselect", quietly = TRUE)){
    stop("This function requires the tidyselect package; please install from CRAN or GitHub")
  }

  # df %>%
  #   dplyr::select_if(tidyselect::vars_select_helpers$where(~!all(is.na(.))))

  # Apparently this is the more recommended version but I can't
  # get R to find the where function. I thought maybe it would associate
  # it with the select call but IDK, this isn't working so I am going to
  # just use it in the list form above

  # UPDATE:

  # USING THE TRIPLE COLON OPERATOR WORKS!! It allows you to access non-exported
  # functions from a package....this is considered a generally poor practice,
  # according to official R documentation, but it is what the tidyverse
  # team is recommending for now.

  df %>%
    dplyr::select_if(tidyselect:::where(~!all(is.na(.))))


}


#' Remove both empty rows and columns; helper called by df_clean based on user input
#'
#' @inheritParams col_clean
#'
both_clean <- function(df){

 df %>%
    col_clean() %>%
    row_clean()
}


#' Remove columns or rows containing only NA values
#'
#' @param df Tibble (or data frame)
#' @param type Character (length 1). Whether to remove empty rows, columns, or both.
#'
#' @return Tibble (or data frame) with any empty columns/rows removed
#'
#' @export
#'
df_clean <- function(df, type = c("both", "rows", "cols")){

  type <- match.arg(type)

  clean_df <- switch (type,
    'both' = both_clean(df = df),
    'rows' = row_clean(df = df ),
    'cols' = col_clean(df = df )
  )

  return(clean_df)

}


utils::globalVariables("where")
