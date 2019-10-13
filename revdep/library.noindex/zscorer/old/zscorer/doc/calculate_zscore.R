## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

if(!require(zscorer)) install.packages("zscorer")


## ----usage1, echo = TRUE, eval = FALSE-----------------------------------
#  head(anthro3)

## ----usage1a, echo = FALSE, eval = TRUE----------------------------------
head(anthro3)

## ----usage2, echo = TRUE, eval = TRUE------------------------------------
svy <- addWGSR(data = anthro3, sex = "sex", firstPart = "weight",
               secondPart = "height", index = "wfh")

## ----usage2a, echo = FALSE, eval = TRUE----------------------------------
head(svy)

## ----usage2b, echo = TRUE, eval = FALSE----------------------------------
#  ?addWGSR

## ----usage3, echo = TRUE, eval = TRUE------------------------------------
table(is.na(svy$wfhz))

## ----usage4, echo = TRUE, eval = TRUE------------------------------------
svy[is.na(svy$wfhz), ]

## ----usage5, echo = TRUE, eval = TRUE------------------------------------
svy <- addWGSR(data = svy, sex = "sex", firstPart = "weight", 
               secondPart = "age", index = "wfa")

## ----usage5a, echo = TRUE, eval = TRUE-----------------------------------
summary(svy$wfaz)

## ----usage5b, echo = TRUE, eval = TRUE-----------------------------------
svy$age <- svy$age * (365.25 / 12)
head(svy)

## ----usage5c, echo = TRUE, eval = TRUE-----------------------------------
svy <- addWGSR(data = svy, sex = "sex", firstPart = "weight", 
               secondPart = "age", index = "wfa")
head(svy)
summary(svy$wfaz)

## ----usage6, echo = TRUE, eval = TRUE------------------------------------
svy$muac <- svy$muac / 10
head(svy)

## ----usage6a, echo = TRUE, eval = TRUE-----------------------------------
svy <- addWGSR(svy, sex = "sex", firstPart = "muac",	
               secondPart = "age", index = "mfa")
head(svy)

## ----usage7, echo = TRUE, eval = TRUE------------------------------------
svy <- addWGSR(data = svy, sex = "sex", firstPart = "weight", 
               secondPart = "height", thirdPart = "age", index = "bfa", 
               output = "bmiAgeZ", digits = 4)
head(svy)

## ----example1, eval = TRUE-----------------------------------------------
# weight-for-age z-score
waz <- getWGS(sexObserved = 1,     # 1 = Male / 2 = Female
              firstPart = 14.6,    # Weight in kilograms up to 1 decimal place
              secondPart = 52,     # Age in whole months
              index = "wfa")       # Anthropometric index (weight-for-age)

waz

# height-for-age z-score
haz <- getWGS(sexObserved = 1,
              firstPart = 98,      # Height in centimetres
              secondPart = 52,
              index = "hfa")       # Anthropometric index (height-for-age)

haz

# weight-for-height z-score
whz <- getWGS(sexObserved = 1,
              firstPart = 14.6,
              secondPart = 98,
              index = "wfh")       # Anthropometric index (weight-for-height)

whz

## ----sample-data1, eval = FALSE------------------------------------------
#  # Make a call for the anthro1 dataset
#  anthro1

## ---- echo = FALSE, eval = TRUE------------------------------------------
library(zscorer)

## ----sample-data2, eval = TRUE-------------------------------------------
head(anthro1)

## ----example2, eval = TRUE-----------------------------------------------
# weight-for-age z-score
waz <- getCohortWGS(data = anthro1,
                    sexObserved = "sex",
                    firstPart = "weight",
                    secondPart = "age",
                    index = "wfa")
head(waz, 50)

# height-for-age z-score
haz <- getCohortWGS(data = anthro1,
                    sexObserved = "sex",
                    firstPart = "height",
                    secondPart = "age",
                    index = "hfa")
head(haz, 50)

# weight-for-height z-score
whz <- getCohortWGS(data = anthro1,
                    sexObserved = "sex",
                    firstPart = "weight",
                    secondPart = "height",
                    index = "wfh")
head(whz, 50)

## ----example3, eval = TRUE-----------------------------------------------
# weight-for-age z-score
zScores <- getAllWGS(data = anthro1,
                     sex = "sex",
                     weight = "weight",
                     height = "height",
                     age = "age",
                     index = "all")
head(zScores, 20)

