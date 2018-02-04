
<!-- README.md is generated from README.Rmd. Please edit that file -->

# zscorer: Weight-for-age, height-for-age and weight-for-height z-score calculator

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/zscorer)](https://cran.r-project.org/package=zscorer)
[![Travis-CI Build
Status](https://travis-ci.org/nutriverse/zscorer.svg?branch=master)](https://travis-ci.org/nutriverse/zscorer)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/nutriverse/zscorer?branch=master&svg=true)](https://ci.appveyor.com/project/nutriverse/zscorer)
[![codecov](https://codecov.io/gh/nutriverse/zscorer/branch/master/graph/badge.svg)](https://codecov.io/gh/nutriverse/zscorer)

`zscorer` facilitates the calculation of `z-scores` (i.e. the number of
standard deviations from the mean) for the three key anthropometric
indices used to assess early childhood growth: `weight-for-age (WFA)`,
`height-for-age (HFA)` and `weight-for-height (WFH)`. `zscorer` refers
to the results of the **WHO Multicentre Growth Reference Study** as
standard for calculating the `z-scores` hence it comes packaged with
this reference data.

`zscorer` can be used to calculate the appropriate `z-score` for the
corresponding anthropometric index for a single child to assess growth
and nutritional status against the standard. It can also be used to
calculate the `z-scores` for an entire cohort or sample of children
(such as in nutrition surveys) to allow for assessing the nutritional
status of the entire child population.

## Installation

You can install `zscorer` from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("nutriverse/zscorer")
```

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
head(waz, 100)
#>   [1] -0.75605549 -1.39021503 -1.05597853  1.41575096 -2.67757242
#>   [6]  1.49238050 -0.12987704 -0.02348159 -1.50647344 -1.54381630
#>  [11] -2.87495712 -0.43497240 -1.03899540 -1.69281855 -1.31245898
#>  [16] -2.21003260 -0.01189226 -0.90917762 -0.67839855 -0.94746695
#>  [21] -2.49960425 -0.95659644 -1.65442686 -1.25052760  0.67335751
#>  [26]  0.30156301  0.24261346 -2.78670709 -1.15820651 -1.15477183
#>  [31] -1.35540820 -0.59134959 -4.14967218 -0.45748752 -0.74331669
#>  [36] -1.69725836 -1.05745067 -0.18869508 -0.42095770 -2.21030414
#>  [41] -1.30536715 -3.63778143 -0.60662526 -0.54360470 -1.59171780
#>  [46] -1.74745738 -0.34803338  0.69896149 -0.74467130  0.18924572
#>  [51] -1.48108856 -1.95753145 -1.31191261  0.30155484 -0.75789033
#>  [56] -1.22636337 -1.27478781 -0.14553210 -1.30480818 -1.96209188
#>  [61] -1.92834685 -1.04554156 -1.39728978 -1.48108856 -0.74937250
#>  [66] -1.12503757 -2.77630042 -0.19882637  0.04219576 -0.52194533
#>  [71] -1.46503158  0.85408718 -1.63719475  0.31409860 -0.81222767
#>  [76] -1.00226314 -0.44722087 -1.17228171 -2.15312212 -1.81820158
#>  [81] -1.13196874 -2.86880551 -0.73555123 -2.43022105 -2.87277187
#>  [86] -0.94346572 -2.74866250 -2.55061273 -1.96711064 -3.36531123
#>  [91]  0.74108076  0.23397040 -1.16961511 -1.54368475 -0.50193697
#>  [96] -2.80497696 -1.89582784 -1.71342724 -1.87269440 -1.64834830

# height-for-age z-score
haz <- getCohortWGS(data = anthro1,
                    sexObserved = "sex",
                    firstPart = "height",
                    secondPart = "age",
                    index = "hfa")
head(haz, 100)
#>   [1] -1.2258169 -2.3475886 -2.9518041 -0.2812852 -4.2056663 -0.5387678
#>   [7] -2.4020719 -1.0317699 -2.7410884 -4.7037571 -2.5670550 -2.1144960
#>  [13] -2.2323505 -2.3155458 -2.7516165 -2.7930694  0.1121349 -1.9001797
#>  [19] -2.9543730 -1.9671042 -3.8716522  0.8667206 -2.8252069 -2.1412285
#>  [25] -2.7994643  0.5496459 -1.4372002 -3.7979410 -2.5661752 -1.8301183
#>  [31] -1.6548589 -2.7110333 -3.6399642 -1.7955069 -1.6775100 -1.0317699
#>  [37] -0.4356881 -1.2660152  0.4990326 -4.6085660 -3.1662351 -1.0695930
#>  [43] -1.8477936 -2.5502314 -1.8301183 -2.2755493 -3.2816532  0.4876774
#>  [49] -2.4396410 -0.4794744 -2.4504293 -3.2053429 -3.7694306 -0.2775228
#>  [55] -0.3653868 -2.5815827 -1.7775775 -0.9547536 -2.9599613 -3.1402709
#>  [61] -2.3778709 -2.1873064 -2.5585381 -2.1806622 -3.2376529 -2.2634845
#>  [67] -4.2000053 -0.2809011 -3.5180432 -0.2437781 -1.0543764  0.1812499
#>  [73] -2.4859766 -1.6141514 -2.9928210 -2.4559038 -1.9683112 -1.2081507
#>  [79] -2.3460874 -2.1919714 -2.6264961 -4.6629238 -2.2110628 -3.9605986
#>  [85] -3.1007498 -4.5234491 -1.4755486 -0.3554714 -2.5744381 -1.8393933
#>  [91] -1.4619629  2.2883058 -2.7007990 -2.4477333 -1.4001563 -2.8679887
#>  [97] -2.9823031 -3.3465111 -4.0111758 -3.2849746

# weight-for-height z-score
whz <- getCohortWGS(data = anthro1,
                    sexObserved = "sex",
                    firstPart = "weight",
                    secondPart = "height",
                    index = "wfh")
head(whz, 100)
#>   [1]  0.05572347 -0.01974903  0.57469112  2.06231749 -0.14080044
#>   [6]  2.49047246  1.83315197  0.93614891  0.18541943  2.11599287
#>  [11] -1.96943887  1.06351047  0.35315830 -0.61151003 -0.01049441
#>  [16] -0.75038993 -0.08000322  0.31277573  1.56456175  0.22152087
#>  [21] -0.08798757 -2.14197877 -0.30804823  0.00778227  3.21041413
#>  [26]  0.07434468  1.40966986 -0.81485050  0.63816647 -0.33540392
#>  [31] -0.61955533  1.35716952 -2.77364671  1.00831095  0.32842063
#>  [36] -1.66705281 -1.21157702  0.89024472 -0.89865037  0.82166393
#>  [41]  0.64442137 -4.39847850  0.38411140  1.48299847 -0.93068495
#>  [46] -0.88558228  1.69551410  0.65143649  0.61269397  0.59813891
#>  [51] -0.16870101 -0.46773224  1.13627735  0.54232333 -0.80009135
#>  [56]  0.47707364 -0.25223237  0.66626720  0.66470505 -0.56540523
#>  [61] -0.89349250  0.37679942 -0.24183183 -0.41797799  1.97179223
#>  [66]  0.34774287 -0.12696756 -0.02952866  2.29889761 -0.56117231
#>  [71] -1.31702435  1.14195630 -0.07450720  1.74085848  1.53381730
#>  [76]  0.59110113  0.95232463 -0.81485050 -1.04399868 -0.91463927
#>  [81]  0.16190475  0.12223112  0.90273984  0.01878726 -1.87000837
#>  [86]  2.12145198 -2.71413265 -3.48161993 -0.77282038 -3.16923427
#>  [91]  2.52441543 -1.38629620  0.67083591 -0.49272967  0.50468135
#>  [96] -1.84875292 -0.07768210  0.58570137  1.40004194  0.44765879
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
head(zScores, 100)
#>          waz        haz         whz
#> 1   52.11058 -1.2258169  0.05572347
#> 2   23.69196 -2.3475886 -0.01974903
#> 3   36.83357 -2.9518041  0.57469112
#> 4   44.50625 -0.2812852  2.06231749
#> 5   22.23409 -4.2056663 -0.14080044
#> 6   28.62613 -0.5387678  2.49047246
#> 7   28.57230 -2.4020719  1.83315197
#> 8   27.95984 -1.0317699  0.93614891
#> 9   33.29595 -2.7410884  0.18541943
#> 10  20.96054 -4.7037571  2.11599287
#> 11  37.44455 -2.5670550 -1.96943887
#> 12  26.49212 -2.1144960  1.06351047
#> 13  28.46469 -2.2323505  0.35315830
#> 14  30.68077 -2.3155458 -0.61151003
#> 15  41.58309 -2.7516165 -0.01049441
#> 16  20.89617 -2.7930694 -0.75038993
#> 17  49.85371  0.1121349 -0.08000322
#> 18  22.67899 -1.9001797  0.31277573
#> 19  31.46045 -2.9543730  1.56456175
#> 20  27.94282 -1.9671042  0.22152087
#> 21  26.05087 -3.8716522 -0.08798757
#> 22  28.67434  0.8667206 -2.14197877
#> 23  32.08272 -2.8252069 -0.30804823
#> 24  36.55059 -2.1412285  0.00778227
#> 25  32.68618 -2.7994643  3.21041413
#> 26  55.56327  0.5496459  0.07434468
#> 27  28.25901 -1.4372002  1.40966986
#> 28  31.09443 -3.7979410 -0.81485050
#> 29  27.10811 -2.5661752  0.63816647
#> 30  45.73745 -1.8301183 -0.33540392
#> 31  47.46368 -1.6548589 -0.61955533
#> 32  30.49471 -2.7110333  1.35716952
#> 33  36.45731 -3.6399642 -2.77364671
#> 34  19.48607 -1.7955069  1.00831095
#> 35  29.28168 -1.6775100  0.32842063
#> 36  27.95984 -1.0317699 -1.66705281
#> 37  28.79382 -0.4356881 -1.21157702
#> 38  28.00121 -1.2660152  0.89024472
#> 39  41.66338  0.4990326 -0.89865037
#> 40  27.15717 -4.6085660  0.82166393
#> 41  29.97193 -3.1662351  0.64442137
#> 42  45.74038 -1.0695930 -4.39847850
#> 43  40.58138 -1.8477936  0.38411140
#> 44  20.17669 -2.5502314  1.48299847
#> 45  45.73745 -1.8301183 -0.93068495
#> 46  34.18964 -2.2755493 -0.88558228
#> 47  31.39212 -3.2816532  1.69551410
#> 48  40.98603  0.4876774  0.65143649
#> 49  44.01499 -2.4396410  0.61269397
#> 50  36.38466 -0.4794744  0.59813891
#> 51  30.47350 -2.4504293 -0.16870101
#> 52  32.76258 -3.2053429 -0.46773224
#> 53  32.17842 -3.7694306  1.13627735
#> 54  31.60627 -0.2775228  0.54232333
#> 55  23.00993 -0.3653868 -0.80009135
#> 56  25.79149 -2.5815827  0.47707364
#> 57  19.79818 -1.7775775 -0.25223237
#> 58  24.93181 -0.9547536  0.66626720
#> 59  25.95858 -2.9599613  0.66470505
#> 60  41.54231 -3.1402709 -0.56540523
#> 61  31.89756 -2.3778709 -0.89349250
#> 62  21.96671 -2.1873064  0.37679942
#> 63  39.39069 -2.5585381 -0.24183183
#> 64  30.88804 -2.1806622 -0.41797799
#> 65  21.70201 -3.2376529  1.97179223
#> 66  34.06161 -2.2634845  0.34774287
#> 67  24.83162 -4.2000053 -0.12696756
#> 68  28.63254 -0.2809011 -0.02952866
#> 69  37.78326 -3.5180432  2.29889761
#> 70  37.30804 -0.2437781 -0.56117231
#> 71  39.17631 -1.0543764 -1.31702435
#> 72  25.18699  0.1812499  1.14195630
#> 73  26.81062 -2.4859766 -0.07450720
#> 74  31.75857 -1.6141514  1.74085848
#> 75  18.76559 -2.9928210  1.53381730
#> 76  26.02975 -2.4559038  0.59110113
#> 77  30.39508 -1.9683112  0.95232463
#> 78  42.93993 -1.2081507 -0.81485050
#> 79  19.18198 -2.3460874 -1.04399868
#> 80  31.29767 -2.1919714 -0.91463927
#> 81  42.42309 -2.6264961  0.16190475
#> 82  24.18661 -4.6629238  0.12223112
#> 83  20.56158 -2.2110628  0.90273984
#> 84  21.06187 -3.9605986  0.01878726
#> 85  41.61006 -3.1007498 -1.87000837
#> 86  41.02613 -4.5234491  2.12145198
#> 87  33.69128 -1.4755486 -2.71413265
#> 88  23.76370 -0.3554714 -3.48161993
#> 89  30.70601 -2.5744381 -0.77282038
#> 90  40.33764 -1.8393933 -3.16923427
#> 91  23.96765 -1.4619629  2.52441543
#> 92  42.15041  2.2883058 -1.38629620
#> 93  25.62470 -2.7007990  0.67083591
#> 94  33.92537 -2.4477333 -0.49272967
#> 95  22.53476 -1.4001563  0.50468135
#> 96  33.70918 -2.8679887 -1.84875292
#> 97  19.07025 -2.9823031 -0.07768210
#> 98  25.62220 -3.3465111  0.58570137
#> 99  38.79007 -4.0111758  1.40004194
#> 100 31.41665 -3.2849746  0.44765879
```

Applying the `getAllWGS()` function results in a data frame of
calculated `z-scores` for all children in the cohort or sample for all
the anthropometric indices.
