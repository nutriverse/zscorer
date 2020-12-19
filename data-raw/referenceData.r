## Read WGS Reference data
wgsrData <- read.csv("data-raw/wgsrData.csv")

## Read CDC Reference data
cdcData <- read.csv("data-raw/cdcData.csv")

referenceData <- list(wgs = wgsrData, cdc = cdcData)
usethis::use_data(referenceData, internal = TRUE,
                  overwrite = TRUE, compress = "xz")
