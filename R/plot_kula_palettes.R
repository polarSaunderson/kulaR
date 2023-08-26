plot_kula_palettes <- function(orientation = "v", type = NULL) {
  #' Display the khroma colour palettes
  #'
  #' @description Plot all the possible colour palettes from khroma
  #'
  #' @param orientation Should the colour palettes be displated vertically ("v")
  #'   or horizontally ("h")?
  #' @inheritParams list_kula_palettes
  #'
  #' @export

  # Code -----------------------------------------------------------------------
  # Prep
  if (type == "circular") {
    kulaInfo <- list_kulaC_palettes(FALSE)
  } else {
    kulaInfo <- list_kula_palettes(type = type, print = FALSE)
  }
  kNames   <- kulaInfo$palette
  kLengths <- kulaInfo$max
  kCount   <- length(kNames)

  # Plot
  graphics::par(mfrow = c(3, ceiling(kCount/3)), mar = c(0, 0.2, 1.5, 0.2))

  for (ii in seq_along(kNames)) {
    add_kulaBar(kula = kNames[ii], range = 1:kLengths[ii], increments = 1,
                tickAxis = switch(orientation, h = 1, v = 2, 2), gridLwd = 0,
                labels = rep("", kLengths[ii]),
                tickLength = 0)
    figuR::add_axis(3, name = kNames[ii], tickLength = 0, nameCex = 0.95,
                    labels = c("", ""), nameOffset = -0.75)
  }
}

plot_kulaQ_palettes <- function(orientation = "v") {
  #' Display the kulaQ (qualitative) colour palettes
  #'
  #' @description Plot all the possible kulaQ palettes to compare & select from.
  #'
  #' @inheritParams plot_kula_palettes
  #' @export

  # Code -----------------------------------------------------------------------
  plot_kula_palettes(orientation = orientation, type = "qualitative")
}

plot_kulaS_palettes <- function(orientation = "v") {
  #' Display the kulaS (sequential) colour palettes
  #'
  #' @description Plot all the possible kulaS palettes to compare & select from.
  #'
  #' @inheritParams plot_kula_palettes
  #' @export

  # Code -----------------------------------------------------------------------
  plot_kula_palettes(orientation = orientation, type = "sequential")
}

plot_kulaD_palettes <- function(orientation = "v") {
  #' Display the kulaD (diverging) colour palettes
  #'
  #' @description Plot all the possible kulaD palettes to compare & select from.
  #'
  #' @inheritParams plot_kula_palettes
  #' @export

  # Code -----------------------------------------------------------------------
  plot_kula_palettes(orientation = orientation, type = "diverging")
}

plot_kulaC_palettes <- function(orientation = "v") {
  #' Display the kulaC (circular) colour palettes
  #'
  #' @description Plot all the possible kulaC palettes to compare & select from.
  #'
  #' @inheritParams plot_kula_palettes
  #' @export

  # Code -----------------------------------------------------------------------
  plot_kula_palettes(orientation = orientation, type = "circular")
}
