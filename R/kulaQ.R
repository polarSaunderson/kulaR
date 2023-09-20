kulaQ <- function(include = NULL, ...) {
  #' Returns the "bright" qualitative khroma colour scheme
  #'
  #' @description Just a wrapper around `kulaK()` (which is a wrapper around
  #'   khroma) for when we want to use a qualitative colour scheme. Either
  #'   return the full "bright" palette (the default), or add an index /
  #'   character strings to select a subset of the colours (useful for e.g.
  #'   nicer line colours and matching lines across plots). The options are:
  #'   "red", "blue", "green", "yellow", "cyan", "purple" and "grey".
  #'
  #' @param include "string" or c(vector): Return only a subset of the colours.
  #'   Can either be defined by their name, or their index.
  #' @param ... Any arguments that can be used by the `kulaK()` function,
  #'   although "skipMid", and "reverse" don't make much sense.
  #'
  #' @examples
  #'   plot(1:7, 1:7)
  #'   abline(h = 1:7, col = kulaQ(), lwd = 5)
  #'   abline(v = 1:7, col = kulaQ("red"), lwd = 5)
  #'   plot(1:7, 1:7)
  #'   abline(v = 1:7, col = kulaQ("red", "blue"), lwd = 5)
  #'   abline(h = 1:7, col = kulaQ(1:3), lwd = 5)
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  kula <- kulaK("bright", 7, include = list(include), ...)
  return(kula)
}

kulaQ2 <- function(include = NULL, ...) {
  #' Returns the "vibrant" qualitative khroma colour scheme
  #'
  #' @description Just a wrapper around `kulaK()` (which is a wrapper around
  #'   khroma) for when we want to use a qualitative colour scheme. Either
  #'   return the full "vibrant" palette (the default), or add an index /
  #'   character strings to select a subset of the colours (useful for e.g.
  #'   nicer line colours and matching lines across plots). The options are:
  #'   "orange", "blue", "cyan", "magenta", "red", "teal", and "grey".
  #'
  #' @param include "string" or c(vector): Return only a subset of the colours.
  #'   Can either be defined by their name, or their index.
  #' @param ... Any arguments that can be used by the `kulaK()` function,
  #'   although "skipMid", and "reverse" don't make much sense.
  #'
  #' @examples
  #'   plot(1:7, 1:7)
  #'   abline(h = 1:7, col = kulaQ2(), lwd = 5)
  #'   abline(v = 1:7, col = kulaQ2("orange"), lwd = 5)
  #'   plot(1:7, 1:7)
  #'   abline(v = 1:7, col = kulaQ2("orange", "cyan"), lwd = 5)
  #'   abline(h = 1:7, col = kulaQ2(1:3), lwd = 5)
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  kula <- kulaK("vibrant", 7, include = list(include), ...)
  return(kula)
}


kulaQ3 <- function(include = NULL, ...) {
  #' Returns the "highcontrast" qualitative khroma colour scheme
  #'
  #' @description Just a wrapper around `kulaK()` (which is a wrapper around
  #'   khroma) for when we want to use a qualitative colour scheme. Either
  #'   return the full "highcontrast" palette (the default), or add an index /
  #'   character strings to select a subset of the colours (useful for e.g.
  #'   nicer line colours and matching lines across plots). The options are:
  #'   "blue", "yellow" and "red".
  #'
  #' @param include "string" or c(vector): Return only a subset of the colours.
  #'   Can either be defined by their name, or their index.
  #' @param ... Any arguments that can be used by the `kulaK()` function,
  #'   although "skipMid", and "reverse" don't make much sense.
  #'
  #' @examples
  #'   plot(1:3, 1:3)
  #'   abline(h = 1:3, col = kulaQ3(), lwd = 5)
  #'   abline(v = 1:3, col = kulaQ3("blue"), lwd = 5)
  #'   plot(1:3, 1:3)
  #'   abline(v = 1:3, col = kulaQ3("yellow", "blue"), lwd = 5)
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  kula <- kulaK("highcontrast", 3, include = list(include), ...)
  return(kula)
}
