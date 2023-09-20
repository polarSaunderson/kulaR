kulaD <- function(count, ...) {
  #' Returns a diverging blue-red khroma colour scheme
  #'
  #' @description Just a wrapper around `kulaK()` (which is a wrapper around
  #'   khroma) for when we want to use the "BuRd" colour scheme.
  #'
  #' @param count numeric: How many colours should be returned?
  #' @param ... Any arguments that can be used by the `kulaK()` function.
  #'
  #' @examples
  #'   mm <- matrix(sample(1:100, 64), nrow = 8)
  #'   image(mm, col = kulaD(10))
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  kula <- kulaK("BuRd", count = count, ...)
  return(kula)
}

kulaD2 <- function(count, ...) {
  #' Returns a diverging purple-green khroma colour scheme
  #'
  #' @description Just a wrapper around `kulaK()` (which is a wrapper around
  #'   khroma) for when we want to use the "PRGn" colour scheme.
  #'
  #' @param count numeric: How many colours should be returned?
  #' @param ... Any arguments that can be used by the `kulaK()` function.
  #'
  #' @examples
  #'   mm <- matrix(sample(1:100, 64), nrow = 8)
  #'   image(mm, col = kulaD2(10))
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  kula <- kulaK("PRGn", count = count, ...)
  return(kula)
}

kulaD3 <- function(count, ...) {
  #' Returns a diverging sunset khroma colour scheme
  #'
  #' @description Just a wrapper around `kulaK()` (which is a wrapper around
  #'   khroma) for when we want to use the "sunset" colour scheme.
  #'
  #' @param count numeric: How many colours should be returned?
  #' @param ... Any arguments that can be used by the `kulaK()` function.
  #'
  #' @examples
  #'   mm <- matrix(sample(1:100, 64), nrow = 8)
  #'   image(mm, col = kulaD3(10))
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  kula <- kulaK("sunset", count = count, ...)
  return(kula)
}
