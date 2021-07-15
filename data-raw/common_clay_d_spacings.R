## code to prepare `common_clay_d_spacings` dataset goes here

common_clay_d_spacings <- readr::read_csv(
  './data-raw/common_clay_d_spacings.csv',
  col_types = 'cccd',
  na = "-"
)

usethis::use_data(common_clay_d_spacings, overwrite = TRUE)
