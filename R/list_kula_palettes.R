list_kula_palettes <- function(type = NULL, print = TRUE) {
  #' Access the possible khroma colour schemes
  #'
  #' @description A wrapper around [khroma::info()] that is fed into the other
  #'   `list_kulaX_palettes` functions. kulaInfo is invisibly returned.
  #'
  #' @param type "string": Which kind of colour scheme are you interested in?
  #'   Options are "diverging", "sequential", and "qualitative".
  #' @param print BINARY: Should the kula palettes be printed? TRUE by default
  #'   (as it is the point of this function!), but FALSE suppresses so it can be
  #'   used in other functions.
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  kulaInfo <- khroma::info()
  if (!is.null(type)) kulaInfo <- kulaInfo[kulaInfo$type == type, ]
  if (isTRUE(print)) print(kulaInfo)
  return(invisible(kulaInfo))
}

list_kulaD_palettes <- function(print = TRUE) {
  #' Print out the possible diverging khroma colour schemes
  #'
  #' @description A wrapper around [khroma::info()], but only showing diverging
  #'   colour schemes. kulaInfo is invisibly returned.
  #' @inheritParams list_kula_palettes
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  kulaInfo <- list_kula_palettes("diverging", print)
  return(invisible(kulaInfo))
}

list_kulaS_palettes <- function(print = TRUE) {
  #' Print out the possible sequential khroma colour schemes
  #'
  #' @description A wrapper around [khroma::info()], but only showing sequential
  #'   colour schemes. kulaInfo is invisibly returned. Use `list_kulaC_palettes`
  #'   for circular palettes.
  #' @inheritParams list_kula_palettes
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  kulaInfo <- list_kula_palettes("sequential", print)
  return(invisible(kulaInfo))
}

list_kulaQ_palettes <- function(print = TRUE) {
  #' Print out the possible qualitative khroma colour schemes
  #'
  #' @description A wrapper around [khroma::info()], but only showing
  #'   qualitative colour schemes. kulaInfo is invisibly returned.
  #' @inheritParams list_kula_palettes
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  kulaInfo <- list_kula_palettes("qualitative", print)
  return(invisible(kulaInfo))
}


list_kulaC_palettes <- function(print = TRUE) {
  #' Print out the possible circular khroma colour schemes
  #'
  #' @description A wrapper around [khroma::info()], but only showing circular
  #'   colour schemes. kulaInfo is invisibly returned.
  #' @inheritParams list_kula_palettes
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  # All colour palettes
  kulaInfo   <- khroma::info()

  # The logic here is that the names for the circular patterns end in "O".
  kulaNames  <- kulaInfo$palette                             # palette names
  nameLength <- sapply(kulaNames, nchar)                     # name length
  lastChar   <- substring(kulaNames, nameLength, nameLength) # last character
  circulars  <- which(lastChar == "O")                       # "O" for circular
  kulaInfo   <- kulaInfo[circulars, ]                        # Subset circular

  # Output
  if (isTRUE(print)) print(kulaInfo)
  return(invisible(kulaInfo))
}
