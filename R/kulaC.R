kulaC <- function(count, ...) {
  #' Returns a circular multi-coloured khroma colour scheme
  #'
  #' @description Just a wrapper around [kulaK()] (which is a wrapper around
  #'   [khroma::colour()]) for when we want to use the "romaO" colour scheme.
  #'
  #' @param count numeric: How many colours should be returned?
  #' @param ... Any arguments that can be used by the [kulaK()] function.
  #'
  #' @examples
  #'   mm <- matrix(sample(1:100, 64), nrow = 8)
  #'   image(mm, col = kulaC(100))
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  kula <- kulaK("romaO", count = count, ...)
  return(kula)
}

kulaC2 <- function(count, ...) {
  #' Returns a circular blue-red khroma colour scheme
  #'
  #' @description Just a wrapper around [kulaK()] (which is a wrapper around
  #'   [khroma::colour()]) for when we want to use the "vikO" colour scheme.
  #'
  #' @param count numeric: How many colours should be returned?
  #' @param ... Any arguments that can be used by the [kulaK()] function.
  #'
  #' @examples
  #'   mm <- matrix(sample(1:100, 64), nrow = 8)
  #'   image(mm, col = kulaC2(100))
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  kula <- kulaK("vikO", count = count, ...)
  return(kula)
}
