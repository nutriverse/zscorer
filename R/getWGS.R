################################################################################
#
#'
#' Calculate z-scores for WHZ, HAZ, WAZ using the WHO Growth Reference (2006)
#' for a single child data.
#'
#' @param sexObserved Sex of child (1 = Male; 2 = Female)
#' @param firstPart Weight (in kg for WHZ and WAZ) or height (in cm for HAZ)
#' @param secondPart Age (in months for HAZ and WAZ) or height (in cm for WHZ)
#' @param index One of "wfh", "hfa", "wfa" (specifies the required index)
#' @return z-score of the anthropometric index selected
#'
#' @section Warning:
#' The function fails messily when \code{secondPart} is outside of the range
#' given in the WGS reference (i.e. 45 to 120 cm for height and 0 to 60 months
#' for age). It is up to you to check the ranges of your data.
#'
#' @section Reminders:
#' The reference data for W/H assumes supine length is used for children with a
#' standing height below 85cm
#'
#' Heights should be specified in cm to the nearest mm (i.e. to 1 d.p.)
#'
#' Ages should be specified in whole months
#'
#' Weights should be specified in kg to available precision
#'
#' The function requires reference data \code{wgsData} included in this package
#'
#' @section Note:
#' This is a legacy function from the first CRAN release of \code{zscorer}
#' which focused mainly on the calculation of z-scores for weight-for-age,
#' weight-for-height and height-for-age. This function has been kept in the package
#' to ensure that existing analysis workflows implemented using the function
#' continue to work.
#'
#' @examples
#'   # apply \code{getWGS()} to a make believe 52 month old male child with weight of
#'   # 14.6 kg and height of 98.0 cm
#'   waz <- getWGS(sexObserved = 1,     # 1 = Male / 2 = Female
#'                 firstPart = 14.6,    # Weight in kilograms
#'                 secondPart = 52,     # Age in whole months
#'                 index = "wfa")       # Anthropometric index (weight-for-age)
#'   waz
#'
#'   haz <- getWGS(sexObserved = 1,
#'                 firstPart = 98,      # Height in centimetres
#'                 secondPart = 52,
#'                 index = "hfa")       # Anthropometric index (height-for-age)
#'   haz
#'
#'   whz <- getWGS(sexObserved = 1,
#'                 firstPart = 14.6,
#'                 secondPart = 98,
#'                 index = "wfh")       # Anthropometric index (weight-for-height)
#'   whz
#'
#' @export
#'
#
################################################################################

getWGS <- function(sexObserved, firstPart, secondPart, index) {

  if(is.na(sexObserved) | is.na(firstPart) | is.na(secondPart)) { return(NA) }

  lookupRow <- subset(wgsData, indicator == index & sex == sexObserved & given == secondPart)

  z <- (((firstPart / lookupRow$m) ^ lookupRow$l) - 1) / (lookupRow$l * lookupRow$s)

  SD3pos <- lookupRow$m * (1 + lookupRow$l * lookupRow$s * (+3))^(1 / lookupRow$l)
  SD2pos <- lookupRow$m * (1 + lookupRow$l * lookupRow$s * (+2))^(1 / lookupRow$l)
  SD23pos <- SD3pos - SD2pos

  SD3neg <- lookupRow$m * (1 + lookupRow$l * lookupRow$s * (-3))^(1 / lookupRow$l)
  SD2neg <- lookupRow$m * (1 + lookupRow$l * lookupRow$s * (-2))^(1 / lookupRow$l)
  SD23neg <- SD2neg - SD3neg

  if(z > 3) { z <- 3 + ((firstPart - SD3pos) / SD23pos) }

  if(z < -3) { z <- -3 + ((firstPart - SD3neg) / SD23neg) }

  return(z)
}
