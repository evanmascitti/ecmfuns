#' Save a plot usingpowerpoint-compatible dimensions
#'
#' @param plot ggplot object
#' @param filename Full path to save
#' @param aspect_ratio Height / width
#' @param size_multiplier Value < 1 = larger text
#' @param dpi For raster graphics; defaults to 600
#'
#' @return sliently writes file to disk
#' @export
#'
#' @importFrom ggplot2 ggsave
#'
gg_ppt_save <- function(plot, filename, aspect_ratio = c('16x9-w-title', 'two-content',  '16x9-full-page'), size_multiplier = 0.8, dpi = 600){ # , height, width, ){

  #browser()

  aspect_ratio <- match.arg(
    arg = aspect_ratio,
    choices = c('16x9-w-title', 'two-content',  '16x9-full-page'),
    several.ok = F
  )


  if(aspect_ratio == 'two-content'){

    height <- 6.09
    width <- 5.92

    if(!is.null(plot$labels$title)){
      if(nchar(plot$labels$title) > 60){
      warning('Too many characters in title; text may be cut off')
      }
    }
  }

    if(aspect_ratio == '16x9-full-page'){

    height <- 6.09
    width <- 5.92

  }

  if(aspect_ratio == '16x9-w-title'){

    height <- 7.5
    width <- 13.33

  }

  height <- height * size_multiplier
  width <- width * size_multiplier


  ggsave(
    plot = plot,
    filename = filename,
    height = height,
    width = width,
    dpi = dpi
  )

}
