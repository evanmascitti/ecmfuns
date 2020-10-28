## code to prepare `green_grass` dataset goes here

green_grass <- imager::load.image('data-raw/green_grass.png')

usethis::use_data(green_grass, overwrite = TRUE)
