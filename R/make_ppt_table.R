#' Save a formatted ANOVA table to a powerpoint slide
#'
#' @param x formatted data frame, typically returned by `format_anova()`
#' @param template path to .pptx file, possibly containing a custom theme
#' @param output path to write new slides (should end in '.pptx')
#'
#' @return silently writes file to disk
#' @export
#'
make_ppt_table <- function(x, template, output){


  message('This function is under development and not yet
  operational - see the notes in the source file')
  # need some control flow here to not over-write the old file
  # since this is probably used iteratively.

#   pres_w_slides <- read_pptx(path = template)
#
#
#   formatted_flextable <- x %>%
#     flextable() %>%
#     bold(i = significant_rows, j = c('Term', 'p')) %>%
#     color(i = significant_rows,
#           j = c('Term', 'p'),
#           color = 'darkred')
#   #
#   #
#   new_pres <- add_slide(pres_w_slides, layout = 'Title with table', master = 'Biocore') %>%
#     # ph_with(value = x, location =ph_location_template()) %>%
#     # ph_with(value = names(x)[1], location = ph_location_type(type = 'title'))
#     ph_with(value = formatted_flextable, location = ph_location(left = 0.67, top = 1,
#                                                                 # height = 4.25, width = 12,
#                                                                 use_loc_size = FALSE)) %>%
#     # ph_with(value = names(x)[1], location = ph_location_type(type = 'title'))
#     ph_with(value = caption, location = ph_location_type(type = 'title'), ph_center = TRUE)
#
#
 }
