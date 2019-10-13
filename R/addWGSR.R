################################################################################
#
#'
#' Add the WHO Growth Reference z-scores to a data frame of anthropometric data
#' for weight, height or length, MUAC, head circumference, sub-scapular
#' skinfold and triceps skinfold.
#'
#' @param data A survey dataset as a data.frame object
#' @param sex Name of variable specifying the sex of the subject. This must be
#'   coded as \code{1 = male} and \code{2 = female}. Give a quoted variable
#'   name as in (e.g.) \code{"sex"}.
#'
#' @param firstPart Name of variable specifying:
#'   \itemize{
#'     \item Weight (kg) for BMI/A, W/A, W/H, or W/L
#'     \item Head circumference (cm) for HC/A
#'     \item Height (cm) for BMI/A for H/A
#'     \item Length (cm) for L/A
#'     \item MUAC (cm) for MUAC/A
#'     \item Sub-scapular skinfold (mm) for SSF/A
#'     \item Triceps skinfold (mm) for TSF/A
#'   }
#'
#'   Give a quoted variable name as in (e.g.) \code{"weight"}. Be careful with
#'   units (weight in kg; height, length, head circumference, and MUAC in cm,
#'   skinfolds in mm).
#'
#' @param secondPart Name of variable specifying:
#'   \itemize{
#'     \item Age (days) for H/A, HC/A, L/A, MUAC/A, SSF/A, or TSF/A
#'     \item Height (cm) BMI/A or W/H
#'     \item Length (cm) for W/L
#'   }
#'
#'   Give a quoted variable name as in (e.g.) \code{"age"}. Be careful with
#'   units (age in days; height and length in cm).
#'
#' @param thirdPart Name of variable specifying age (in days) for BMI/A. Give a
#'   quoted variable name as in (e.g.) \code{"age"}. Be careful with units
#'   (age in days).
#'
#' @param index The index to be calculated and added to \code{data}. One of:
#'   \describe{
#'     \item{\code{bfa}}{BMI for age}
#'     \item{\code{hca}}{Head circumference for age}
#'     \item{\code{hfa}}{Height for age}
#'     \item{\code{lfa}}{Length for age}
#'     \item{\code{mfa}}{MUAC for age}
#'     \item{\code{ssa}}{Sub-scapular skinfold for age}
#'     \item{\code{tsa}}{Triceps skinfold for age}
#'     \item{\code{wfa}}{Weight for age}
#'     \item{\code{wfh}}{Weight for height}
#'     \item{\code{wfl}}{Weight for length}
#'  }
#'
#'  Give a quoted index name as in (e.g.) \code{"wfh"}.
#'
#' @param standing Variable specifying how stature was measured. If NULL then age
#'   (for \code{"hfa"} or \code{"lfa"}) or height rules (for \code{"wfh"} or
#'   \code{"wfl"}) will be applied. This must be coded as \code{1 = Standing};
#'   \code{2 = Supine}; \code{3 = Unknown}. All other values will be recoded to
#'   \code{3 = Unknown}. Give a quoted variable name as in (e.g.) \code{"measured"}
#'   or a single value (e.g.\code{"measured = 1"}). If no value (or NULL) is
#'   specified then height and age rules will be applied.
#'
#' @param output The name of the column containing the specified index to be
#'   added to the dataset. This is an optional parameter. If you do not specify
#'   a value for output then the added column will take the name of the specified
#'   index with a \code{"z"} appended.
#'
#' @param digits The number of decimal places for \code{output}. Defaults to 2 d.p.
#'
#' @return A data.frame of the survey dataset with the calculated z-scores added.
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
#' @export
#'
#
################################################################################

