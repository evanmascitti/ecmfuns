#' Create a new set of **xaringan** slides with my own options and boilerplate
#'
#' @param file path to save the new presentation
#' @param open whether to open the file in the R Studio IDE
#' @return creates file and (if specified) opens in R Studio IDE
#' @export

new_ecm_xaringan <- function(file, open = FALSE){

if (!grepl(pattern = "\\.rmd$", x = file, ignore.case = T ) ) {
    file <-paste0(file, '.Rmd')
  }

  rmarkdown::draft(file = file,
                   template = "empty_xaringan_slides",
                   package = "ecmfuns",
                   create_dir = F,
                   edit = FALSE
                  )

  if(open) {
    new_file_path <- list.files(path = ".",
                                pattern = paste0(stringr::str_remove(file, "\\.Rmd$"),
                                   "/", file), full.names = T)
    utils::file.edit(new_file_path)
  }

}

