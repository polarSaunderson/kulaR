add_kulaBar <- function(kula,
                        range,
                        increments = NULL,
                        tickAxis = 1,
                        nameAxis = NULL,
                        labels = NULL,
                        mar = NULL,
                        labelFirst = 1,
                        labelEvery = 1, ...) {
  #' Add a custom colour bar
  #'
  #' @description Add a colour bar / legend with more fine control. Make sure to
  #'   prepare the plot area before using this function (using e.g. `layout()`).
  #'   The function essentially plots a matrix with a single row / column using
  #'   the `graphics::image()`, and then uses `figuR::add_axis()`.
  #'
  #' @param kula The colours to plot in the colour bar. Either a vector of
  #'   colours (e.g. a colour_scheme from `khroma`), or a string that is fed
  #'   into `kulaK()` (a wrapper around `khroma::colour()`). Usually, it makes
  #'   more sense to provide a vector (e.g. the output of `kulaR::kulaK()`)
  #'   because this provides more flexibility and is likely being used in
  #'   whatever the colour bar refers to.
  #' @param range vector: min and max values for the kulaBar. The min will
  #'   always be plotted to the left of horizontal bars, or at the bottom of
  #'   vertical bar.
  #' @param increments numeric: How much change is represented by one block of
  #'   colour along the bar? If kula is a colour scheme, this argument is
  #'   ignored and the increments are calculated automatically by dividing the
  #'   full range by the length of the kula vector. If 'kula' is a string (e.g.
  #'   "BuRd"), the increments cannot be calculated automatically so this value
  #'   is necessary; in such a case, the difference between the 'range' values
  #'   must be an exact multiple of the 'increment' argument.
  #' @param tickAxis numeric: Which side of the axis should the ticks and labels
  #'   be added? This determines orientation: 1 (bottom) and 3 (top) are
  #'   horizontal, 2 (left) and 4 (right) are vertical. Default is 1.
  #' @param nameAxis numeric: Which side of the axis should the name be added?
  #' @param labels vector: If not NULL, values are used as labels for the ticks
  #'   along the axis instead of the values calculated from 'range' and
  #'   'increments'. Useful for adding something such as "<0" for example.
  #'   Labels must be provided for all ticks (i.e. assuming that 'labelEvery' =
  #'   1), even if 'labelEvery' is not 1. See examples.
  #' @param mar vector: Set the margins around the kulaBar (as par(mar = mar)).
  #' @param labelFirst Which is the first tick that should be labelled? Use the
  #'   index, not the value. See `figuR::add_axis()`.
  #' @param labelEvery Labels should be added every how many ticks? See
  #'   `figuR::add_axis()`.
  #' @param ... Any additional parameters not listed above that can be fed into
  #'   figuR::add_axis().
  #'
  #' @examples
  #'   \dontrun{
  #'     # Make changes to the colours beforehand
  #'     kk <- kulaK("BuRd", 14, c(3, 7), skipMid = 1)
  #'     add_kulaBar(kk, c(-3, 7) * 4)
  #'
  #'     # Be careful with the range and the labels if doing unusual palettes
  #'     kk <- kulaK(palette = "bamako", count = 14,
  #'                 reverse = TRUE,
  #'                 addFirst = "magenta", include = 1:10)
  #'     add_kulaBar(kula = kk, range = c(1, 16),
  #'                 labels = c("", "<0", 1:10), labelEvery = 2, labelFirst = 2)
  #'
  #'     # Without first defining the colour palette
  #'     add_kulaBar(kula = "romaO", range = c(0, 360), increments = 45)
  #'   }
  #'
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  # Prepare values & calculate increments if necessary
  kMin <- min(range)
  kMax <- max(range)
  kCount <- length(kula)

  # If a vector of colours, increments are calculated automatically
  if (kCount > 1) {
    increments <- NULL
    kPalette <- TRUE
  } else if (kCount == 1) {
    kPalette <- FALSE
  }

  # Calculate increments
  if (is.null(increments)) {
    if (kCount > 1) {
      increments <- (kMax - kMin) / kCount
    } else {
      stop("Set the 'increments' arugment!")
    }
  }

  # Calculate number of values
  kGap   <- seq(kMin, kMax, increments) # also necessary for default labels
  if (kMin %notIn% kGap | kMax %notIn% kGap) {
    stop("The 'increments' argument must be an exact multiple of the difference between the 'range' values.")
  }

  kCount <- length(kGap) - 1

  # Determine kulaBar orientation
  if (tickAxis %in% c(1, 3)) {                               # horizontal
    kulaMatrix <- matrix(1:(kCount), nrow = kCount)
    nameAxis   <- domR::set_if_null(nameAxis, 3)
  } else if (tickAxis %in% c(2, 4)) {                        # horizontal
    kulaMatrix <- matrix(1:(kCount), ncol = kCount)
    nameAxis   <- domR::set_if_null(nameAxis, tickAxis)
  }

  # Define colours
  if (isFALSE(kPalette)) {
    kula <- kulaK(palette = kula, count = kCount)
  }

  # Prepare labels
  if (is.null(labels)) {
    labels <- kGap
    kPrec  <- signif(labels, 3) |> domR::count_decimal_places() |> median()
    labels <- round(labels, kPrec)

    # Make sure a tick occurs on 0 if it is in there
    if (0 %in% labels) {
      zeroIndex  <- which(labels == 0)
      unders     <- rev(seq(zeroIndex, 1, -labelEvery))
      labelFirst <- domR::set_if_null(labelFirst, unders[1])
    }
  }

  # Prep area
  mar <- domR::set_if_null(mar, graphics::par("mar"))
  graphics::par(mar = mar)

  # Plot the kulaBar
  graphics::image(kulaMatrix, col = kula,
                  axes = FALSE, xaxs = "i", yaxs = "i")
  figuR::add_axis(tickAxis,
                  labels = labels,
                  alignMidPoints = FALSE,
                  labelFirst = labelFirst, labelEvery = labelEvery,
                  ...)

  return(invisible(kula))
}
