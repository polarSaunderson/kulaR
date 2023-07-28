# kulaR

## Overview
The kulaR package is largely a wrapper around the "khroma"  package to automate common tasks with colours in R. 
It builds off the existing colour palettes in khroma, which are all colourblind friendly, but provides a common syntax for using them. 
It also has capabilities of creating better automated colour schemes, and adding legends.
This package is the first R package that I have created and will likely have issues at the beginning.

## Instructions
This package is mainly a personal package, so it is not available on CRAN.
To download this package directly from GitHub, you'll need to use the "devtools" package.
It's easiest to do this within RStudio.

1) Install the [devtools](https://github.com/hadley/devtools) package from CRAN. 
`install.packages("devtools")`

2) Load the devtools package:
`library(devtools)'

3) Install kulaR directly from GitHub.
`install_github("polarSaunderson/kulaR")`

4) Load the kulaR package
`library(kulaR)`
