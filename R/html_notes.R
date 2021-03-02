#' Rmd output format for note-taking. Renders to HTML output.
#'
#' Includes my own boilerplate YAML and chunk options, and a basic CSS file for
#' formatting
#'
#'
#' @return HTML output format function; passes arguments to Pandoc via **knitr**
#'   and **rmarkdown**
#' @export
#'
html_notes <- function(...) {

  css_file <- system.file("inst/rmarkdown/supplemental-files/minimal-sans-css.css",
                          package = "ecmfuns")

 rmarkdown::html_document(theme = NULL,
                          pandoc_args = NULL,
                          #includes = NULL,
                          css = css_file,
                          ...)

  }
