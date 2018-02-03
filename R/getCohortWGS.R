################################################################################
#
#' getCohortWGS
#'
#' Calculate z-scores for WHZ, HAZ, WAZ using the WHO Growth Reference (2006)
#' for a cohort or sample of children.
#'
#' @param data Data frame containing the variables needed for calculation
#' @param FUN Function to apply; default to \code{getWGS()}
#' @param sexObserved Sex of child (1 = Male; 2 = Female)
#' @param firstPart Weight (kg; for WHZ and WAZ) or height (cm; for HAZ)
#' @param secondPart Age (months; for HAZ and WAZ) or height (cm; for WHZ)
#' @param index One of "wfh", "hfa", "wfa" (specifies the required index)
#' @return Numeric vector of \code{z-scores} of the anthropometric index selected
#'
#' The function fails messily when \code{secondPart} is outside of the range
#' given in the WGS reference (i.e. 45 to 120 cm for height and 0 to 60 months
#' for age). It is up to you to check the ranges of your data.
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
#' @examples
#'   # apply getWGS to first child in sample data anthro1
#'   wazAll <- getCohortWGS(data = anthro1,
#'                          sexObserved = "sex",
#'                          firstPart = "weight",
#'                          secondPart = "age",
#'                          index = "wfa")
#'   wazAll
#'
#'   hazAll <- getCohortWGS(data = anthro1,
#'                          sexObserved = "sex",
#'                          firstPart = "height",
#'                          secondPart = "age",
#'                          index = "hfa")
#'   hazAll
#'
#'   whzAll <- getCohortWGS(data = anthro1,
#'                          sexObserved = "sex",
#'                          firstPart = "weight",
#'                          secondPart = "height",
#'                          index = "wfh")
#'   whzAll
#' @export
#'
#
################################################################################

getCohortWGS <- function(data, FUN = getWGS, sexObserved, firstPart, secondPart, index) {

  z <- mapply(FUN = getWGS,
              data[ , sexObserved],
              data[ , firstPart],
              data[ , secondPart],
              index)

  return(z)
}
