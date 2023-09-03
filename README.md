# kulaR

**PRIVATE BRANCH OF THE pkg02_kulaR PACKAGE**

## Overview
The kulaR package is largely a wrapper around the [khroma](https://packages.tesselle.org/khroma/index.html) package to automate common tasks with colours in R. 
It builds off the existing colour palettes in khroma, which are all colourblind friendly, but provides a common syntax for using them. 
It also has capabilities of creating better automated colour schemes, and adding legends.
This package is the first R package that I have created and will likely have issues at the beginning.

## Public Version
The public version of this repo can be accessed at:
  https://github.com/polarSaunderson/kulaR

## To-Do
### 2023-08-26
- [ ] Improve documentation where necessary

### 2023-07-28
- [X] Create add_kula_bar 
  - [X] Work on associated text / annotation functions
- [X] Figure out the link between this package & domR (e.g. pre_plot, add_axis)
- [X] Add the plot_kula_palettes functions
- [ ] Fix the part of kulaK that doesn't work great
  - I forget exactly which issue, revisit the Obsidian notes
  - Maybe when using an odd number of colours and skipping or subsetting (?)
- [ ] Expand on the package documentation for a fuller overview
