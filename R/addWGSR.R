################################################################################
#
#'
#' Calculate WHO Growth Reference z-score for given anthropometric
#' measurement/s.
#'
#' The first function, [getWGSR()], is usually called by the [addWGSR()]
#' function but could be used as a stand-alone calculator for getting z-score
#' for a given anthropometric measurement.
#'
#' [addWGSR()] adds the WHO Growth Reference z-scores to a data frame of
#' anthropometric datafor weight, height or length, MUAC, head circumference,
#' sub-scapular skinfold and triceps skinfold.
#'
#' @param data A survey dataset as a data.frame object
#' @param sex Name of variable specifying the sex of the subject. This must be
#'   coded as `1 = male` and `2 = female`. Give a quoted variable
#'   name as in (e.g.) `"sex"`.
#'
#' @param firstPart Name of variable specifying:
#'   * Weight (kg) for BMI/A, W/A, W/H, or W/L
#'   * Head circumference (cm) for HC/A
#'   * Height (cm) for BMI/A for H/A
#'   * Length (cm) for L/A
#'   * MUAC (cm) for MUAC/A
#'   * Sub-scapular skinfold (mm) for SSF/A
#'   * Triceps skinfold (mm) for TSF/A
#'
#'   Give a quoted variable name as in (e.g.) `"weight"`. Be careful with
#'   units (weight in kg; height, length, head circumference, and MUAC in cm,
#'   skinfolds in mm).
#'
#' @param secondPart Name of variable specifying:
#'   * Age (days) for H/A, HC/A, L/A, MUAC/A, SSF/A, or TSF/A
#'   * Height (cm) BMI/A or W/H
#'   * Length (cm) for W/L
#'
#'   Give a quoted variable name as in (e.g.) `"age"`. Be careful with
#'   units (age in days; height and length in cm).
#'
#' @param thirdPart Name of variable specifying age (in days) for BMI/A. Give a
#'   quoted variable name as in (e.g.) `"age"`. Be careful with units
#'   (age in days).
#'
#' @param index The index to be calculated and added to `data`. One of:
#'
#'   | :--- | :--- |
#'   | `bfa` | BMI for age |
#'   | `hca` | Head circumference for age |
#'   | `hfa` | Height for age |
#'   | `lfa` | Length for age |
#'   | `mfa` | MUAC for age |
#'   | `ssa` | Sub-scapular skinfold for age |
#'   | `tsa` | Triceps skinfold for age |
#'   | `wfa` | Weight for age |
#'   | `wfh` | Weight for height |
#'   | `wfl` | Weight for length |
#'
#'  Give a quoted index name as in (e.g.) `"wfh"`.
#'
#' @param standing Variable specifying how stature was measured. If NULL then
#'   age (for `"hfa"` or `"lfa"`) or height rules (for `"wfh"` or `"wfl"`) will
#'   be applied. This must be coded as `1 = Standing`; `2 = Supine`;
#'   `3 = Unknown`. All other values will be recoded to `3 = Unknown`. Give a
#'   quoted variable name as in (e.g.) `"measured"` or a single value (e.g.
#'   `"measured = 1`). If no value (or NULL) is specified then height and age
#'   rules will be applied.
#'
#' @param output The name of the column containing the specified index to be
#'   added to the dataset. This is an optional parameter. If you do not specify
#'   a value for output then the added column will take the name of the
#'   specified index with a `"z"` appended.
#'
#' @param digits The number of decimal places for `output`. Defaults to 2 d.p.
#'
#' @return A data.frame of the survey dataset with the calculated z-scores
#'   added.
#'
#' @examples
#' # Given a male child 10 months old with a weight of 5.7 kgs, height of 64.2
#' # cms, and MUAC of 125 mm:
#' #
#' # Calculate weight-for-height
#' getWGSR(sex = 1,
#'         firstPart = 5.7,
#'         secondPart = 64.2,
#'         index = "wfh",
#'         standing = 3)
#'
#' # calculate weight-for-age
#' getWGSR(sex = 1,
#'         firstPart = 5.7,
#'         secondPart = 10,
#'         index = "wfa",
#'         standing = 3)
#'
#' # calculate height-for-age
#' getWGSR(sex = 1,
#'         firstPart = 64.2,
#'         secondPart = 10,
#'         index = "hfa",
#'         standing = 3)
#'
#' # Calculate MUAC-for-age z-score for a girl
#' getWGSR(sex = 1,
#'         firstPart = 20,
#'         secondPart = 62 * (365.25 / 12),
#'         index = "mfa")
#'
#' @rdname wgsr
#' @export
#'
#
################################################################################

