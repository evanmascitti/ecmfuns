#' Helper for inserting external figures into an R Markdown document
#'
#' Wraps `knitr::include_graphics()` to easily access my custom directory
#' structure for paper writing'
#'
#' @param stem Character. Basename of figure, without extension.
#' @param type Character. Format of the file. Defaults to **knitr** and **dplyr** logic.
#' @param base Character. Defaults to my usual structure of having a top-level folder for figures, abbreviated `figs/`
#'
#' @export
insert_fig <- function(stem, type = dplyr::if_else(
  knitr::is_latex_output(),
  'pdf',
  'png'),
  base = 'figs/'){

  type <- match.arg(arg = type,
                    choices = c("pdf", "png"),
                    several.ok = FALSE
                    )

  fig_path <- here::here(
    'figs', type, paste0(stem, ".", type)
  )

  knitr::include_graphics(fig_path)


}
