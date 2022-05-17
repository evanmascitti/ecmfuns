#' Shortcut to set PSA equipment
#'
#' Sets all relevant global options for running a particle size analysis using ASI 468 glassware, tins, etc.
#'
#' @return Sets options silently
#'
#' @export
#'
set_psa_options <- function(){

  options(
    soiltestr.hydrometer_dims = asi468::astm_152H_hydrometers,
    soiltestr.bouyoucos_cylinder_dims = asi468::bouyoucos_cylinders,
    soiltestr.beaker_tares = asi468::psa_beaker_tares,
    soiltestr.tin_tares = asi468::tin_tares
  )

}
