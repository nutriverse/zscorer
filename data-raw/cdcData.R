## Libraries

## URLs for data files

wtageinf  <- "https://www.cdc.gov/growthcharts/data/zscore/wtageinf.csv"
lenageinf <- "https://www.cdc.gov/growthcharts/data/zscore/lenageinf.csv"
wtleninf  <- "https://www.cdc.gov/growthcharts/data/zscore/wtleninf.csv"
hcageinf  <- "https://www.cdc.gov/growthcharts/data/zscore/hcageinf.csv"
wtstat    <- "https://www.cdc.gov/growthcharts/data/zscore/wtstat.csv"
wtage     <- "https://www.cdc.gov/growthcharts/data/zscore/wtage.csv"
statage   <- "https://www.cdc.gov/growthcharts/data/zscore/statage.csv"
bmiage    <- "https://www.cdc.gov/growthcharts/data/zscore/bmiagerev.csv"


## Read data ###################################################################

## Weight-for-age infant
x1 <- read.csv(wtageinf)

## Length-for-age infant
x2 <- read.csv(lenageinf)

## Weight-for-length infant
x3 <- read.csv(wtleninf)

## Head circumference for age infant
x4 <- read.csv(hcageinf)

## Weight-for-height
x5 <- read.csv(wtstat)

## Weight-for-age
x6 <- read.csv(wtage)

## Height-for-age
x7 <- read.csv(statage)

## BMI for age
x8 <- read.csv(bmiage)


## Combine and structure CDC 2000 reference standards data #####################

## Weight-for-age - infants
x1 <- x1[ , c("Sex", "Agemos", "L", "M", "S")]
names(x1) <- tolower(names(x1))
names(x1)[2] <- "given"
x1 <- data.frame(index = "wfa", x1)

## Weight-for-age - older
x6 <- x6[ , c("Sex", "Agemos", "L", "M", "S")]
names(x6) <- tolower(names(x6))
names(x6)[2] <- "given"
x6 <- data.frame(index = "wfa", x6)

wfa <- rbind(x1[x1$Agemos < 24, ], x6)
wfa <- wfa[order(wfa$sex), ]

## Length for age - infant
x2 <- x2[ , c("Sex", "Agemos", "L", "M", "S")]
x2 <- x2[c(1:37, 39:75), ]
names(x2) <- tolower(names(x2))
names(x2)[2] <- "given"
x2 <- data.frame(index = "lfa", x2)

## Height-for-age
x7 <- x7[ , c("Sex", "Agemos", "L", "M", "S")]
names(x7) <- tolower(names(x7))
names(x7)[2] <- "given"
x7 <- data.frame(index = "hfa", x7)

## Weight-for-length - infants
x3 <- x3[ , c("Sex", "Length", "L", "M", "S")]
names(x3) <- tolower(names(x3))
names(x3)[2] <- "given"
x3 <- data.frame(index = "wfl", x3)

## Weight-for-height - older
x5 <- x5[ , c("Sex", "Height", "L", "M", "S")]
names(x5) <- tolower(names(x5))
names(x5)[2] <- "given"
x5 <- data.frame(index = "wfh", x5)

## Head circumference-for-age - infants
x4 <- x4[ , c("Sex", "Agemos", "L", "M", "S")]
names(x4) <- tolower(names(x4))
names(x4)[2] <- "given"
x4 <- data.frame(index = "hca", x4)

## Body mass index for age
x8 <- x8[ , c("Sex", "Agemos", "L", "M", "S")]
names(x8) <- tolower(names(x8))
names(x8)[2] <- "given"
x8 <- data.frame(index = "bfa", x8)

cdcData <- rbind(wfa, x2, x7, x3, x5, x4, x8)
usethis::use_data(cdcData, overwrite = TRUE, compress = "xz")
