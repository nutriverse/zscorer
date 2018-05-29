################################################################################
#
#' get_centiles
#'
#' Calculate centiles for length/height-for-age (HAZ), weight-for-age (WAZ),
#' weight-for-height/length (WHZ), BMI-for-age (BAZ), head circumference-for-age
#' (HCAZ), arm circumference-for-age (ACAZ), subscapular skinfold-for-age (SSAZ)
#' and triceps skinfold-for-age (TSAZ) using the WHO Growth Reference (2006)
#' for a single child data.
#'
#' @param sexObserved Sex of child (1 = Male; 2 = Female)
#' @param firstPart Weight (in kg for WHZ and WAZ) or height (in cm for HAZ) or
#'     BMI (in kg/m squared for BAZ) or head circumference (in cm for HCAZ) or
#'     arm circumference (in cm for ACAZ) or subscapular skinfold (in cm for SSAZ)
#'     or triceps skinfold (in cm for TSAZ)
#' @param secondPart Age (in months for HAZ, WAZ, BAZ, HCAZ, ACAZ, SSAZ and TSAZ)
#'     or height (in cm for WHZ)
#' @param index One of "wfh", "hfa", "wfa", "bfa", "hcfa", "acfa", "ssfa", "tsfa"
#'     (specifies the required index)
#' @return Centile for the anthropometric index selected given the child's
#'     anthropometric measurements.
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
#' @examples
#'   # apply \code{get_centiles()} to a make believe 52 month old male child with weight of
#'   # 14.6 kg and height of 98.0 cm
#'   waz <- get_centiles(sexObserved = 1,     # 1 = Male / 2 = Female
#'                       firstPart = 14.6,    # Weight in kilograms
#'                       secondPart = 52,     # Age in whole months
#'                       index = "wfa")       # Anthropometric index (weight-for-age)
#'   waz
#'
#'   haz <- get_centiles(sexObserved = 1,
#'                       firstPart = 98,      # Height in centimetres
#'                       secondPart = 52,
#'                       index = "hfa")       # Anthropometric index (height-for-age)
#'   haz
#'
#'   whz <- get_centiles(sexObserved = 1,
#'                       firstPart = 14.6,
#'                       secondPart = 98,
#'                       index = "wfh")       # Anthropometric index (weight-for-height)
#'   whz
#'
#' @export
#'
#
################################################################################

get_centiles <- function(sexObserved, firstPart, secondPart, index) {

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

  centile <- lookupRow$m + (lookupRow$m * lookupRow$s * z)

  return(centile)
}
