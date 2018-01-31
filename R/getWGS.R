################################################################################
#
#' getWGS
#'
#' Function to calculate z-scores for WHZ, HAZ, WAZ using the WHO Growth
#' Reference (2006) using data and methods from ISBN ISBN 92 4 154693 X.
#'
#' The function fails messily when "secondPart" is outside of the range given
#' in the WGS reference (i.e. 45 to 120 cm for height and 0 to 60 months for
#' age). It is up to you to check the ranges of your data.
#'
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
#' @param sexObserved Sex of child (1 = Male; 2 = Female)
#' @param firstPart Weight (kg; for WHZ and WAZ) or height (cm; for HAZ)
#' @param secondPart Age (months; for HAZ and WAZ) or height (cm; for WHZ)
#' @param index One of "wfh", "hfa", "wfa" (specified the required index)
#' @return Numeric vector of corresponding z-scores of the anthropometric
#'     index selected
#' @examples
#'   # apply getWGS to sample data anthro1
#'   waz <- getWGS(sexObserved = anthro1$sex[1],
#'                 firstPart = anthro1$weight[1],
#'                 secondPart = anthro1$age[1],
#'                 index = "wfa")
#'
#'   haz <- getWGS(sexObserved = anthro1$sex[1],
#'                 firstPart = anthro1$height[1],
#'                 secondPart = anthro1$age[1],
#'                 index = "hfa")
#'
#'   whz <- getWGS(sexObserved = anthro1$sex[1],
#'                 firstPart = anthro1$weight[1],
#'                 secondPart = anthro1$height[1],
#'                 index = "wfh")
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

  if(z > 3) {
    z <- 3 + ((firstPart - SD3pos) / SD23pos)
  }

  if(z < -3) {
    z <- -3 + ((firstPart - SD3neg) / SD23neg)
  }

  return(z)
}