getWGSR <- function(sex,
                    firstPart, secondPart, thirdPart = NA,
                    index = NA, standing = NA) {
  ## Avoid missing and impossible values in 'standing' by coding NA and
  ## other values to '3'
  if(is.na(standing) | !(standing %in% c(1, 2, 3))) {
    standing = 3
  }
  ## Unknown index specified - return NA
  if(!(index %in% c("bfa", "hca", "hfa", "lfa", "mfa",
                    "ssa", "tsa", "wfa", "wfh", "wfl"))) {
    return(NA)
  }
  ## Missing data for 'sex', 'firstPart', or 'secondPart' - return NA
  if(is.na(sex) | is.na(firstPart) | is.na(secondPart)) {
    return(NA)
  }
  ## 'sex' must be male (1) or female (2)
  if(!(sex %in% c(1, 2))) {
    return(NA)
  }
  ## 'firstPart' or 'secondPart' are not numeric - return NA
  if(!is.numeric(firstPart) | !is.numeric(secondPart)) {
    return(NA)
  }
  ## Missing 'thirdPart' (age) is missing for BMI-for-age - return NA
  if(index == "bfa" & is.na(thirdPart)) {
    return(NA)
  }
  ## 'thirdPart' (age) is not numeric for BMI-for-age - return NA
  if(index == "bfa" & !is.numeric(thirdPart)) {
    return(NA)
  }
  ## 'secondPart' is zero then BMI cannot be calculated
  if(index == "bfa" & secondPart == 0) {
    return(NA)
  }
  ## Round lengths to nearest 0.1 cm
  if(index %in% c("wfh", "wfl")) {
    secondPart <- round(secondPart, 1)
  }
  ## Round ages to the nearest day
  if(index %in% c("hca", "hfa", "lfa", "mfa", "ssa", "tsa", "wfa")) {
    secondPart <- round(secondPart, digits = 0)
  }
  if(index == "bfa") {
    thirdPart <- round(thirdPart, 0)
  }
  ## Rules for length-for-age and height-for-age indices
  if(standing == 1 & (index == "lfa" | index == "hfa") & secondPart < 731) {
    index <- "lfa"
    firstPart <- firstPart + 0.7
  }
  if(standing == 2 & (index == "lfa" | index == "hfa") & secondPart < 731) {
    index <- "lfa"
  }
  if(standing == 3 & (index == "lfa" | index == "hfa") & secondPart < 731) {
    index <- "lfa"
  }
  if(standing == 1 & (index == "lfa" | index == "hfa") & secondPart >= 731) {
    index <- "hfa"
  }
  if(standing == 2 & (index == "lfa" | index == "hfa") & secondPart >= 731) {
    index <- "hfa"
    firstPart <- firstPart - 0.7
  }
  if(standing == 3 & (index == "lfa" | index == "hfa") & secondPart >= 731) {
    index <- "hfa"
  }
  ## Rules for weight-for-length and weight-for-height indices
  if(standing == 1 & (index == "wfl" | index == "wfh") & secondPart < 65) {
    index = "wfl"
    secondPart <- secondPart + 0.7
  }
  if(standing == 1 & (index == "wfl" | index == "wfh") & secondPart >= 65) {
    index = "wfh"
  }
  if(standing == 2 & (index == "wfl" | index == "wfh") & secondPart <= 110) {
    index = "wfl"
  }
  if(standing == 2 & (index == "wfl" | index == "wfh") & secondPart > 110) {
    index = "wfh"
    secondPart <- secondPart - 0.7
  }
  if(standing == 3 & (index == "wfl" | index == "wfh") & secondPart < 87) {
    index = "wfl"
  }
  if(standing == 3 & (index == "wfl" | index == "wfh") & secondPart >= 87) {
    index = "wfh"
  }
  ## Rules for BMI-for-age index
  if(standing == 1 & index == "bfa" & thirdPart < 731) {
    secondPart <- secondPart + 0.7
  }
  if(standing == 2 & index == "bfa" & thirdPart >= 731) {
    secondPart <- secondPart - 0.7
  }
  ## Calculate BMI (as 'firstPart') and place age in 'secondPart'
  if(index == "bfa") {
    firstPart <- firstPart / (secondPart / 100)^2
    secondPart <- thirdPart
  }
  ## 'secondPart' is out of range for specified 'index' - return NA
  rangeSecondPart <- range(wgsrData$given[wgsrData$index == index])
  if(secondPart < rangeSecondPart[1] | secondPart > rangeSecondPart[2]) {
    return(NA)
  }
  ## Get WGS reference data
  wgsrData <- referenceData[["wgs"]]
  ## Lookup reference values and calculate z-score
  lkpIndexSex <- wgsrData[wgsrData$index == index & wgsrData$sex == sex, ]
  L <- approx(lkpIndexSex$given, lkpIndexSex$l,
              xout = secondPart, ties = "ordered")$y
  M <- approx(lkpIndexSex$given, lkpIndexSex$m,
              xout = secondPart, ties = "ordered")$y
  S <- approx(lkpIndexSex$given, lkpIndexSex$s,
              xout = secondPart, ties = "ordered")$y
  z <- (((firstPart / M) ^ L) - 1) / (L * S)
  SD3pos <- M * (1 + L * S * (+3))^(1 / L)
  SD2pos <- M * (1 + L * S * (+2))^(1 / L)
  SD23pos <- SD3pos - SD2pos
  SD3neg <- M * (1 + L * S * (-3))^(1 / L)
  SD2neg <- M * (1 + L * S * (-2))^(1 / L)
  SD23neg <- SD2neg - SD3neg
  if(z >  3) z <-  3 + ((firstPart - SD3pos) / SD23pos)
  if(z < -3) z <- -3 + ((firstPart - SD3neg) / SD23neg)
  return(z)
}


