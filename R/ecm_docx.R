#' Customized word document output
#'
#' @param ... arguments passed to `rmarkdown::word_document()`
#'
#' @export
#'
ecm_docx <- function(...){

  ref_doc <- system.file('rmarkdown', 'templates', 'ecm_word_docx', 'skeleton', 'docx-formatting-template.docx')

  rmarkdown::word_document(reference_docx = ref_doc, ...)

}
