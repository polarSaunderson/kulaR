## Copied directly from domR v0.0.1.
set_if_null <- function(x, defaultValue) {
  #' Sets a default value for a NULL argument
  #'
  #' @description In some functions, it is necessary to create an argument that
  #'   has a default value defined by the other arguments (i.e. calculated
  #'   within the function), but that can nevertheless be overwritten if
  #'   required. We therefore set the argument value as NULL, and can use this
  #'   function within another function to determine whether the argument's
  #'   value needs to be calculated or not. This function just makes it cleaner,
  #'   clearer and quicker to see what is happening compared to the default
  #'   syntax for this process.
  #'
  #' @param x Which argument is being checked?
  #' @param defaultValue What's the value if the argument is NULL?

  # Code -----------------------------------------------------------------------
  if (is.null(x)) x <- defaultValue
  return(x)
}

## Copied directly from domR v0.0.1.
`%notIn%` <- function(x, y) {
  #' The opposite of the native "in" function.
  #'
  #' @description If we want to know what isn't in something else, use this! It
  #'   returns a vector of binary values, not the actual values that are not in
  #'   there.
  #'
  #' @param x the values we are interested in
  #' @param y the values to compare against

  # Code ----------------------------------------------------------------------!
  match(x, y, nomatch = 0) == 0
  # x[match(x, y, nomatch = 0) == 0]   # alternative returns actual values
}

## Copied directly from domR v0.0.1
count_decimal_places <- function(x) {
  #' Counts how many digits are after the decimal point
  #'
  #' @description This function is useful when we are automating things and need
  #'   to round, but aren't always sure what precision we need to round to. The
  #'   code was taken from this stackoverflow answer by daroczig:
  #'   [https://stackoverflow.com/questions/5173692/how-to-return-number-of-decimal-places-in-r](),
  #'   and I do not entirely understand how it works.
  #'
  #' @param x numeric: The value

  # Code -----------------------------------------------------------------------
  # Preallocate
  xDP <- integer(length(x))
  machPrec <- .Machine$double.eps^0.5 # computer precision is min. diff possible

  # Loop through values
  for (ii in x) {
    iiIndex <- which(x == ii)
    if (!is.na(ii)) {
      if (abs(ii - round(ii)) > machPrec) { # diff is enough for computer to see
        # convert to text to count
        iiSplit <-  strsplit(sub('0+$', '',
                                 format(ii, digits = 15,
                                        scientific = FALSE)), # not Xe+Y
                             ".", fixed = TRUE)[[1]]
        if (length(iiSplit) == 1) {       # if nothing after decimal
          xDP[iiIndex] <- 0
        } else {                          # get part after decimal place
          xDP[iiIndex] <- nchar(iiSplit[[2]])
        }
      } else {
        xDP[iiIndex] <- 0
      }
    } else {
      xDP[iiIndex] <- NaN
    }
  }
  return(xDP)
}
