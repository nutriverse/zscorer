##
#library(mchtoolbox)

## Read NHANES data
#x <- read.csv("data-raw/nhanes.csv")

#y <- create_cdc_growth(df = x)

#nhanes <- y[ , c("cid", "sex", "agemos", "weight", "height", "headcir", "bmi", "waz", "bmiz")]

#write.csv(nhanes, "data-raw/nhanes_data.csv", row.names = FALSE)

nhanes <- read.csv("data-raw/nhanes_data.csv")

usethis::use_data(nhanes, overwrite = TRUE, compress = "xz")


