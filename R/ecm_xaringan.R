#' Thin wrapper around `xaringan::moon_reader()`
#'
#'
#' A custom output format for HTML presentations
#'
#' @param ratio Character. Aspect ratio of slides, specified as "width:height"
#' @param seal Logical. Auto-generate title slide?
#' @param ... Other arguments passed to `xaringan::moon_reader()`
#'
#' @return Renders HTML slide show
#' @export
#'
ecm_xaringan <- function(ratio = "16:9", seal = TRUE, ...){

  default_css_files <- c("default",
                         "style.css")


  my_css_file <- system.file(
                   'rmarkdown', 'templates',
                   'empty_xaringan_slides',
                   'skeleton', 'ecm-16x9-theme.css', mustWork = TRUE,
    package = 'ecmfuns'
  )

  # xaringan::moon_reader(
  #   css = my_css_file,
  #                       nature = list(ratio = ratio,
  #                                     highlightLines = TRUE,
  #                                     countIncrementalSlides = FALSE),
  #                       ...)


  # can't get it to use the css file. The call to system.file is working,
  # but the css is not gettning used. Frustrating. Going back to copying the file
  # when the Rmd is created.


  xaringan::moon_reader(
    nature = list(ratio = ratio,
                  highlightLines = TRUE,
                  countIncrementalSlides = FALSE),
    ...)

}
