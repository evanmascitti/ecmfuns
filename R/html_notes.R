#' Rmd output format for note-taking. Renders to HTML output.
#'
#' Includes my own boilerplate YAML and chunk options, and a basic CSS file for
#' formatting
#'
#'
#' @return HTML output format function; passes arguments to Pandoc via **knitr**
#'   and **rmarkdown**
#' @export

# This is giving me a hard time....it works fine until I try to add
# the CSS file, and the error messages are making me think that it's a
# problem with the `system.file()` call....I tried to re-produce the
# issue with Yihui's exmample from the R Markdown Definitive Guide
# book - I created files having the same paths as the "quarterly report"
# that he specifies, but I get a similar (though not identical) error message
# about not being able to find the file in the resource path.
# I am going to table this for a while because I just can't waste any more time
# on it even though I want to. I will have to settle for just
# either making the Rmd file with a GUI or by setting the create_dir argument to TRUE
# and then having all those css files floating around which I'm not crazy about.
# One one hand, I guess each document being in its own directory is the best solution because
# it compartmentalizes everything related to that document and plays nicely with the
# R Markdown default tab completion, etc. I don't like the extra nested structure,
# so for now I am going to just avoid having a CSS file associated with


####
# I finally tried setting the mustWork argument inside system.file to TRUE
# and it did fail, which tells me that the css file is not being found
# Loading required package: usethis
#Error in system.file("inst/rmarkdown/supplemental-files/minimal-sans-css.css",  :
 #                      no file found
  #                   Calls: <Anonymous> ... create_output_format -> do.call -> <Anonymous> -> system.file
   #                  Execution halted
                     #
# However I can't figure out why it is not being found.....
# seems like the file path is correct so not sure why this is happening.
# Either way, I need to quit for today.

###
html_notes <- function(...) {

  css_file <- system.file("inst/rmarkdown/supplemental-files/minimal-sans-css.css",
                          package = "ecmfuns", mustWork = TRUE)

 rmarkdown::html_document(#theme = NULL,
                          #pandoc_args = NULL,
                         # includes = NULL,
                           css = css_file,
                          ...)

  }
