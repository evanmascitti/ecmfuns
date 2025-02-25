#' Personal preferences for a quick scatterplot
#'
#' Based off Claus Wilke's [`cowplot::theme_cowplot()`] and [**ggtext**](https://wilkelab.org/ggtext/articles/introduction.html) package
#'
#' @return extensible theme function
#' @export
#' @examples
#' library(ggplot2)
#' library(ecmfuns)
#' ggplot(mtcars, aes(disp, mpg, color = cyl))+
#'  geom_point()+
#'  theme_ecm_scatter()
theme_ecm_scatter <- function() {
  error_message <- "`theme_ecm_scatter()` requires the following packages:
                      ggplot2, cowplot, ggtext.
                      Please install these."

  if(!requireNamespace("ggplot2", quietly = T)){
    stop(error_message)
  }
  if(!requireNamespace("ggtext", quietly = T)){
    stop(error_message)
  }
  if(!requireNamespace("cowplot", quietly = T)){
    stop(error_message)
  }


    cowplot::theme_cowplot()  +
      cowplot::background_grid(color.minor = 'grey90', size.minor = 0.25)+
      ggplot2::theme(
        legend.position = c(1, 1),
        legend.justification = c(1, 1),
        plot.title = ggtext::element_markdown(hjust = 0.5),
        legend.title = ggtext::element_markdown(size = 12,
                                                margin = ggplot2::margin(2, 0, 0, 0, "mm")),
        legend.text = ggtext::element_markdown(
          size = 10,
          margin = ggplot2::margin(0, 3, 0, 0, "mm")
        ),
        legend.box.background = ggplot2::element_rect(fill = "white", color = 'grey75'),
        legend.box.margin = ggplot2::margin(0, 3, 2, 3, "pt"),
        legend.position = 'inside',
        legend.position.inside = c(1,1),
        legend.justification = c(1,1),
        legend.background = element_blank(),
      )
  }
