## code to prepare `time_abbs` dataset goes here

library(tidyverse)

time_abbs <- read_csv("inst/ext-data/R-formatting-abbreviations.csv",
                 na = "") %>%
  arrange(id) %>%
  select(-id)

usethis::use_data(time_abbs, overwrite = TRUE)
