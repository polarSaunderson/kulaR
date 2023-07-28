kulaL <- function(shade = 4, opacity = 10) {
  #' Returns different shades of grey, ideal for grid lines
  #'
  #' @description For plotting lines, we often want a simple grey or black
  #'   colour, which can take require unnecessarily verbose code; this function
  #'   simplifies all of that for us and provides a wrapper around the `rgb()`
  #'   function that is more consistent with the "kulaR" syntax. See also
  #'   `kulaT()`, which is the same, but swaps the order of the arguments to
  #'   make it slightly easier for changing the line transparency.
  #'
  #' @param shade numeric: A value between 0 (white) and 10 (black).
  #' @param opacity numeric: A value between 0 (invisible) and 10 (opaque).
  #'
  #' @export

  # Code -----------------------------------------------------------------------
   kula <- grDevices::rgb(10 - shade,
                          10 - shade,
                          10 - shade,
                          alpha = opacity,
                          maxColorValue = 10)
   return(kula)
}

kulaT <- function(opacity = 4, shade = 10) {
  #' Returns semi-transparent grey colours, ideal for grid lines
  #'
  #' @description For plotting lines, we often want a simple grey or black
  #'   colour, which can take require unnecessarily verbose code; this function
  #'   simplifies all of that for us and provides a wrapper around the `rgb()`
  #'   function that is more consistent with the "kulaR" syntax. See also
  #'   `kulaL()`, which is the same, but swaps the order of the arguments to
  #'   make it slightly easier for changing the line colour.
  #'
  #' @param opacity numeric: A value between 0 (invisible) and 10 (opaque).
  #' @param shade numeric: A value between 0 (white) and 10 (black).
  #'
  #' @export

  # Code -----------------------------------------------------------------------
   kula <- grDevices::rgb(10 - shade,
                          10 - shade,
                          10 - shade,
                          alpha = opacity,
                          maxColorValue = 10)
   return(kula)
}
