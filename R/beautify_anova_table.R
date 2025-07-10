
# formatting for anova tables

#' Format the output of a model
#'
#' @param x output of `car::Anova()`
#'
#' @return tibble with better column names and formatted cell values
#' @export
#'
beautify_anova_table <- function(x){

  # browser()

  n_terms <- 1:(length(x$`Pr(>F)`) -1)

  significance_mask <- x$`Pr(>F)`[n_terms] < 0.05
  significant_rows <- rownames(x)[n_terms][significance_mask]


  ####### ---------------------

  # formatting of the anova tables into something that
  # looks better


  term_names <- stringr::str_replace_all(stringr::str_to_sentence(rownames(x)), ':', ' x ')

  # browser()

  formatted_tbl <- x %>%
    as.data.frame() %>%
    dplyr::mutate(Term = term_names) %>%
    dplyr::rename(`Deg. Fr.` = Df,
                  `F` = `F value`) %>%
    dplyr::mutate(
      `F` = paste(round(`F`, digits = 1)),
      # `F` = paste(`F`),
      significance_code = dplyr::case_when(
        `Pr(>F)` < 0.001 ~ '***',
        `Pr(>F)` < 0.01 ~ '**',
        `Pr(>F)` < 0.05 ~ '*',
        TRUE ~ '' ),
      p_value = dplyr::case_when(
        `Pr(>F)` < 0.001 ~ '<0.001',
        `Pr(>F)` < 0.01 ~ as.character(signif(`Pr(>F)`, digits = 2)),
        `Pr(>F)` < 0.05 ~ as.character(signif(`Pr(>F)`, digits = 2)),
        # `Pr(>F)` < 0.001 ~ '<0.001',
        # `Pr(>F)` < 0.01 ~ format(`Pr(>F)`, digits = 2, drop0trailing = FALSE, scientific = FALSE),
        # `Pr(>F)` < 0.05 ~ format(`Pr(>F)`, digits = 2, drop0trailing = FALSE, scientific = FALSE),
        TRUE ~ as.character(round(`Pr(>F)`, digits = 3))),
      `p` = paste0(p_value, significance_code)) %>%
    dplyr::select(Term, `Deg. Fr.`, `F`, `p`) %>%
    dplyr::mutate(
      dplyr::across(dplyr::everything(),
                    ~stringr::str_replace(., '^NA$', '-'))) %>%
    tibble::as_tibble()

  return(formatted_tbl)

}

