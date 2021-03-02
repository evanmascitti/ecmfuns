#' test function from Yihui
#'
#' @param toc whether to use a table of contens
#'
#' @return
#' @export
#'
quarterly_report = function(toc = TRUE) {
  # locations of resource files in the package
  pkg_resource = function(...) {
   system.file(..., package = "ecmfuns")
  }

  css    = pkg_resource("reports/styles.css")
  header = pkg_resource("reports/quarterly/header.html")

  # call the base html_document function
  rmarkdown::html_document(
    toc = toc, fig_width = 6.5, fig_height = 4,
    theme = NULL, css = css,
    includes = rmarkdown::includes(before_body = header)
  )
}
