% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_kulaBar.R
\name{add_kulaBar}
\alias{add_kulaBar}
\title{Add a custom colour bar}
\usage{
add_kulaBar(
  kula,
  range,
  increments = NULL,
  axisSide = 1,
  name = NULL,
  nameSide = NULL,
  labels = NULL,
  mar = NULL,
  frame = "black",
  labelFirst = 1,
  labelEvery = 1,
  ...
)
}
\arguments{
\item{kula}{The colours to plot in the colour bar. Either a vector of
colours (e.g. a colour_scheme from \link{khroma}), or a string that is fed
into \code{\link[=kulaK]{kulaK()}} (which is a just a wrapper around \code{\link[khroma:colour]{khroma::colour()}}).

Usually, it makes more sense to input a vector (e.g. the output of
\code{\link[=kulaK]{kulaK()}}) because it allows more flexibility in colour definitions and
is likely being used in whatever the colour bar refers to.}

\item{range}{vector: min and max values for the kulaBar. The min will
always be plotted to the left of horizontal bars, or at the bottom of
vertical bar.}

\item{increments}{numeric: How much change is represented by one block of
colour along the bar?

If 'kula' is a colour scheme, this argument is ignored and the increments
are calculated automatically by dividing the 'range' by the length of the
'kula' vector.

If 'kula' is a valid \code{khroma} name (e.g. "BuRd"), the increments cannot
be calculated automatically and this argument is mandatory; in such a
case, the difference between the 'range' values must be an exact multiple
of the 'increment' argument.}

\item{axisSide}{numeric: Which side of the axis should the ticks and labels
be added? This argument determines the kulaBar orientation: 1 (bottom;
default) and 3 (top) are horizontal; 2 (left) and 4 (right) are vertical.}

\item{name}{"string": What does the axis show?}

\item{nameSide}{numeric: Which side of the axis (**NOT** the plot), should
the name be added? Default is to the outside of the axis.}

\item{labels}{vector: If not NULL, values are used as labels for the ticks
along the axis instead of the values calculated from 'range' and
'increments'. Useful for adding something such as "<0" for example.

\strong{Note:} Labels must be provided for all ticks (i.e. assuming that
'labelEvery' = 1), even if 'labelEvery' is not 1. See examples.}

\item{mar}{vector: Set the margins around the kulaBar (as par(mar = mar)).}

\item{frame}{What colour should the border around the kulaBar be? Set as
NULL to suppress the border.}

\item{labelFirst}{Which is the first tick that should be labelled? Use the
index, not the value. See \code{\link[figuR:add_axis]{figuR::add_axis()}}.}

\item{labelEvery}{Labels should be added every how many ticks? See
\code{\link[figuR:add_axis]{figuR::add_axis()}}.}

\item{...}{Any additional parameters not listed above that can be fed into
\code{\link[figuR:add_axis]{figuR::add_axis()}}.}
}
\description{
Add a colour bar / legend with more fine control. Make sure to
prepare the plot area before using this function (using e.g.
\code{\link[graphics:layout]{graphics::layout()}}). The function essentially plots a coloured matrix
of a single row / column using \code{\link[graphics:image]{graphics::image()}}, and then uses
\code{\link[figuR:add_axis]{figuR::add_axis()}} to add the values.
}
\examples{
  \dontrun{
    # Make changes to the colours beforehand
    kk <- kulaK("BuRd", 14, c(3, 7), skipMid = 1)
    add_kulaBar(kk, c(-3, 7) * 4)

    # Be careful with the range and the labels if doing unusual palettes
    kk <- kulaK(palette = "bamako", count = 14,
                reverse = TRUE,
                addFirst = "magenta", include = 1:10)
    add_kulaBar(kula = kk, range = c(1, 15),
                labels = c("", "<0", 1:10), labelEvery = 2, labelFirst = 2)

    # Without first defining the colour palette
    add_kulaBar(kula = "romaO", range = c(0, 360), increments = 45)

    # Also works with any valid colours even if not kula / khroma defined
    add_kulaBar(kula = c("red", "blue", "black", "pink"), range = c(1, 3))
  }


}
