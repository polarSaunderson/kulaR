annotate_kulaBar <- function(aboveLeft = "", above = "", aboveRight = "",
                             midLeft = "", mid = "", midRight = "",
                             belowLeft = "", below = "", belowRight = "",
                             offset_v = c(10, 15), offset_h = 0, cex = 0.75) {
  #' Add text around a kulaBar to explain the colours
  #'
  #' @description This function is particularly useful when a kulaBar displays
  #'   differences that are not immediately intuitive. The function simply adds
  #'   text at up to 9 locations around the kulaBar. It needs to be called
  #'   immediately after using `add_kulaBar()`.
  #'
  #' @param aboveLeft,above,aboveRight "string": Text above the kulaBar in the
  #'   respective positions.
  #' @param midLeft,mid,midRight "string": Text aligned centred against the
  #'   kulaBar in the respective positions.
  #' @param belowLeft,below,belowRight "string": Text below the kulaBar in the
  #'   respective positions.
  #' @param offset_v numeric: How far from the kulaBar should the text be
  #'   located vertically? Positive values move text away from the kulaBar; unit
  #'   is percentage of the kulaBar height. If two values are provided, the
  #'   first values moves the text strings above the bar, and the second the
  #'   strings below; for a single value, both sets are moved the same distance
  #'   *away* (if positive) or *towards* (if negative) from the kulaBar.
  #'   'midLeft', 'mid' and 'midRight' text cannot be vertically offset, they
  #'   just stick to the centre of the kulaBar.
  #' @param offset_h numeric: As for 'offset_v' but horizontal offsets. If two
  #'   values are supplied, the first applies to the left side and the second to
  #'   the right side. Units are percentage of the kulaBar *width*. 'mid',
  #'   'above' and 'below' text cannot be horizontally offset, they just stick
  #'   to the centre of the kulaBar.
  #' @param cex numeric: How large should the text be?
  #'
  #' @examples
  #'   \dontrun{
  #'     # horizontal bar
  #'     kk <- kulaD(10)
  #'     add_kulaBar(kk, c(-5, 5), mar = c(5, 4, 5, 4))
  #'     annotate_kulaBar("colder",    NA,   "warmer",
  #'                      "OR",        NULL, "OR",
  #'                      "less warm", "",   "less cold")
  #'     # vertical bar
  #'     kk <- kulaD(10)
  #'     add_kulaBar(kk, c(-5, 5), mar = c(5, 15, 5, 15), tickAxis = 2)
  #'     annotate_kulaBar("warmer", "OR", "less cold",
  #'                      NA,       NULL, "",
  #'                      "colder", "OR", "less warm")
  #'   }
  #'
  #'
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

  offset_v <- offset_v / 100
  offset_h <- offset_h / 100

  # above left
  graphics::text(labels = aboveLeft,
                 x = leftX - (widthX * offset_h[1]),
                 y = aboveY + (heightY * offset_v[1]),
                 adj = c(0.5, 0.5), cex = cex, xpd = TRUE)

  # above centre
  graphics::text(labels = above,
                 x = midX,
                 y = aboveY + (heightY * offset_v[1]),
                 adj = c(0.5, 0.5), cex = cex, xpd = TRUE)

  # above right
  graphics::text(labels = aboveRight,
                 x = rightX + (widthX * offset_h[2]),
                 y = aboveY + (heightY * offset_v[1]),
                 adj = c(0.5, 0.5), cex = cex, xpd = TRUE)


  # mid left
  graphics::text(labels = midLeft,
                 x = leftX - (widthX * offset_h[1]),
                 y = midY,
                 adj = c(0.5, 0.5), cex = cex, xpd = TRUE)


  # middle
  graphics::text(labels = mid,
                 x = midX,
                 y = midY,
                 adj = c(0.5, 0.5), cex = cex, xpd = TRUE)

  # mid right
  graphics::text(labels = midRight,
                 x = rightX + (widthX * offset_h[1]),
                 y = midY,
                 adj = c(0.5, 0.5), cex = cex, xpd = TRUE)

  # below left
  graphics::text(labels = belowLeft,
                 x = leftX - (widthX * offset_h[1]),
                 y = belowY - (heightY * offset_v[2]),
                 adj = c(0.5, 0.5), cex = cex, xpd = TRUE)

  # below centre
  graphics::text(labels = below,
                 x = midX,
                 y = belowY - (heightY * offset_v[2]),
                 adj = c(0.5, 0.5), cex = cex, xpd = TRUE)

  # above right
  graphics::text(labels = belowRight,
                 x = rightX + (widthX * offset_h[2]),
                 y = belowY - (heightY * offset_v[2]),
                 adj = c(0.5, 0.5), cex = cex, xpd = TRUE)

}