################################################################################
#
#'
#' @examples
#' # Calculate weight-for-height (wfh) for the anthro3 dataset
#' addWGSR(data = anthro3,
#'         sex = "sex",
#'         firstPart = "weight",
#'         secondPart = "height",
#'         index = "wfh")
#'
#' # Calculate weight-for-age (wfa) for the anthro3 dataset
#' addWGSR(data = anthro3,
#'         sex = "sex",
#'         firstPart = "weight",
#'         secondPart = "age",
#'         index = "wfa")
#'
#' # Calculate height-for-age (hfa) for the anthro3 dataset
#' addWGSR(data = anthro3,
#'         sex = "sex",
#'         firstPart = "height",
#'         secondPart = "age",
#'         index = "hfa")
#'
#' # Calculate MUAC-for-age (mfa) for the anthro4 dataset
#'
#' ## Convert age in anthro4 from months to days
#' testData <- anthro4
#' testData$age <- testData$agemons * (365.25 / 12)
#'
#' addWGSR(data = testData,
#'         sex = "sex",
#'         firstPart = "muac",
#'         secondPart = "age",
#'         index = "mfa")
#'
#' @rdname wgsr
#' @export
#'
#
################################################################################

addWGSR <- function(data, sex,
                    firstPart, secondPart, thirdPart = NA,
                    index = NA, standing = NULL,
                    output = paste(index, "z", sep = ""), digits = 2) {
  ## If 'standing' is not specified then create a column in 'data' holding
  ## 3 (unknown) for all rows
  addedStanding <- FALSE
  if(is.null(standing)) {
    ## Random column name for 'standing'
    standing <- paste(sample(c(letters, LETTERS), size = 16, replace = TRUE),
                      collapse = "")
    data[[standing]] <- 3
    addedStanding <- TRUE
  }
  ## Calculate specified index
  z <- vector(mode = "numeric", length = nrow(data))
  pb <- txtProgressBar(min = 0, max = nrow(data), style = 1)
  for(i in 1:nrow(data)) {
    z[i] <- ifelse(!is.na(thirdPart),
                   getWGSR(sex = data[[sex]][i],
                           firstPart = data[[firstPart]][i],
                           secondPart = data[[secondPart]][i],
                           index = index, standing = data[[standing]][i],
                           thirdPart = data[[thirdPart]][i]),
                   getWGSR(sex = data[[sex]][i],
                           firstPart = data[[firstPart]][i],
                           secondPart = data[[secondPart]][i],
                           index = index, standing = data[[standing]][i]))
    setTxtProgressBar(pb, i)
  }
  cat("\n", sep = "")
  ## Remove	added 'standing' column from 'data'
  if(addedStanding) {
    data[[standing]] <- NULL
  }
  ## Add index to 'data' and return 'data'
  data[[output]] <- round(z, digits = digits)
  return(data)
}


