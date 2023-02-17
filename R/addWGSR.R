#' Calculate WHO Growth Reference z-score for given anthropometric
#' measurement/s.
#'
#' The first function, [getWGSR()], is usually called by the [addWGSR()]
#' function but could be used as a stand-alone calculator for getting z-score
#' for a given anthropometric measurement, or set of measurements
#'
#' [addWGSR()] adds the WHO Growth Reference z-scores to a data frame of
#' anthropometric data for weight, height or length, MUAC, head circumference,
#' sub-scapular skinfold, triceps skinfold, and body mass index (BMI).
#'
#' @param data A survey dataset as a data.frame object
#'
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
#'   | **Index** | **Definition** |
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
#' @rdname wgs
#' @export
getWGSR <- function(sex,
                    firstPart,
                    secondPart,
                    thirdPart = NA,
                    index = NA,
                    standing = NA) {

  ## validate arg lengths
  N <- length(sex)

  if (length(firstPart) != N | length(sex) != N) {
    stop("Arguments `sex`, `firstPart`, and `secondPart` must have the same length")
  }
  if (!length(thirdPart) %in% c(1L, N)) {
    stop("Argument `thirdPart` must have a length of 1, or the same length as arguments `sex`, `firstPart`, and `secondPart`")
  }
  if (!length(index) %in% c(1L, N)) {
    stop("Argument `index` must have a length of 1, or the same length as arguments `sex`, `firstPart`, and `secondPart`")
  }
  if (!length(standing) %in% c(1L, N)) {
    stop("Argument `standing` must have a length of 1, or the same length as arguments `sex`, `firstPart`, and `secondPart`")
  }

  ## standardize scalar arg types to avoid possible type coercion issues
  thirdPart <- as.numeric(thirdPart)
  index <- as.character(index)
  standing <- as.integer(standing)

  ## easy way to broadcast scalars (e.g. index) or possible scalars (e.g.
  ## standing) to match length of vectors (sex, firstPart, secondPart)
  data <- data.frame(
    sex,
    firstPart,
    secondPart,
    thirdPart,
    index,
    standing
  )

  sex <- data$sex
  firstPart <- data$firstPart
  secondPart <- data$secondPart
  thirdPart <- data$thirdPart
  index <- data$index
  standing <- data$standing

  ## prepare vector to track outputs that must be NA
  returnNA <- rep(FALSE, N)

  ## Avoid missing and impossible values in 'standing' by coding NA and
  ## other values to '3'
  standing[is.na(standing) | !(standing %in% c(1L, 2L, 3L))] <- 3L

  ## Unknown index specified - return NA
  returnNA[!(index %in% c("bfa", "hca", "hfa", "lfa", "mfa", "ssa", "tsa", "wfa", "wfh", "wfl"))] <- TRUE

  ## Missing data for 'sex', 'firstPart', or 'secondPart' - return NA
  returnNA[is.na(sex) | is.na(firstPart) | is.na(secondPart)] <- TRUE

  ## 'sex' must be male (1) or female (2)
  returnNA[!(sex %in% c(1, 2))] <- TRUE

  ## 'firstPart' or 'secondPart' are not numeric - return NA
  returnNA[!is.numeric(firstPart) | !is.numeric(secondPart)] <- TRUE

  ## Missing 'thirdPart' (age) is missing for BMI-for-age - return NA
  returnNA[index %in% "bfa" & is.na(thirdPart)] <- TRUE

  ## 'thirdPart' (age) is not numeric for BMI-for-age - return NA
  returnNA[index %in% "bfa" & !is.numeric(thirdPart)] <- TRUE

  ## 'secondPart' is zero then BMI cannot be calculated
  returnNA[index %in% "bfa" & secondPart == 0] <- TRUE

  ## Round lengths to nearest 0.1 cm
  isIndexWF <- index %in% c("wfh", "wfl")
  secondPart[isIndexWF] <- round(secondPart[isIndexWF], 1)

  ## Round ages to the nearest day
  isIndexOther <- index %in% c("hca", "hfa", "lfa", "mfa", "ssa", "tsa", "wfa")
  secondPart[isIndexOther] <- round(secondPart[isIndexOther], digits = 0)

  is_index_bfa <- index %in% "bfa"
  thirdPart[is_index_bfa] <- round(thirdPart[is_index_bfa], 0)

  ## Rules for length-for-age and height-for-age indices
  isLfaRule1 <- standing == 1L & (index %in% "lfa" | index %in% "hfa") & secondPart < 731 & !is.na(secondPart)
  isLfaRule2 <- standing == 2L & (index %in% "lfa" | index %in% "hfa") & secondPart < 731 & !is.na(secondPart)
  isLfaRule3 <- standing == 3L & (index %in% "lfa" | index %in% "hfa") & secondPart < 731 & !is.na(secondPart)

  isHfaRule1 <- standing == 1L & (index %in% "lfa" | index %in% "hfa") & secondPart >= 731 & !is.na(secondPart)
  isHfaRule2 <- standing == 2L & (index %in% "lfa" | index %in% "hfa") & secondPart >= 731 & !is.na(secondPart)
  isHfaRule3 <- standing == 3L & (index %in% "lfa" | index %in% "hfa") & secondPart >= 731 & !is.na(secondPart)

  index[isLfaRule1 | isLfaRule2 | isLfaRule3] <- "lfa"
  index[isHfaRule1 | isHfaRule2 | isHfaRule3] <- "hfa"

  firstPart[isLfaRule1] <- firstPart[isLfaRule1] + 0.7
  firstPart[isHfaRule2] <- firstPart[isHfaRule2] - 0.7

  ## Rules for weight-for-length and weight-for-height indices
  isWflRule1 <- standing == 1L & (index %in% "wfl" | index %in% "wfh") & secondPart < 65 & !is.na(secondPart)
  isWfhRule1 <- standing == 1L & (index %in% "wfl" | index %in% "wfh") & secondPart >= 65 & !is.na(secondPart)

  isWflRule2 <- standing == 2L & (index %in% "wfl" | index %in% "wfh") & secondPart <= 110 & !is.na(secondPart)
  isWfhRule2 <- standing == 2L & (index %in% "wfl" | index %in% "wfh") & secondPart > 110 & !is.na(secondPart)

  isWflRule3 <- standing == 3L & (index %in% "wfl" | index %in% "wfh") & secondPart < 87 & !is.na(secondPart)
  isWfhRule3 <- standing == 3L & (index %in% "wfl" | index %in% "wfh") & secondPart >= 87 & !is.na(secondPart)

  index[isWflRule1 | isWflRule2 | isWflRule3] <- "wfl"
  index[isWfhRule1 | isWfhRule2 | isWfhRule3] <- "wfh"

  firstPart[isWflRule1] <- firstPart[isWflRule1] + 0.7
  firstPart[isWfhRule2] <- firstPart[isWfhRule2] - 0.7

  ## Rules for BMI-for-age index
  isBmiRule1 <- standing == 1L & index %in% "bfa" & thirdPart < 731 & !is.na(thirdPart)
  secondPart[isBmiRule1] <- secondPart[isBmiRule1] + 0.7

  isBmiRule2 <- standing == 2L & index %in% "bfa" & thirdPart >= 731 & !is.na(thirdPart)
  secondPart[isBmiRule2] <- secondPart[isBmiRule2] - 0.7

  ## Calculate BMI (as 'firstPart') and place age in 'secondPart'
  isBFA <- index %in% "bfa"
  firstPart[isBFA] <- firstPart[isBFA] / (secondPart[isBFA] / 100)^2
  secondPart[isBFA] <- thirdPart[isBFA]

  ## Assemble relevant vars into data.frame, then split by index and sex for
  ## efficiency, calculate z-scores with getWGSR_, then recombine results and
  ## return
  outputPrep <- data.frame(
    rowid = seq_along(firstPart),
    index,
    sex,
    firstPart,
    secondPart,
    thirdPart,
    returnNA
  )

  outputPrepSplit <- split(
    outputPrep,
    list(outputPrep$index, outputPrep$sex),
    drop = TRUE
  )

  outputList <- lapply(outputPrepSplit, getWGSR_)

  outputDf <- do.call(rbind, args = c(outputList, make.row.names = FALSE))
  outputDf <- outputDf[order(outputDf$rowid),]

  return(outputDf$z)
}



