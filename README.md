
<!-- README.md is generated from README.Rmd. Please edit that file -->

# zscorer: Weight-for-age, height-for-age, weight-for-height, BMI-for-age, head circumference-for-age, arm circumference-for-age, subscapular skinfold-for-age and

triceps skinfold-for-age z-score calculator
<img src="man/figures/zscorer.png" align="right" />

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/zscorer)](https://cran.r-project.org/package=zscorer)
[![CRAN](https://img.shields.io/cran/l/zscorer.svg)](https://CRAN.R-project.org/package=zscorer)
[![CRAN](http://cranlogs.r-pkg.org/badges/zscorer)](https://CRAN.R-project.org/package=zscorer)
[![CRAN](http://cranlogs.r-pkg.org/badges/grand-total/zscorer)](https://CRAN.R-project.org/package=zscorer)
[![Travis-CI Build
Status](https://travis-ci.org/nutriverse/zscorer.svg?branch=master)](https://travis-ci.org/nutriverse/zscorer)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/nutriverse/zscorer?branch=master&svg=true)](https://ci.appveyor.com/project/nutriverse/zscorer)
[![codecov](https://codecov.io/gh/nutriverse/zscorer/branch/master/graph/badge.svg)](https://codecov.io/gh/nutriverse/zscorer)
[![DOI](https://zenodo.org/badge/119683584.svg)](https://zenodo.org/badge/latestdoi/119683584)

`zscorer` facilitates the calculation of `z-scores` (i.e. the number of
standard deviations from the mean) for key anthropometric indices used
to assess early childhood growth: `weight-for-age (WFA)`,
`height-for-age (HFA)`, `weight-for-height (WFH)`, `BMI-for-age (BFA)`,
`arm circumference-for-age (ACFA)`, `head circumference-for-age (HCFA)`,
`subscapular skinfold-for-age (SSFA)` and `triceps skinfold-for-age
(TSFA)`. `zscorer` refers to the results of the **WHO Multicentre Growth
Reference Study** as standard for calculating the `z-scores` hence it
comes as a dataset in this package.

`zscorer` can be used to calculate the appropriate `z-score` for the
corresponding anthropometric index for a single child to assess growth
and nutritional status against the standard. It can also be used to
calculate the `z-scores` for an entire cohort or sample of children
(such as in nutrition surveys) to allow for assessing the nutritional
status of the entire child population.

## Installation

You can install `zscorer` from CRAN:

``` r
install.packages("zscorer")
```

or you can install the development version of `zscorer` from GitHub
with:

``` r
if(require(devtools) { install.packages("devtools") }
devtools::install_github("nutriverse/zscorer")
```

then load `zscorer`

``` r
# load package
library(zscorer)
```

## Usage

### Calculating z-score for each of the three anthropometric indices for a single child

For this example, we will use the `getWGS()` function and apply it to
dummy data of a **52 month** old male child with a weight of **14.6 kg**
and a height of **98.0 cm**.

``` r
# weight-for-age z-score
waz <- getWGS(sexObserved = 1,     # 1 = Male / 2 = Female
              firstPart = 14.6,    # Weight in kilograms up to 1 decimal place
              secondPart = 52,     # Age in whole months
              index = "wfa")       # Anthropometric index (weight-for-age)

waz
#> [1] -1.187651

# height-for-age z-score
haz <- getWGS(sexObserved = 1,
              firstPart = 98,      # Height in centimetres
              secondPart = 52,
              index = "hfa")       # Anthropometric index (height-for-age)

haz
#> [1] -1.741175

# weight-for-height z-score
whz <- getWGS(sexObserved = 1,
              firstPart = 14.6,
              secondPart = 98,
              index = "wfh")       # Anthropometric index (weight-for-height)

whz
#> [1] -0.1790878
```

Applying the `getWGS()` function results in a calculated `z-score` for
one
child.

### Calculating z-score for each of the three anthropometric indices for a cohort or sample of children

For this example, we will use the `getCohortWGS()` function and apply it
to sample data `anthro1` that came with `zscorer`.

``` r
# Make a call for the anthro1 dataset
anthro1
```

As you will see, this dataset has the 4 variables you will need to use
with `getCohortWGS()` to calculate the `z-score` for the corresponding
anthropometric index. These are `age`, `sex`, `weight` and `height`.

``` r
head(anthro1)
#>   psu age sex weight height muac oedema   haz   waz   whz flag
#> 1   1   6   1    7.3   65.0  146      2 -1.23 -0.76  0.06    0
#> 2   1  42   2   12.5   89.5  156      2 -2.35 -1.39 -0.02    0
#> 3   1  23   1   10.6   78.1  149      2 -2.95 -1.06  0.57    0
#> 4   1  18   1   12.8   81.5  160      2 -0.28  1.42  2.06    0
#> 5   1  52   1   12.1   87.3  152      2 -4.21 -2.68 -0.14    0
#> 6   1  36   2   16.9   93.0  190      2 -0.54  1.49  2.49    0
```

To calculate the three anthropometric indices for all the children in
the sample, we execute the following commands in R:

``` r
# weight-for-age z-score
waz <- getCohortWGS(data = anthro1,
                    sexObserved = "sex",
                    firstPart = "weight",
                    secondPart = "age",
                    index = "wfa")
head(waz, 50)
#>  [1] -0.75605549 -1.39021503 -1.05597853  1.41575096 -2.67757242
#>  [6]  1.49238050 -0.12987704 -0.02348159 -1.50647344 -1.54381630
#> [11] -2.87495712 -0.43497240 -1.03899540 -1.69281855 -1.31245898
#> [16] -2.21003260 -0.01189226 -0.90917762 -0.67839855 -0.94746695
#> [21] -2.49960425 -0.95659644 -1.65442686 -1.25052760  0.67335751
#> [26]  0.30156301  0.24261346 -2.78670709 -1.15820651 -1.15477183
#> [31] -1.35540820 -0.59134959 -4.14967218 -0.45748752 -0.74331669
#> [36] -1.69725836 -1.05745067 -0.18869508 -0.42095770 -2.21030414
#> [41] -1.30536715 -3.63778143 -0.60662526 -0.54360470 -1.59171780
#> [46] -1.74745738 -0.34803338  0.69896149 -0.74467130  0.18924572

# height-for-age z-score
haz <- getCohortWGS(data = anthro1,
                    sexObserved = "sex",
                    firstPart = "height",
                    secondPart = "age",
                    index = "hfa")
head(haz, 50)
#>  [1] -1.2258169 -2.3475886 -2.9518041 -0.2812852 -4.2056663 -0.5387678
#>  [7] -2.4020719 -1.0317699 -2.7410884 -4.7037571 -2.5670550 -2.1144960
#> [13] -2.2323505 -2.3155458 -2.7516165 -2.7930694  0.1121349 -1.9001797
#> [19] -2.9543730 -1.9671042 -3.8716522  0.8667206 -2.8252069 -2.1412285
#> [25] -2.7994643  0.5496459 -1.4372002 -3.7979410 -2.5661752 -1.8301183
#> [31] -1.6548589 -2.7110333 -3.6399642 -1.7955069 -1.6775100 -1.0317699
#> [37] -0.4356881 -1.2660152  0.4990326 -4.6085660 -3.1662351 -1.0695930
#> [43] -1.8477936 -2.5502314 -1.8301183 -2.2755493 -3.2816532  0.4876774
#> [49] -2.4396410 -0.4794744

# weight-for-height z-score
whz <- getCohortWGS(data = anthro1,
                    sexObserved = "sex",
                    firstPart = "weight",
                    secondPart = "height",
                    index = "wfh")
head(whz, 50)
#>  [1]  0.05572347 -0.01974903  0.57469112  2.06231749 -0.14080044
#>  [6]  2.49047246  1.83315197  0.93614891  0.18541943  2.11599287
#> [11] -1.96943887  1.06351047  0.35315830 -0.61151003 -0.01049441
#> [16] -0.75038993 -0.08000322  0.31277573  1.56456175  0.22152087
#> [21] -0.08798757 -2.14197877 -0.30804823  0.00778227  3.21041413
#> [26]  0.07434468  1.40966986 -0.81485050  0.63816647 -0.33540392
#> [31] -0.61955533  1.35716952 -2.77364671  1.00831095  0.32842063
#> [36] -1.66705281 -1.21157702  0.89024472 -0.89865037  0.82166393
#> [41]  0.64442137 -4.39847850  0.38411140  1.48299847 -0.93068495
#> [46] -0.88558228  1.69551410  0.65143649  0.61269397  0.59813891
```

Applying the `getCohortWGS()` function results in a vector of calculated
`z-scores` for all children in the cohort or
sample.

### Calculating z-scores for all of the three anthropometric indices in one function

For this example, we will use the `getAllWGS()` function and apply it to
sample data `anthro1` that came with `zscorer`.

``` r
# weight-for-age z-score
zScores <- getAllWGS(data = anthro1,
                     sex = "sex",
                     weight = "weight",
                     height = "height",
                     age = "age",
                     index = "all")
head(zScores, 20)
#>            waz        haz         whz
#> 1  -0.75605549 -1.2258169  0.05572347
#> 2  -1.39021503 -2.3475886 -0.01974903
#> 3  -1.05597853 -2.9518041  0.57469112
#> 4   1.41575096 -0.2812852  2.06231749
#> 5  -2.67757242 -4.2056663 -0.14080044
#> 6   1.49238050 -0.5387678  2.49047246
#> 7  -0.12987704 -2.4020719  1.83315197
#> 8  -0.02348159 -1.0317699  0.93614891
#> 9  -1.50647344 -2.7410884  0.18541943
#> 10 -1.54381630 -4.7037571  2.11599287
#> 11 -2.87495712 -2.5670550 -1.96943887
#> 12 -0.43497240 -2.1144960  1.06351047
#> 13 -1.03899540 -2.2323505  0.35315830
#> 14 -1.69281855 -2.3155458 -0.61151003
#> 15 -1.31245898 -2.7516165 -0.01049441
#> 16 -2.21003260 -2.7930694 -0.75038993
#> 17 -0.01189226  0.1121349 -0.08000322
#> 18 -0.90917762 -1.9001797  0.31277573
#> 19 -0.67839855 -2.9543730  1.56456175
#> 20 -0.94746695 -1.9671042  0.22152087
```

Applying the `getAllWGS()` function results in a data frame of
calculated `z-scores` for all children in the cohort or sample for all
the anthropometric indices.
