## code to prepare `hex_codes` dataset goes here

hex_codes <- readr::read_csv(
  'data-raw/useful-hex-color-codes.csv',
  show_col_types = F
)


usethis::use_data(hex_codes, overwrite = TRUE)
