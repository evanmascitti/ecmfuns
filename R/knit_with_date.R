#' @title Custom Knit function for RStudio, re: Yihui Xie
#'
#' @description Adds date the file was compiled to the file name. See https://bookdown.org/yihui/rmarkdown-cookbook/custom-knit.html
#' @param input the input file path
#' @param ... other arguments passed to rmarkdown::render()
#' @export
knit_with_date <- function(input, ...) {
  rmarkdown::render(
    input,
    output_file = paste0(
      xfun::sans_ext(input), '_', Sys.Date()
    ),
    envir = globalenv()
  )
}
