#' Save a plot in a variety of formats with a single call
#'
#' Convenient for keeping plots at the ready for presentations, papers, social media, etc.
#'
#' @param x ggplot object to save. The file name is automatically populated from the object's name.
#' @param dir directory in which to save the plots, defaults to 'figs' i.e. a directory named 'figs' located in the top level of current working directory
#' @param formats character. Image-based file formats to include. Defaults to 'svg', 'png', and 'pdf'.
#' @param rds Logical. Save in binary .rds format? (Default `TRUE`)
#' @param ... Currently not used. Eventually re-factor so other arguments may be passed to [`cowplot::save_plot()`]
#'
#' @return Writes files to disk and prints a message if successful
#' @export
#'
export_plot <- function(x, dir = "figs", formats = c('svg', 'png', 'pdf'), rds = TRUE, ...){

	# browser()
	# create a fil stem separated by dashes by taking
	# the object name and substituting

	stem <- substitute(x) %>%
		as.character() %>%
		str_replace_all("_", "-")



	formats <- match.arg(formats, choices = c('svg', 'png', 'PNG', 'pdf', 'JPG'), several.ok = T)

# build paths to image versions of figures

visual_paths <- paste0(here::here(dir, paste0(stem, ".", formats)))

# write to all image paths

args <- list(
	filename = visual_paths,
	plot = rep(list(x), times = length(visual_paths)))

purrr::pwalk(args, cowplot::save_plot)

# browser()

if(sum(file.exists(visual_paths)) == length(visual_paths)){
	cat("Files written to disk: \n")
	cat(visual_paths, sep = "\n\n")
} else{
	warning("One or more files could not be written")
}


# write  to rds format if not FALSE

	if (rds) {
		rds_path = here::here(dir, paste0(stem, ".rds"))
		readr::write_rds(x, rds_path)
		cat("\n", rds_path, "\n")
	}



}
