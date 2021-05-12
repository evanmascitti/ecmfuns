devices <- tibble(
  extension = c('pdf', 'svg', 'png'),
  device = list(cairo_pdf, svglite::svglite, ragg::agg_png)
)

# trying the ragg::agg_png device for now but its arguments
# are not consistent with ggsave....therefore might need to
# switch back to default png device or to cairo png

args <- tibble(
  filename = visual_paths,
  extension = tools::file_ext(filename),
  plot = rep(list(x), times = length(visual_paths))) %>%
  dplyr::left_join(devices) %>%
  dplyr::select(-extension)
