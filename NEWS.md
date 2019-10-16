# zscorer 0.3.1

Fourth release of `zscorer`. In this release:

* fixed an issue when calculating BMI-for-age where measurements are 0 resulting in error rather than providing an NA value. Now, when values for measurements are 0, the zscore produced is NA.

* updated MUAC for age to allow for calculation for children up to 19 years old based on article by Jay Berkeley and colleagues.

* updated documentation to reflect editions and additions

# zscorer 0.3.0

Third release of `zscorer`. In this release:

* fixed a bug when using `zscorer` functions `addWGSR()` and `getWGSR()` inside another package in which `wgsrData` referred to by both functions and which is included as an external dataset is not lazy loaded. `wgsrData` is now added as an internal dataset

* fixed some documentation formatting.

* removed old hex sticker and added new hex sticker

# zscorer 0.2.0

Second release of `zscorer`. In this release:

* created overall function to calculate all anthropometric indices included in the WHO Growth Standards;

* updated README to illustrate use of main overall function for calculating anthropometric indices;

* added vignettes to describe calculation of anthropometric indices

* update Shiny application


# zscorer 0.1.0

Initial release of `zscorer`
