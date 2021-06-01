# this is the code I used to get the css sheet started

tibble::tibble(
  name = c('dodgerblue4', 'black', 'coral4'),
  hex = gplots::col2hex(name)
)

xaringanthemer::style_xaringan(text_color = "#041E42" , header_color = "#041E42",
               link_color = '#104E8B', title_slide_background_color = "#041E42", text_font_size = '1.2rem', '#000000', text_font_google = google_font(family = 'Roboto'), blockquote_left_border_color = '#8B3E2F', outfile = 'inst/rmarkdown/templates/empty_xaringan_slides/skeleton/ecm-16x9-theme.css')


