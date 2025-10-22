#' Slight modifications to built-in themes
#'
#' Based on `theme_bw()` from **ggplot2**
#'
#' @return extensible theme function
#' @export
#' @importFrom ggplot2 `%+replace%`
#' @examples
#' library(ggplot2)
#' library(ecmfuns)
#' ggplot(mtcars, aes(disp, mpg, color = cyl))+
#'  geom_point()+
#'  theme_ecm_bw()
theme_ecm_horizontal_dots <- function() {

  if(!requireNamespace("ggplot2", quietly = T)){
    stop("This function requires the ggplot2 package - please install from CRAN.", call. = FALSE)
  }


  ggplot2::theme_bw() %+replace%
    ggplot2::theme(
      panel.grid = ggplot2::element_line(linewidth  = 0.25, color = 'grey95'),
      # strip.background = ggplot2::element_rect(fill = 'transparent'),
      strip.background = ggplot2::element_blank(),
      #plot.background = element_rect(color = 'grey50'),
      plot.background = element_rect(fill = 'white', color = 'transparent'),
      panel.background = element_blank(),
      panel.border = element_blank(),
      axis.text.x = element_text(),
      axis.line.x = element_line(),
      axis.ticks.x = element_line(),
      axis.title.y = element_blank(),
      axis.line.y = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks.y = element_blank(),
      legend.position = 'inside',
      legend.position.inside = c(1,1),
      legend.justification = c(1,1),
      legend.background = element_blank(),
      # strip.text = ggplot2::element_text(face = 'bold')
      )

  }
