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
theme_ecm_bw <- function() {

  if(!requireNamespace("ggplot2", quietly = T)){
    stop("This function requires the ggplot2 package - please install from CRAN.", call. = FALSE)
  }


  ggplot2::theme_bw() %+replace%
    ggplot2::theme(panel.grid = ggplot2::element_line(size  = 0.25, color = 'grey95'))

  }
