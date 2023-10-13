get_kulaInfo <- function(x,
                         palette = NULL,
                         skipMid = NULL,
                         reverse = FALSE,
                         tickCount = 12) {
  #' Automate colour ranges for plotting
  #'
  #' @description We often want to automate plots of different variables, or for
  #'   different periods etc. This functions helps with automating the colours
  #'   by returning a list of useful parts that can be fed into other functions
  #'   (e.g. [kulaK()], [add_kulaBar()]).
  #'
  #' @param x The data to calculate the kulaInfo for. Can be a vector, a matrix,
  #'   a list, or SpatRaster (see [terra::rast()]).
  #' @param palette "string": Overwrite the default palettes ("BuRd" for
  #'   diverging values, "lajolla" for ascending sequential values, and "devon"
  #'   for descending sequential values. Use [list_kula_palettes()] for a list
  #'   of accepted values.
  #' @param skipMid numeric: Should more intense colours be used in a diverging
  #'   colour scheme? See [kulaK()] for an explanation.
  #' @param reverse logical: Should the colour palette be reversed?
  #' @param tickCount numeric: The ideal number of ticks, fed directly into the
  #'   [base::pretty()] function; it attempts to set this number of ticks, but
  #'   may choose more or less if there are prettier alternatives.
  #'
  #' @returns a list, containing:
  #'
  #'     * zKulas         the colours
  #'     * zRange         the minimum & maximum values
  #'     * zIncrement     the increment between steps
  #'     * zPositives     how many values are above 0?
  #'     * zNegatives     how many values are below 0?
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  # Get the range
  if ("SpatRaster" %in% methods::is(x)) {
    x <- as.matrix(x)
  } else {
    x <- unlist(x)
  }
  xRange <- range(x, na.rm = TRUE)

  # Define basic values --------------------------------------------------------
  zTicks <- base::pretty(xRange, n = tickCount)
  zIncas <- zTicks[2] - zTicks[1]
  zNegat <- length(zTicks[zTicks < 0])
  zPosit <- length(zTicks[zTicks > 0])
  zRange <- range(zTicks)

  # Define colours -------------------------------------------------------------
  if (zNegat > 0 & zPosit > 0) {
    zHalfway <- max(zNegat, zPosit)
    palette  <- set_if_null(palette, "BuRd")
    zKulas   <- kulaK(palette, count = zHalfway * 2,
                      include = c(zNegat, zPosit),
                      skipMid = skipMid, reverse = reverse)
  } else {
    if (zPosit > 0) {
      palette <- set_if_null(palette, "lajolla") # default increasing
    } else if (zNegat > 0) {
      palette <- set_if_null(palette, "devon") # default decreasing
    }
    zKulas <- kulaK(palette, count = length(zTicks) - 1, reverse = reverse)
  }

  # Return data
  zInfo <- list("zKulas" = zKulas,
                "zRange" = zRange,
                "zIncrement" = zIncas,
                "zNegatives" = zNegat,
                "zPositives" = zPosit,
                "zTicks" = zTicks)
  return(zInfo)
}

# dec <- matrix(-5:19, nrow = 5)
# tt  <- set_kulas(dec, palette = "sunset", skipMid = 2)
# par(mfrow = c(1, 2))
# image(dec)
# image(dec, col = tt$zKula)
