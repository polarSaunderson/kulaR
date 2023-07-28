get_kulaInfo <- function(x, palette = NULL, skipMid = NULL, tickCount = 12) {
  #' Automate colour ranges for plotting
  #'
  #' @description We often want to automate plots of different variables, or for
  #'   different periods etc. This functions helps with automating the colours
  #'   by returning a list of useful parts that can be fed into other functions
  #'   (e.g. `kulaK()`, `add_kulaBar()`).
  #'
  #' @param x The data to calculate the kulaInfo for. Can be a vector, a matrix,
  #'   a list, or SpatRaster (requires the
  #'   [terra](https://cran.r-project.org/web/packages/terra/terra.pdf)
  #'   package).
  #' @param palette "string": Overwrite the default palettes ("BuRd" for
  #'   diverging values, "lajolla" for ascending sequential values, and "devon"
  #'   for descending sequential values. Use `list_kula_palettes()` for a list
  #'   of accepted values.
  #' @param skipMid numeric: Should more intense colours be used? See `kulaK()`
  #'   for an explanation.
  #' @param tickCount numeric: The ideal number of ticks, fed directly into the
  #'   `pretty()` function; it attempts to set this number of ticks, but may
  #'   choose more or less if there are prettier alternatives.
  #'
  #' @returns a list, containing:
  #'   * zKula          the colour palette
  #'   * zRange         the minimum & maximum values
  #'   * zIncrements    the increment between steps
  #'   * zPositives     how many values are above 0?
  #'   * zNegatives     how many values are below 0?
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  # Get base range
  if ("SpatRaster" %in% is(x)) {
    zRange <- range(terra::values(x), na.rm = TRUE)
  } else if ("list" %in% is(x)) {
    zRange <- NA
    for (ii in seq_along(x)) {
      zRange <- range(c(zRange, get_zRange(x[[ii]])), na.rm = TRUE)
    }
  } else if ("numeric" %in% is(x) | "matrix" %in% is(x)) {
    zRange <- range(x, na.rm = TRUE)
  }

  # Define basic values --------------------------------------------------------
  zTicks      <- pretty(zRange, n = tickCount)
  zIncrements <- zTicks[2] - zTicks[1]
  zNegatives  <- length(zTicks[zTicks < 0])
  zPositives  <- length(zTicks[zTicks > 0])
  zRange      <- range(zTicks)

  # However, if it is diverging, we must diverge around 0  -.-.-.-.-.-.-.-.-.-.-
  if (zNegatives > 0 & zPositives > 0) {
    # If it doesn't line up nicely, nudge the min and max outwards
    negOffset <- ((0 + (zRange[1]) * -1) %% zIncrements) * -1
    posOffset <- (0 + zRange[2]) %% zIncrements
    if (negOffset != 0) {
      zRange[1] <- zRange[1] - negOffset
    }
    if (posOffset != 0) {
      zRange[2] <- zRange[2] + posOffset
    }

    # Set values based on new range
    zTicks      <- pretty(zRange, n = 12)
    zIncrements <- zTicks[2] - zTicks[1]
    zNegatives  <- length(zTicks[zTicks < 0])
    zPositives  <- length(zTicks[zTicks > 0])
    zRange      <- range(zTicks)
  }

  # Define colours -------------------------------------------------------------
  if (zNegatives > 0 & zPositives > 0) {
    zHalf   <- max(zNegatives, zPositives)
    palette <- domR::set_if_null(palette, "BuRd")
    zKula   <- kulaK(palette, count = zHalf * 2,
                     include = c(zNegatives, zPositives),
                     skipMid = skipMid)
  } else {
    if (zPositives > 0) {
      palette <- domR::set_if_null(palette, "lajolla")
    } else if (zNegatives > 0) {
      palette <- domR::set_if_null(palette, "devon")
    }
    zKula   <- kulaK(palette, count = length(zTicks) - 1)
  }

  return(list("zKula"       = zKula,
              "zRange"      = zRange,
              "zIncrements" = zIncrements,
              "zPositives"  = zPositives,
              "zNegatives"  = zNegatives))
}

# dec <- matrix(-5:19, nrow = 5)
# tt  <- set_kulas(dec, palette = "sunset", skipMid = 2)
# par(mfrow = c(1, 2))
# image(dec)
# image(dec, col = tt$zKula)
