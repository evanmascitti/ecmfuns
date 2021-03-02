#' Create a new Rmd document for note-taking purposes
#'
#' Includes with my own boilperplate YAML and chunk options and uses the custom
#' output format function [`html_notes()`], which uses its own basic CSS styles
#'
#' @param file path to save the new presentation
#' @param open whether to open the file in the R Studio IDE
#' @return creates file and (if specified) opens in R Studio IDE
#' @export

new_html_notes <- function(file, open = FALSE){

  if (!grepl(pattern = "\\.rmd$", x = file, ignore.case = T ) ) {
    file <-paste0(file, '.Rmd')
  }

  rmarkdown::draft(file = file,
                   template = "html_notes",
                   package = "ecmfuns",
                   create_dir = FALSE,
                   edit = FALSE
  )

  if(open) {
    new_file_path <- list.files(path = ".",
                                pattern = paste0(stringr::str_remove(file, "\\.Rmd$"),
                                                 "/", file), full.names = T)
    file.show(new_file_path)
  }

}

