# zscorer 0.3.0

Third release of `zscorer`. In this release:

* fixed a bug when using `zscorer` functions `addWGSR()` and `getWGSR()` inside another package in which `wgsrData` referred to by both functions and which is included as an external dataset is not lazy loaded. `wgsrData` is now added as an internal dataset

* fixed some documentation formatting.

# zscorer 0.2.0

Second relase of `zscorer`. In this release:

* created overall function to calculate all anthropometric indices included in the WHO Growth Standards;

* updated README to illustrate use of main overall function for calculating anthropometric indices;

* added vignettes to describe calculation of anthropometric indices

* udpate Shiny application


# zscorer 0.1.0

Initial release of `zscorer`
