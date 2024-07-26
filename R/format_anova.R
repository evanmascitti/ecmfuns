#' format an anova table output from `car::Anova()`
#'
#' Often make multiple tables at once by building a tibble with columns `x` and `caption`
#' through other data wrangling exercises
#'
#' @param x ANOVA table output from `car::Anova()`
#' @param nm table caption
#'
#' @return silently writes slides to disk
format_anova <- function(x, caption){

  # browser()

  n_terms <- 1:(length(x$`Pr(>F)`) -1)

  significance_mask <- x$`Pr(>F)`[n_terms] < 0.05
  significant_rows <- rownames(x)[n_terms][significance_mask]


  term_names <- rownames(x)


  # rename as fit

  # %>%
  #   stringr::str_replace(
  #     'stitches_per_m2', 'Stitch rate') %>%
  #   stringr::str_replace(
  #     'formatted_species', 'Species') %>%
  #   stringr::str_replace(
  #     ':', ' x ')

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
                    ~stringr::str_replace(., '^NA$', '-')))

  return(formatted_tbl)

}
