annotate_kulaBar <- function(aboveLeft = "", above = "", aboveRight = "",
                             belowLeft = "", below = "", belowRight = "",
                             offset_v = 0.1, offset_h = 0, cex = 0.75) {
  #' Add text around a kulaBar to explain the colours
  #'
  #' @description This function is particularly useful when a kulaBar displays
  #'   differences that are not immediately intuitive. The function simply adds
  #'   text at up to 6 locations around the kulaBar. It needs to be called
  #'   immediately after using `add_kulaBar()`. It currently only works for
  #'   horizontal kulaBars.
  #'
  #' @param aboveLeft,above,aboveRight "string": Text above the kulaBar in the
  #'   respective positions.
  #' @param belowLeft,below,belowRight "string": Text below the kulaBar in the
  #'   respective positions.
  #' @param offset_v numeric: How far from the kulaBar should the text be
  #'   located vertically? Positive values move text away from the kulaBar; unit
  #'   is fractions of the kulaBar height. If two values are provided, the first
  #'   values moves the text strings above the bar, and the second the strings
  #'   below; for a single value, both sets are moved the same distance *away*
  #'   (if positive) or *towards* (if negative) from the kulaBar.
  #' @param offset_h numeric: As for 'offset_v' but horizontal offsets. If two
  #'   values are supplied, the first applies to the left side and the second to
  #'   the right side. Units are also fractions of the kulaBar *height*.
  #' @param cex numeric: How large should the text be?
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  # Prep locations
  edges   <- graphics::par("usr")
  leftX   <- edges[1]
  rightX  <- edges[2]
  belowY  <- edges[3]
  aboveY  <- edges[4]
  widthX  <- rightX - leftX
  heightY <- aboveY - belowY
  midX    <- leftX  + ((rightX - leftX) / 2)
  midY    <- belowY + ((aboveY - belowY) / 2)

  # Handle if offsets are single values or not
  if (length(offset_v) == 1) {
    offset_v <- c(offset_v, offset_v)
  }
  if (length(offset_h) == 1) {
    offset_h <- c(offset_h, offset_h)
  }

  # above left
  graphics::text(labels = aboveLeft,
                 x = leftX - (heightY * offset_h[1]),
                 y = aboveY + (heightY * offset_v[1]),
                 adj = c(0.5, 0.5), cex = cex, xpd = TRUE)

  # above centre
  graphics::text(labels = above,
                 x = midX,
                 y = aboveY + (heightY * offset_v[1]),
                 adj = c(0.5, 0.5), cex = cex, xpd = TRUE)

  # above right
  graphics::text(labels = aboveRight,
                 x = rightX + (heightY * offset_h[2]),
                 y = aboveY + (heightY * offset_v[1]),
                 adj = c(0.5, 0.5), cex = cex, xpd = TRUE)


  # below left
  graphics::text(labels = belowLeft,
                 x = leftX - (heightY * offset_h[1]),
                 y = belowY - (heightY * offset_v[2]),
                 adj = c(0.5, 0.5), cex = cex, xpd = TRUE)

  # below centre
  graphics::text(labels = below,
                 x = midX,
                 y = belowY - (heightY * offset_v[2]),
                 adj = c(0.5, 0.5), cex = cex, xpd = TRUE)

  # above right
  graphics::text(labels = belowRight,
                 x = rightX + (heightY * offset_h[2]),
                 y = belowY - (heightY * offset_v[2]),
                 adj = c(0.5, 0.5), cex = cex, xpd = TRUE)

}
