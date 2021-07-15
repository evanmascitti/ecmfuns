#' Customized word document output
#'
#' @param number_lines Logical. Whether line numbers should be printed in output document
#' @param ... arguments passed to `rmarkdown::word_document()`
#'
#' @export
#'
ecm_docx <- function(number_lines = TRUE, ...){

  ref_doc_w_line_numbers <- system.file('rmarkdown', 'templates', 'ecm_word_docx', 'skeleton', 'docx-formatting-template.docx', package = 'ecmfuns', mustWork = TRUE)

  ref_doc_NO_line_numbers <- system.file('rmarkdown', 'templates', 'ecm_word_docx', 'skeleton', 'docx-formatting-template-no-line-numbers.docx', package = 'ecmfuns', mustWork = TRUE)

  rmarkdown::word_document(
    reference_docx = ifelse(
      number_lines,
      ref_doc_w_line_numbers,
      ref_doc_NO_line_numbers
    ),
      ...)

}
