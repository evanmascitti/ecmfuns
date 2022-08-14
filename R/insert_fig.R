#' Helper for inserting external figures into an R Markdown document
#'
#' Wraps `knitr::include_graphics()` to easily access my custom directory
#' structure for paper writing'
#'
#' @param stem Character. Basename of figure, without extension.
#' @param type Character. Format of the file. Defaults to **knitr** and **dplyr** logic.
#' @param base Character. Defaults to my usual structure of having a top-level folder for figures, abbreviated `figures/`, but could also be 'figs/'
#'
#' @export
insert_fig <- function(stem, type = dplyr::if_else(
  knitr::is_latex_output(),
  'pdf',
  'png'),
  base = c('figures')){

  type <- match.arg(arg = type,
                    choices = c("pdf", "png"),
                    several.ok = FALSE
                    )

  base <- match.arg(arg = base,
                    choices = c('figures/', 'figs/'),
                    several.ok = FALSE
  )

  fig_path <- fs::path(
    base, type, paste0(stem, ".", type)
  )


  # if using word output, need to preserve the native aspect ratio
  # and dynamically reference it to the image dimensions
  # see https://stackoverflow.com/questions/70312388/how-to-import-a-figure-as-its-original-height-width-ratio for this solution

  if(!knitr::is_latex_output() & !knitr::is_html_output()){

    my_pic <- imager::load.image(fig_path)
    asp_rat <- dim(my_pic)[2]/dim(my_pic)[1] #find our aspect ratio

    knitr::opts_chunk$set(fig.asp = asp_rat)
    knitr::include_graphics(fig_path)
  } else{
    knitr::include_graphics(fig_path)
  }

  }
