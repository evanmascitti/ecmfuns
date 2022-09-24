#' helper for saving figures with GNU Make
#'
#'
#' Export a **ggplot2** object as a pdf and a png
#'
#' @details Also saves in `./presentations/presentation-figs` for convenient use with **xaringan** HTML slide shows
#'
#' @param plot a **ggplot2** object
#' @param pdf_path path to which plot should be saved; if `NULL`, will call `commandArgs(trailingOnly = TRUE)[[1]]` to accept command line argument
#' @param ht height in inches, defaults to 9*0.4=3.6
#' @param wdth width in inches, defaults to 16*0.4=6.4
#' @param ... other arguments passed to `ggsave`
#' @importFrom rlang `%||%`
#'
#' @export
#'
#' @return Silently writes files to disk and prints message
#'
save_fig <- function(plot, pdf_path = NULL, ht = NULL, wdth = NULL, ...){

  suppressPackageStartupMessages({library(rlang)})

  if(!interactive()){


    if(is.null(pdf_path)){
      pdf_path <- commandArgs(trailingOnly = TRUE)[[1]]
    }
    png_path <- stringr::str_replace_all(pdf_path, "pdf", "png")
    presentation_figs_png_path <- here::here(
      "presentations", "presentation-figures", basename(png_path)
    )


    all_output_file_paths <- c(pdf_path, png_path, presentation_figs_png_path)

    message("Building figures: \n")
    message(all_output_file_paths, sep = "\n")
    message("- - - - - - - - - - - - - - - - - - - - - - - - -", "\n\n")


    # some defaults for the height and width if they are not provided
    ht <- ht %||% 9*0.4
    wdth <-  wdth %||% 16*0.4

    purrr::walk(
      .x = c(pdf_path, png_path, presentation_figs_png_path),
      .f = ggplot2::ggsave,
      plot = plot,
      height = ht,
      width = wdth,
      ...
    )
  } else{
    print(plot)
    warning("Plot will not be saved during an interactive R session. Use Make to write plots to disk.", call. = F)
  }

}
