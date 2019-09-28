## Release summary
Third release of `zscorer`. In this release:

* fixed a bug when using `zscorer` functions `addWGSR()` and `getWGSR()` inside another package in which `wgsrData` referred to by both functions and which is included as an external dataset is not lazy loaded. `wgsrData` is now added as an internal dataset

* fixed some documentation formatting.

* removed old hex sticker and added new hex sticker

* improved Shiny app interface

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
