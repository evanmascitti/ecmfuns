my_table <- tibble::tibble(
  a = 1:10,
  b = c(11:17, NA, NA, 20),
  c = sample(letters, 10),
  d = NA
)

my_table %>%
  strip_both()
