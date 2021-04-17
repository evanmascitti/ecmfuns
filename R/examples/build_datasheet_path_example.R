# sensible defaults allow for minimal typing
build_datasheet_path(stem = "my-precious-data")

# or write to tab-delimited file
build_datasheet_path(stem = "my-precious-data", ext = "tsv")

# or make many sheets at once using multiple stems and multiple formats

build_datasheet_path(stem = paste("my-precious-data", 1:3, sep = "-"))

# multiple formats can be created with one call
build_datasheet_path(stem = "my-precious-data", ext = c("csv", "tsv"))


