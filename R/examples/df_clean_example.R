# Create a table with two empty rows and one empty column
messy_table <- tibble::tibble(
  a = c(1:5, NA, 7:8, NA, 10),
  b = c(11:15, NA_character_, 17:18, NA_character_, 20),
  c = NA,
  d = c(sample(letters, 5), NA, "p", "j", NA, "Q")
)

# columns only; leave rows
col_clean(messy_table)

# rows only; leave columns
row_clean(messy_table)

# rows and columns
df_clean(messy_table)
