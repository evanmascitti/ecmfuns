#' @title Compute estimated max soil toughness from Atterberg limits
#'
#' @description \loadmathjax Takes a data frame  and
#'   calculates the estimated maximum toughness (in kj m^-3) from an empirical
#'   equation published by [Moreno-Marato and Alonso-Azcarate,
#'   2018](https://www.sciencedirect.com/science/article/pii/S0169131718301698).
#'   Re-arranging their equation yields: \mjsdeqn{\mathrm{T_{max(\frac{kJ}{m^3})}=\frac{\frac{PI}{LL}-0.3397}{0.0077}}}
#'
#'
#' @param df A data frame containing (at least) columns named `PI` and `LL`
#'
#' @return original data frame with a new column titled `mormar_toughness_est`
#' @export
#'
add_mormar_toughness_est <- function(df){

  new_df <- dplyr::mutate(df, mormar_toughness_est = ((.data$PI/.data$LL) - 0.3397) / 0.0077 )
  return(new_df)
}
utils::globalVariables(".data")
