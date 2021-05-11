#' Rmd output format for note-taking. Renders to HTML output.
#'
#' Includes my own boilerplate YAML and chunk options, and a basic CSS file for
#' formatting
#' @param css arguments passed to [`rmarkdown::html_document()`]
#' @param toc arguments passed to [`rmarkdown::html_document()`]
#' @param number_sections arguments passed to [`rmarkdown::html_document()`]
#' @param highlight_style arguments passed to [`rmarkdown::html_document()`]
#' @param theme arguments passed to [`rmarkdown::html_document()`]
#' @param ... arguments passed to [`rmarkdown::html_document()`]
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

#######


# I fixed it !!!!!!
# Indeed the problem was that the function could not find the CSS file, because I was not
# interpreting the behavior of the system.file() function correctly.....the documentation
# for the base R version of this function is not very good (shocking, I know). You can't specify the
# entire file path - you are supposed to use individual character vectors for each sub-directory,
# and NOT use the "inst" sub-directory since when the packages is built all the files in
# inst are automatically copied to the top-level directory. I finally figured it out after reading part
# of the chapter on external files in Hadley's R Packages book. And it works!!!

# Probably this is also why there is no default CSS file to be found in  a xaringan presentation.....
# it is installed in the package itself and called by the moon_reader function, thus the
# user never actually sees it.

# The last hurdle I had to conquer was how to allow the user to specify additional
# CSS sheets and I did this by setting the default CSS to null, then inside the function rea-assigning
# the CSS to use as a new local variable with the system.file() call.....but this is conditioned
# on the user not supplying any CSS files. If the user DOEs specify a CSS file in the YAML,
# the css_files variable is over-ridden with the built-in file getting the least preference.


###
html_notes <- function(css = NULL,
                       toc = TRUE,
                       number_sections = FALSE,
                       highlight_style =  "github",
                       theme = NULL,
                       ...) {

  minimal_notes_css <- system.file("rmarkdown", "supplemental-files", "minimal-sans-css.css",
                                   package = "ecmfuns", mustWork = TRUE)

  if(is.null(css)){
  css_files <- minimal_notes_css
  } else{
    css_files <- c(minimal_notes_css, css)
  }

  bookdown::html_document2(css = css_files,
                           toc = toc,
                           number_sections = number_sections,
                           highlight_style =  highlight_style,
                           theme = theme,
                          ...)

  }
