convert_bin_percent_to_percent_passing <- function(x){

  if(all(x$percent_in_bin > 1)){
    warning('Encountered `percent_in_bin` values >1; converting to decimal form instead of %')
    x$percent_in_bin <- 0.01*x$percent_in_bin
  }


  x_converted <- x %>%
    dplyr::group_by(sample_name) %>%
    dplyr::mutate(
      percent_retained = cumsum(percent_in_bin),
      percent_passing = 1 - percent_retained
    )


  return(x_converted)


}
