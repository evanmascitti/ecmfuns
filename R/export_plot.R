#' Save a plot in a variety of formats with a single call
#'
#' Convenient for keeping plots at the ready for presentations, papers, social media, etc.
#'
#' @param x ggplot object to save. The file name is automatically populated from the object's name.
#' @param dirs directories in which to save the plots, defaults to 'figs' and
#'   'presentations/presentation-figs', i.e. a directory named 'figs' located in
#'   the top level of current working directory and another one specifically for
#'   SVG versions of R plots used for HTML slide sets.
#' @param formats character. Image-based file formats to include. Defaults to 'svg', 'png', and 'pdf'.
#' @param rds Logical. Save also in binary .rds format? (Default `TRUE`; useful
#'   for building R Markdown documents; the plots can be iteratively imported
#'   into a list and easily called with code rather than individual file paths)
#' @param ... Other arguments passed to [`cowplot::save_plot()`]
#'
#' @return Writes files to disk and prints a message if successful
#' @export
#' @importFrom grDevices cairo_pdf svg
#'
#'
export_plot <- function(x, dirs = c('figs', 'presentations/presentation-figs'), formats = c('svg', 'png', 'pdf'), rds = TRUE, ...){


	# create a file stem separated by dashes by taking
	# the object name and substituting

	stem <- substitute(x) %>%
		as.character() %>%
		stringr::str_replace_all("_", "-")


	dirs <- match.arg(dirs, choices = c("figs", "presentations/presentation-figs"), several.ok = T)

	formats <- match.arg(formats, choices = c('svg', 'png', 'PNG', 'pdf', 'JPG'), several.ok = T)

	# browser()

# build paths to image versions of figures

	figs_folder_fig_paths <- here::here("figs", formats, glue::glue("{stem}.{formats}"))

	presentation_folder_svg_fig_path <- here::here("presentations", "presentation-figs", glue::glue("{stem}.svg"))

	presentation_folder_png_fig_path <- here::here("presentations", "presentation-figs", glue::glue("{stem}.png"))

	visual_paths <- unlist(mget(ls(pattern = "_fig_path"))) # (figs_folder_fig_paths, presentation_folder_svg_fig_path)

	# browser()

# write to all image paths


	# pdf first

	# cowplot::save_plot(filename = )



	# browser()

	devices <- tibble::tibble(
	  extension = c('pdf', 'svg', 'png'),
	 # device = list(grDevices::cairo_pdf, 'svg', 'png')
	 device = list('pdf', 'svg', 'png')
	)






	# trying the ragg::agg_png device for now but its arguments
	# are not consistent with ggsave....therefore might need to
	# switch back to default png device or to cairo png

args <- tibble::tibble(
	filename = visual_paths,
	extension = tools::file_ext(.data$filename),
	plot = rep(list(x), times = length(visual_paths))) %>%
  dplyr::left_join(devices) %>%
  dplyr::select(-.data$extension)

purrr::pwalk(args, cowplot::save_plot, ...)

if(sum(file.exists(visual_paths)) == length(visual_paths)){
	cat("Files written to disk: \n")
	cat(visual_paths[file.exists(visual_paths)], sep = "\n\n")
} else{
	warning("One or more files could not be written")
}


# write  to rds format if not FALSE

	if (rds) {
		rds_path <- here::here("figs", "rds", paste0(stem, ".rds"))
		readr::write_rds(x, rds_path)
		cat("\n", rds_path, "\n")
	}



}
