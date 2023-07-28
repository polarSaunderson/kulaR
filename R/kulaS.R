kulaS <- function(count, ...) {
  #' Returns a yellow-through-brown sequential khroma colour scheme
  #'
  #' @description Just a wrapper around `kulaK()` (which is a wrapper around
  #'   khroma) for when we want to use the "YlOrBr" colour scheme.
  #'
  #' @param count numeric: How many colours should be returned?
  #' @param ... Any arguments that can be used by the `kulaK()` function.
  #'
  #' @examples
  #'   mm <- matrix(sample(1:100, 64), nrow = 8)
  #'   image(mm, col = kulaS(10))
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  kula <- kulaK("YlOrBr", count = count, ...)
  return(kula)
}

kulaS2 <- function(count, ...) {
  #' Returns a green-through-yellow sequential khroma colour scheme
  #'
  #' @description Just a wrapper around `kulaK()` (which is a wrapper around
  #'   khroma) for when we want to use the "bamako" colour scheme.
  #'
  #' @param count numeric: How many colours should be returned?
  #' @param ... Any arguments that can be used by the `kulaK()` function.
  #'
  #' @examples
  #'   mm <- matrix(sample(1:100, 64), nrow = 8)
  #'   image(mm, col = kulaS2(10))
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  kula <- kulaK("bamako", count = count, ...)
  return(kula)
}
