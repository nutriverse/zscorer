##
library(AGD)

## Read NHANES data
x <- read.csv("data-raw/nhanes.csv")

x$bmi <- with(x, ifelse(agemos < 2, NA, weight / ((height / 100) ^ 2)))
x$agecat <- with(x, ifelse(agemos >= 0 & agemos < 0.5, 0, as.integer(agemos + 0.5) - 0.5))
x$charsex <- with(x, ifelse(sex == 1, "M", "F"))

## Calculate weight-for-age z-scores
waz <- with(x, y2z(y = weight / 1000, x = agecat, sex = charsex, ref = cdc.wgt, dec = 6))
haz <- with(x, y2z(y = height, x = agecat, sex = charsex, ref = cdc.hgt, dec = 6))
baz <- with(x, y2z(y = bmi, x = agecat, sex = charsex, ref = cdc.bmi, dec = 6))

nhanes <- data.frame(x[ , c("cid", "sex", "agemos", "weight", "height", "headcir", "bmi")],
                     waz, haz, baz)

usethis::use_data(nhanes, overwrite = TRUE, compress = "xz")
