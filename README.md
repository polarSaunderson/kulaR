# kulaR

## Overview
`kulaR` is largely a wrapper around the [khroma](https://packages.tesselle.org/khroma/index.html) package to automates common tasks when selecting and using colours in R.
It builds off the existing colour palettes in `khroma`, which are all colourblind friendly, but provides an alternative, unified syntax for using the palettes. 
There are also capabilities of creating better automated colour schemes, and to add custom colour bars and legends.

**Note** `kulaR` is the first R package that I have created and will likely have issues. It is currently being tested.

## Instructions
This package is mainly a personal package, so it is not available on CRAN.
To download this package directly from GitHub, you'll need to use the "devtools" package.
It's easiest to do this within RStudio.

1) Install the [devtools](https://github.com/hadley/devtools) and [khroma](https://packages.tesselle.org/khroma/) packages from CRAN. 
``` R
install.packages("devtools")
install.packages("khroma")
```

2) Load the devtools package:
```R
library(devtools)
```

3) Install kulaR directly from GitHub.
```R
devtools::install_github("polarSaunderson/kulaR")
```

4) Load the kulaR package
```R
library(kulaR)
```
