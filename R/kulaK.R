kulaK <- function(palette,
                  count,
                  include  = NULL,
                  skipMid  = NULL,
                  reverse  = FALSE,
                  opacity  = NULL,
                  addFirst = NULL,
                  addLast  = NULL) {
  #' Returns a khroma colour scheme
  #'
  #' @description This function is essentially a wrapper around the khroma
  #'   package's colour function, but with syntax that I find slightly more
  #'   logical, and which allows me to make common adjustments I have found
  #'   myself doing frequently when using colours. This function is the basis of
  #'   the other "kulaX" functions in kulaR, which are just even quicker
  #'   wrappers.
  #'
  #' @param palette "string": Which colour palette to use? The name must match
  #'   the options available in khroma, which can be accessed using the
  #'   `list_kula_palletes()` function.
  #' @param count numeric: How many colours should be included in the colour
  #'   scheme? Do not count additional colours that are added using the addFirst
  #'   or addLast arguments.
  #' @param include vector: Which colours should be included? This argument is
  #'   useful if we want a lopsided colour scheme, for example if we have a
  #'   range from -3 to 6, and only want to show 3 colour values to the left,
  #'   but 6 colour values to the right (i.e. -3 and 3 should be equivalent, not
  #'   -3 and 6). If a numeric vector of length 2 is supplied, the values are
  #'   respectively applied to the left and right of the midpoint. Positive
  #'   values count outwards from the centre, listing how many colours should be
  #'   included in the respective direction; negative values count inwards from
  #'   the ends, listing how many colours should be excluded. If a numeric
  #'   vector of length > 2 is supplied, it is simply used to index into the
  #'   full vector. If a vector of character strings is supplied, it will try to
  #'   match them against the colour names, which is useful on qualitative
  #'   colour schemes. This argument is applied after the skipMid argument.
  #' @param skipMid numeric: To use more intense colours on a diverging colour
  #'   scheme, we can skip the paler colours around the divergence (usually 0).
  #'   This argument indicates how many should be skipped each side, meaning
  #'   that larger numbers cause more intense colours. It works by telling
  #'   khroma that we want extra colours in our colour scheme and then removing
  #'   the pale ones in the middle. Applied before the include argument.
  #' @param reverse BINARY: Should the full colour palette be reversed? Applied
  #'   before the include argument.
  #' @param opacity numeric: A value between 0 (invisible) and 10 (intense),
  #'   applied to all colours before the function returns them (but before
  #'   addFirst or addLast are applied).
  #' @param addFirst Add a colour at the beginning of the scheme; useful if, for
  #'   example, you want to show all values below a minimum cutoff value in a
  #'   certain colour to ignore (or highlight) them.
  #' @param addLast Add a colour at the end of the scheme; useful if, for
  #'   example, you want to show all values above a top cutoff in a certain
  #'   colour to ignore (or highlight) them.
  #'
  #' @examples
  #'    plot(kulaK("BuRd", 10))
  #'    plot(kulaK("BuRd", 10, include = c(3, 5)))
  #'    plot(kulaK("BuRd", 10, include = c(1:8)))
  #'    plot(kulaK("BuRd", 20, include = c(1:8, 13:16)))
  #'    plot(kulaK("BuRd", 10, skipMid = 2))
  #'    plot(kulaK("BuRd", 10, reverse = TRUE))
  #'    plot(kulaK("BuRd", 10, addFirst = "black"))
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  # Confirm number of colours to return
  if (!is.null(skipMid)) {
    kInfo <- khroma::info()
    if (kInfo$type[kInfo$palette == palette] == "diverging") {
      count <- count + ( 2 * skipMid)
    } else {
      skipMid <- NULL
    }
  }

  # Create the base colour scheme
  kula   <- khroma::colour(palette, reverse = reverse)(count)
  kClass <- class(kula)
  kNames <- names(kula)

  # Skip mid colours?
  if (!is.null(skipMid)) {
    kHalf  <- length(kula) / 2
    keepIndex <- c(1:(kHalf - skipMid),                # 1st half
                   (kHalf + skipMid + 1):length(kula)) # 2nd half
    kula   <- kula[keepIndex]
    kNames <- kNames[keepIndex]
  }

  # Lopsided scheme?
  if (length(include) == 2 & is.numeric(include[1])) {
    kHalf <- length(kula) / 2
    if (include[[1]] > 0) {
      keepLeft <- (kHalf + 1 - include[[1]]):kHalf
    } else {
      keepLeft <- (1 - include[[1]]):kHalf
    }
    if (include[[2]] > 0) {
      keepRight <- kHalf + c(1:include[[2]])
    } else {
      keepRight <- (kHalf + 1):(length(kula) + include[[2]])
    }
    include <- c(keepLeft, keepRight)
  }
  include <- set_if_null(unlist(include), # from domR
                         seq_along(kula)) # include all colours
  kula   <- kula[include]
  kNames <- kNames[include]

  # Change colour opacity
  opacity <- set_if_null(opacity, 10) # from domR
  opacity <- substring(grDevices::rgb(0,0,0,
                                      alpha = opacity,
                                      maxColorValue = 10), 8, 9)
  kula    <- paste0(kula, opacity)

  # Additional colour at start or end?
  if (!is.null(addFirst)) {
    kula   <- c(addFirst, kula)
    kNames <- c(addFirst, kNames)
  }
  if (!is.null(addLast)) {
    kula   <- c(kula, addLast)
    kNames <- c(kNames, addLast)
  }

  # Add colour scheme info back
  class(kula) <- kClass
  names(kula) <- kNames

  return(kula)
}
