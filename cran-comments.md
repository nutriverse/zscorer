## Release summary
Fourth release of `zscorer`. In this release:

* fixed an issue when calculating BMI-for-age where measurements are 0 resulting in error rather than providing an NA value. Now, when values for measurements are 0, the zscore produced is NA.

* updated MUAC for age to allow for calculation for children up to 19 years old based on article by Jay Berkeley and colleagues.

* updated documentation to reflect editions and additions

## Test environments
* local OS X install, R 3.6.1
* ubuntu 16.04.6 (on travis-ci), release, devel and oldrelease
* local ubuntu 16.04 install, R 3.6.1
* win-builder (devel and release)
* windows (on appveyor), x64 release and devel, i386 release and devel

## R CMD check results

0 errors | 0 warnings | 0 notes

## Reverse dependencies
`zscorer` doesn't have any downstream / reverse dependencies 
(see https://github.com/nutriverse/zscorer/tree/master/revdep)
