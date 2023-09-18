add_kulaBar <- function(kula,
                        range,
                        increments = NULL,
                        axisSide = 1,
                        name = NULL,
                        nameSide = NULL,
                        labels = NULL,
                        mar = NULL,
                        frame = "black",
                        labelFirst = 1,
                        labelEvery = 1, ...) {
  #' Add a custom colour bar
  #'
  #' @description Add a colour bar / legend with more fine control. Make sure to
  #'   prepare the plot area before using this function (using e.g. [layout()]).
  #'   The function essentially plots a coloured matrix of a single row / column
  #'   using [graphics::image()], and then uses `figuR::add_axis()` to add the
  #'   values.
  #'
  #' @param kula The colours to plot in the colour bar. Either a vector of
  #'   colours (e.g. a colour_scheme from `khroma`), or a string that is fed
  #'   into [kulaK()] (which is a just a wrapper around [khroma::colour()]).
  #'
  #'   Usually, it makes more sense to input a vector (e.g. the output of
  #'   [kulaK()]) because it allows more flexibility in colour definitions and
  #'   is likely being used in whatever the colour bar refers to.
  #' @param range vector: min and max values for the kulaBar. The min will
  #'   always be plotted to the left of horizontal bars, or at the bottom of
  #'   vertical bar.
  #' @param increments numeric: How much change is represented by one block of
  #'   colour along the bar?
  #'
  #'   If 'kula' is a colour scheme, this argument is ignored and the increments
  #'   are calculated automatically by dividing the 'range' by the length of the
  #'   'kula' vector.
  #'
  #'   If 'kula' is a valid `khroma` name (e.g. "BuRd"), the increments cannot
  #'   be calculated automatically and this argument is mandatory; in such a
  #'   case, the difference between the 'range' values must be an exact multiple
  #'   of the 'increment' argument.
  #'
  #' @param axisSide numeric: Which side of the axis should the ticks and labels
  #'   be added? This argument determines the kulaBar orientation: 1 (bottom;
  #'   default) and 3 (top) are horizontal; 2 (left) and 4 (right) are vertical.
  #'
  #' @param labels vector: If not NULL, values are used as labels for the ticks
  #'   along the axis instead of the values calculated from 'range' and
  #'   'increments'. Useful for adding something such as "<0" for example.
  #'
  #'   **Note:** Labels must be provided for all ticks (i.e. assuming that
  #'   'labelEvery' = 1), even if 'labelEvery' is not 1. See examples.
  #' @param mar vector: Set the margins around the kulaBar (as par(mar = mar)).
  #' @param frame What colour should the border around the kulaBar be? Set as
  #'   NULL to suppress the border.
  #' @param labelFirst Which is the first tick that should be labelled? Use the
  #'   index, not the value. See [figuR::add_axis()].
  #' @param labelEvery Labels should be added every how many ticks? See
  #'   [figuR::add_axis()].
  #' @param ... Any additional parameters not listed above that can be fed into
  #'   [figuR::add_axis()].
  #' @inheritParams figuR::add_axis
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
  #'     add_kulaBar(kula = kk, range = c(1, 15),
  #'                 labels = c("", "<0", 1:10), labelEvery = 2, labelFirst = 2)
  #'
  #'     # Without first defining the colour palette
  #'     add_kulaBar(kula = "romaO", range = c(0, 360), increments = 45)
  #'
  #'     # Also works with any valid colours even if not kula / khroma defined
  #'     add_kulaBar(kula = c("red", "blue", "black", "pink"), range = c(1, 3))
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
  if (axisSide %in% c(1, 3)) {                               # horizontal
    kulaMatrix <- matrix(1:(kCount), nrow = kCount)
    nameSide   <- set_if_null(nameSide, 3)   # from domR
  } else if (axisSide %in% c(2, 4)) {                        # horizontal
    kulaMatrix <- matrix(1:(kCount), ncol = kCount)
    nameSide   <- set_if_null(nameSide, axisSide)  # from domR
  }

  # Define colours
  if (isFALSE(kPalette)) {
    kula <- kulaK(palette = kula, count = kCount)
  }

  # Prepare labels
  if (is.null(labels)) {
    labels <- kGap
    kPrec  <- signif(labels, 3) |>
      count_decimal_places() |>           # from domR
      stats::median()
    labels <- round(labels, kPrec + 1)

    # Make sure a tick occurs on 0 if it is in there
    if (0 %in% labels) {
      zeroIndex  <- which(labels == 0)
      unders     <- rev(seq(zeroIndex, 1, -labelEvery))
      labelFirst <- set_if_null(labelFirst, unders[1]) # from domR
    }
  }

  # Prep area
  mar <- set_if_null(mar, graphics::par("mar"))  # from domR
  graphics::par(mar = mar)

  # Plot the kulaBar
  graphics::image(kulaMatrix, col = kula,
                  axes = FALSE, xaxs = "i", yaxs = "i")
  figuR::add_axis(axisSide,
                  labels = labels,
                  alignMidPoints = FALSE, gridLwd = 0,
                  labelFirst = labelFirst, labelEvery = labelEvery,
                  name = name, nameSide = nameSide,
                  ...)
  if (!is.null(frame)) {
    figuR::add_plot_frame(kula = frame)
  }

  return(invisible(kula))
}