#' Helper function to calculate z-scores for a given set of observations with
#' the same value of 'index' and 'sex'
#'
#' @importFrom stats approx
#' @noRd
getWGSR_ <- function(x) {

  ## pull relevant vars from x
  index_focal <- unique(x$index)  # scalar, because x already split by index and sex
  sex_focal <- unique(x$sex)      # scalar, because x already split by index and sex

  firstPart <- x$firstPart
  secondPart <- x$secondPart
  returnNA <- x$returnNA

  ## If all values in set should be NA (returnNA is TRUE for all observations),
  ## can skip calculations and simply return NAs. This is a bit of a hack to
  ## avoid warnings or errors if returnNA is TRUE for all observations because
  ## the given value of index or sex are invalid
  if (all(x$returnNA)) {

    z <- rep(NA_real_, nrow(x))

  } else {

    ## Get WGS reference data
    wgsrData <- referenceData[["wgs"]]
    wgsrDataIndex <- wgsrData[wgsrData$index %in% index_focal,]

    ## 'secondPart' is out of range for specified 'index' - return NA
    rangeSecondPart <- range(wgsrDataIndex$given)
    returnNA[secondPart < rangeSecondPart[1] | secondPart > rangeSecondPart[2]] <- TRUE

    ## Lookup reference values and calculate z-score
    lkpIndexSex <- wgsrDataIndex[wgsrDataIndex$sex %in% sex_focal,]

    L <- approx(lkpIndexSex$given, lkpIndexSex$l, xout = secondPart, ties = "ordered")$y
    M <- approx(lkpIndexSex$given, lkpIndexSex$m, xout = secondPart, ties = "ordered")$y
    S <- approx(lkpIndexSex$given, lkpIndexSex$s, xout = secondPart, ties = "ordered")$y

    z <- (((firstPart / M) ^ L) - 1) / (L * S)

    SD3pos <- M * (1 + L * S * (+3))^(1 / L)
    SD2pos <- M * (1 + L * S * (+2))^(1 / L)
    SD23pos <- SD3pos - SD2pos
    SD3neg <- M * (1 + L * S * (-3))^(1 / L)
    SD2neg <- M * (1 + L * S * (-2))^(1 / L)
    SD23neg <- SD2neg - SD3neg

    makeCorrectionLow <- !is.na(z) & z < -3
    makeCorrectionUpp <- !is.na(z) & z > 3

    z[makeCorrectionLow] <- -3 + ((firstPart[makeCorrectionLow] - SD3neg[makeCorrectionLow]) / SD23neg[makeCorrectionLow])
    z[makeCorrectionUpp] <- 3 + ((firstPart[makeCorrectionUpp] - SD3pos[makeCorrectionUpp]) / SD23pos[makeCorrectionUpp])

    ## Ensure that values of z that can no be calculated are really NA
    z[returnNA] <- NA_real_
  }

  ## Add z-scores back to original df and return
  x$z <- z

  return(x)
}




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
#' @rdname wgs
#' @export
addWGSR <- function(data,
                    sex,
                    firstPart,
                    secondPart,
                    thirdPart = NA,
                    index = NA,
                    standing = NULL,
                    output = paste(index, "z", sep = ""),
                    digits = 2) {

  ## If 'standing' is not specified then create a column in 'data' holding
  ## 3 (unknown) for all rows
  addedStanding <- FALSE

  if (is.null(standing)) {
    ## Random column name for 'standing'
    standing <- paste(sample(c(letters, LETTERS), size = 16, replace = TRUE),
                      collapse = "")
    data[[standing]] <- 3
    addedStanding <- TRUE
  }

  ## Add third part dummy var if otherwise missing, to allow for vectorization
  addedThirdPart <- FALSE

  if (is.na(thirdPart)) {
    ## Random column name for 'thirdPart'
    thirdPart <- paste(sample(c(letters, LETTERS), size = 16, replace = TRUE),
                       collapse = "")
    data[[thirdPart]] <- NA_real_
    addedThirdPart <- TRUE
  }

  ## Calculate specified index
  z <- getWGSR(
    sex = data[[sex]],
    firstPart = data[[firstPart]],
    secondPart = data[[secondPart]],
    thirdPart = data[[thirdPart]],
    index = index,
    standing = data[[standing]]
  )

  ## Remove	added 'standing' column from 'data'
  if (addedStanding) {
    data[[standing]] <- NULL
  }

  ## Remove	added 'thirdPart' column from 'data'
  if (addedThirdPart) {
    data[[thirdPart]] <- NULL
  }

  ## Add index to 'data' and return 'data'
  data[[output]] <- round(z, digits = digits)

  return(data)
}

