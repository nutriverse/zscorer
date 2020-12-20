## Libraries

## Reference data link
refData <- "https://www.cdc.gov/nccdphp/dnpao/growthcharts/resources/CDCref_d.csv"

## Read reference data
x <- read.csv(refData)

## Weight-for-age
wfa <- x[x$denom == "age" , c("SEX", "X_AGECAT", "X_LWT1", "X_MWT1", "X_SWT1")]
names(wfa) <- c("sex", "given", "l", "m", "s")
wfa <- data.frame(index = "wfa", wfa)

## Length-for-age
lfa <- x[x$denom == "age" & x$X_AGEMOS1 <= 35.5, c("SEX", "X_AGECAT", "X_LLG1", "X_MLG1", "X_SLG1")]
names(lfa) <- c("sex", "given", "l", "m", "s")
lfa <- data.frame(index = "lfa", lfa)

## Weight-for-length
wfl <- x[x$denom == "length" & !is.na(x$X_LG1), c("SEX", "X_LG1", "X_LWLG1", "X_MWLG1", "X_SWLG1")]
names(wfl) <- c("sex", "given", "l", "m", "s")
wfl <- data.frame(index = "wfl", wfl)

## Head circumference-for-age
hca <- x[x$denom == "age" & x$X_AGEMOS1 <= 35.5, c("SEX", "X_AGECAT", "X_LHC1", "X_MHC1", "X_SHC1")]
names(hca) <- c("sex", "given", "l", "m", "s")
hca <- data.frame(index = "hca", hca)

## Weight-for-height
wfh <- x[x$denom == "height" & !is.na(x$X_LHT1), c("SEX", "X_HT1", "X_LWHT1", "X_MWHT1", "X_SWHT1")]
names(wfh) <- c("sex", "given", "l", "m", "s")
wfh <- data.frame(index = "wfh", wfh)

## Height-for-age
hfa <- x[x$denom == "age" & x$X_AGECAT >= 23.5, c("SEX", "X_AGECAT", "X_LHT1", "X_MHT1", "X_SHT1")]
names(hfa) <- c("sex", "given", "l", "m", "s")
hfa <- data.frame(index = "hfa", hfa)

## BMI-for-age
bfa <- x[x$denom == "age" & x$X_AGECAT >= 23.5, c("SEX", "X_AGECAT", "X_LBMI1", "X_MBMI1", "X_SBMI1")]
names(bfa) <- c("sex", "given", "l", "m", "s")
bfa <- data.frame(index = "bfa", bfa)

cdcData <- rbind(wfa, lfa, wfl, hca, wfh, hfa, bfa)
write.csv(cdcData, "data-raw/cdcData.csv", row.names = FALSE)
