get_zRange <- function(x, centred = FALSE, nDesired = 12) {
  #' Returns values for the range used in image or terra::plot()
  #'
  #' @description Often we want to compare across multiple plots, and using the
  #'   same range of values is necessary. This functions computes useful values
  #'   for the min and max values. By default (centred = FALSE), it returns
  #'   values spreading from the lowest to the highest values (adjusted to be
  #'   pretty). However, we can set a central value (e.g. centred = 0), which
  #'   can be useful when the values diverge and we want the above and below
  #'   ranges to match in magnitude.
  #'
  #' @param x The input data; use c() for multiple SpatRasters.
  #' @param centred numeric: Should the zRange be centred (i.e. equidistant) to
  #'   a specific value?
  #' @param nDesired numeric: How may divisions would be ideal? It is not
  #'   guaranteed. See pretty.
  #'
  #' @examples
  #'   dec <- matrix(-5:19, nrow = 5)
  #'   jan <- matrix(-10:14, nrow = 5)
  #'
  #'   get_zRange(dec)
  #'   get_zRange(c(dec, jan), centred = 0)
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  if ("SpatRaster" %in% is(x)) {
    zRange <- range(terra::values(x), na.rm = TRUE) |>
      pretty(n = nDesired) |> range()
  } else {
    zRange <- range(x, na.rm = TRUE) |>
      pretty(n = nDesired) |> range()
  }

  if (!isFALSE(centred)) {
    zRange <- abs(zRange - centred) |> max()
    zRange <- c(centred  - zRange, centred + zRange)
  }

  return(zRange)
}
