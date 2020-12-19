## Libraries
library(pdftools)
library(magrittr)
library(stringr)
library(dplyr)

## Reference data link
refData <- "https://www.cdc.gov/nccdphp/dnpao/growthcharts/resources/CDCref_d.csv"

## Read reference data
x <- read.csv(refData)


cdcData <- rbind(wfa, x2, x7, x3, x5, x4, x8)
write.csv(cdcData, "data-raw/cdcData.csv", row.names = FALSE)
