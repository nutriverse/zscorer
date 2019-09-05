################################################################################
#
#'
#' Find children with acute wasting from an anthropometric dataset
#'
#' @param df A data.frame containing anthropometric z-score indices
#'   `weight-for-height`
#' @param index A character vector of anthropometric measurements to use to
#'   determine acute wasting. Default is for both `weight-for-height z-score`
#'   and `muac`
#' @param zscore A character value for variable name for `weight-for-height z-score`
#'   in `df`. Default is `whz`
#' @param muac A character value for variable name for mid-upper arm
#'   circumference (MUAC) in `df`
#' @param flag A character value for variable name of coded flags applied to
#'   `weight-for-height z-score` values in `df`. Default is NULL indicating
#'   that flags have already been applied and flagged values have been censored.
#' @param add Logical. Should recode values for acute undernutrition be added to
#'   `df`? Default is TRUE
#'
#' @return if `add` TRUE, returns `df` with recode values indicating acute
#'   wasting cases.
#'
#' @examples
#'
#' find_child_wasting(df = anthro1, zscore = "whz", muac = "muac",
#'                    flag = NULL, add = TRUE)
#'
#' @export
#'
#
################################################################################

find_child_wasting <- function(df, index = c("whz", "muac"),
                               zscore = "whz", muac = "muac",
                               flag = NULL, add = TRUE) {
  ## weight-for-height z-score
  if("whz" %in% index) {
    if(is.null(flag)) {
      gam.whz <- ifelse(df[[zscore]] < -2, 1, 0)
      mam.whz <- ifelse(df[[zscore]] >= -3 & df[[zscore]] < -2, 1, 0)
      sam.whz <- ifelse(df[[zscore]] < -3, 1, 0)
      if(add) {
        anthroDF <- data.frame(df, gam.whz, mam.whz, sam.whz)
      }
      ##
      anthroDF <- data.frame(gam.whz, mam.whz, sam.whz)
    }
    if(!is.null(flag)) {
      gam.whz <- ifelse(df[[zscore]] < -2 & !df[[flag]] %in% c(2, 3, 6, 7), 1, 0)
      gam.whz <- ifelse(df[[flag]] %in% c(2, 3, 6, 7), NA, gam.whz)
      mam.whz <- ifelse(df[[zscore]] >= -3 & df[[zscore]] < -2 & !df[[flag]] %in% c(2, 3, 6, 7), 1, 0)
      mam.whz <- ifelse(df[[flag]] %in% c(2, 3, 6, 7), NA, mam.whz)
      sam.whz <- ifelse(df[[zscore]] < -3 & !df[[flag]] %in% c(2, 3, 6, 7), 1, 0)
      sam.whz <- ifelse(df[[flag]] %in% c(2, 3, 6, 7), NA, sam.whz)
      ##
      if(add) {
        anthroDF <- data.frame(df, gam.whz, mam.whz, sam.whz)
      }
      ##
      anthroDF <- data.frame(gam.whz, mam.whz, sam.whz)
    }
  }
  if("muac" %in% index) {
    gam.muac <- ifelse(df[[muac]] < 12.5, 1, 0)
    mam.muac <- ifelse(df[[muac]] < 12.5 & df[[muac]] >= 11.5, 1, 0)
    sam.muac <- ifelse(df[[muac]] < 11.5, 1, 0)
  }
  ##
  if(add) {
    anthroDF <- data.frame(df, gam.muac, mam.muac, sam.muac)
  }
  ##
  anthroDF <- data.frame(gam.muac, mam.muac, sam.muac)
  ##
  return(anthroDF)
}