addWGSR <- function(data, sex, firstPart, secondPart, thirdPart = NA,
                    index = NA, standing = NULL,
                    output = paste(index, "z", sep = ""), digits = 2) {
  ## If 'standing' is not specified then create a column in 'data' holding 3 (unknown) for all rows
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
                   getWGSR(sex = data[[sex]][i], firstPart = data[[firstPart]][i],
                           secondPart = data[[secondPart]][i],
                           index = index, standing = data[[standing]][i],
                           thirdPart = data[[thirdPart]][i]),
                   getWGSR(sex = data[[sex]][i], firstPart = data[[firstPart]][i],
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


################################################################################
#
#'
#' Calculate WHO Growth Reference z-score for a given anthropometric
#' measurement.
#'
#' This function is usually called by the \code{addWGSR()} function
#' but could be used as a stand-alone calculator for getting z-score for a given
#' anthropometric measurement.
#'
#' @param sex Sex of the subject. This must be coded as \code{1 = male} and
#'   \code{2 = female}.
#' @param firstPart Name of variable specifying:
#'   \itemize{
#'     \item Weight (kg) for BMI/A, W/A, W/H, or W/L
#'     \item Head circumference (cm) for HC/A
#'     \item Height (cm) for BMI/A for H/A
#'     \item Length (cm) for L/A
#'     \item MUAC (cm) for MUAC/A
#'     \item Sub-scapular skinfold (mm) for SSF/A
#'     \item Triceps skinfold (mm) for TSF/A
#'   }
#'
#'   Give a quoted variable name as in (e.g.) \code{"weight"}. Be careful with
#'   units (weight in kg; height, length, head circumference, and MUAC in cm,
#'   skinfolds in mm).
#'
#' @param secondPart Name of variable specifying:
#'   \itemize{
#'     \item Age (days) for H/A, HC/A, L/A, MUAC/A, SSF/A, or TSF/A
#'     \item Height (cm) BMI/A or W/H
#'     \item Length (cm) for W/L
#'   }
#'
#'   Give a quoted variable name as in (e.g.) \code{"age"}. Be careful with
#'   units (age in days; height and length in cm).
#'
#' @param thirdPart Name of variable specifying age (in days) for BMI/A. Give a
#'   quoted variable name as in (e.g.) \code{"age"}. Be careful with units
#'   (age in days).
#'
#' @param index The index to be calculated and added to \code{data}. One of:
#'   \describe{
#'     \item{\code{bfa}}{BMI for age}
#'     \item{\code{hca}}{Head circumference for age}
#'     \item{\code{hfa}}{Height for age}
#'     \item{\code{lfa}}{Length for age}
#'     \item{\code{mfa}}{MUAC for age}
#'     \item{\code{ssa}}{Sub-scapular skinfold for age}
#'     \item{\code{tsa}}{Triceps skinfold for age}
#'     \item{\code{wfa}}{Weight for age}
#'     \item{\code{wfh}}{Weight for height}
#'     \item{\code{wfl}}{Weight for length}
#'  }
#'
#'  Give a quoted index name as in (e.g.) \code{"wfh"}.
#'
#' @param standing Variable specifying how stature was measured. If NULL then age
#'   (for \code{"hfa"} or \code{"lfa"}) or height rules (for \code{"wfh"} or
#'   \code{"wfl"}) will be applied. This must be coded as \code{1 = Standing};
#'   \code{2 = Supine}; \code{3 = Unknown}. All other values will be recoded to
#'   \code{3 = Unknown}. Give a quoted variable name as in (e.g.) \code{"measured"}
#'   or a single value (e.g.\code{"measured = 1"}). If no value (or NULL) is
#'   specified then height and age rules will be applied.
#'zz
#' @return A numeric value or vector of z-scores for the specified \code{index}.
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
#' @export
#'
#
################################################################################

getWGSR <- function(sex, firstPart, secondPart,
                    index = NA, standing, thirdPart = NA) {
  ## Avoid missing and impossible values in 'standing' by coding NA and other values to '3'
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
  ## Lookup reference values and calculate z-score
  lkpIndexSex <- wgsrData[wgsrData$index == index & wgsrData$sex == sex, ]
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
  if(z >  3) z <-  3 + ((firstPart - SD3pos) / SD23pos)
  if(z < -3) z <- -3 + ((firstPart - SD3neg) / SD23neg)
  return(z)
}
