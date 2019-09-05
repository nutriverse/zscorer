################################################################################
#
#'
#' Find children with acute wasting from an anthropometric dataset
#'
#' @param df A data.frame containing anthropometric z-score indices for
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
      ##
      anthroDF1 <- data.frame(gam.whz, mam.whz, sam.whz)
      ##
      if(add) {
        anthroDF1 <- data.frame(df, anthroDF1)
      }
    }
    if(!is.null(flag)) {
      gam.whz <- ifelse(df[[zscore]] < -2, 1, 0)
      gam.whz[df[[flag]] %in% c(2, 3, 6, 7)] <- NA
      mam.whz <- ifelse(df[[zscore]] >= -3 & df[[zscore]] < -2, 1, 0)
      mam.whz[df[[flag]] %in% c(2, 3, 6, 7)] <- NA
      sam.whz <- ifelse(df[[zscore]] < -3, 1, 0)
      sam.whz[df[[flag]] %in% c(2, 3, 6, 7)] <- NA
      ##
      anthroDF1 <- data.frame(gam.whz, mam.whz, sam.whz)
      ##
      if(add) {
        anthroDF1 <- data.frame(df, anthroDF1)
      }
    }
  }
  ##
  if("muac" %in% index) {
    gam.muac <- ifelse(df[[muac]] < 12.5, 1, 0)
    mam.muac <- ifelse(df[[muac]] < 12.5 & df[[muac]] >= 11.5, 1, 0)
    sam.muac <- ifelse(df[[muac]] < 11.5, 1, 0)
  }
  ##
  anthroDF2 <- data.frame(anthroDF1, gam.muac, mam.muac, sam.muac)
  ##
  if(add) {
    anthroDF2 <- data.frame(anthroDF1, gam.muac, mam.muac, sam.muac)
  }
  ##
  return(anthroDF2)
}


################################################################################
#
#'
#' Find children who are underweight from an anthropometric dataset
#'
#' @param df A data.frame containing anthropometric z-score indices for
#'   `weight-for-age`
#' @param zscore A character value for variable name for `weight-for-age z-score`
#'   in `df`. Default is `waz`
#' @param flag A character value for variable name of coded flags applied to
#'   `weight-for-age z-score` values in `df`. Default is NULL indicating
#'   that flags have already been applied and flagged values have been censored.
#' @param add Logical. Should recode values for underweight be added to
#'   `df`? Default is TRUE
#'
#' @return if `add` TRUE, returns `df` with recode values indicating underweight
#'   cases.
#'
#' @examples
#'
#' find_child_underweight(df = anthro1, zscore = "waz", flag = NULL, add = TRUE)
#'
#' @export
#'
#
################################################################################

find_child_underweight <- function(df, zscore = "waz",
                                   flag = NULL, add = TRUE) {
  ##
  if(is.null(flag)) {
    global.waz <- ifelse(df[[zscore]] < -2, 1, 0)
    moderate.waz <- ifelse(df[[zscore]] >= -3 & df[[zscore]] < -2, 1, 0)
    severe.waz <- ifelse(df[[zscore]] < -3, 1, 0)
    ##
    anthroDF <- data.frame(global.waz, moderate.waz, severe.waz)
    ##
    if(add) {
      anthroDF <- data.frame(df, anthroDF)
    }
  }
  ##
  if(!is.null(flag)) {
    global.waz <- ifelse(df[[zscore]] < -2, 1, 0)
    global.waz[df[[flag]] %in% c(4, 5, 6, 7)] <- NA
    moderate.waz <- ifelse(df[[zscore]] >= -3 & df[[zscore]] < -2, 1, 0)
    moderate.waz[df[[flag]] %in% c(4, 5, 6, 7)] <- NA
    severe.waz <- ifelse(df[[zscore]] < -3, 1, 0)
    severe.waz[df[[flag]] %in% c(4, 5, 6, 7)] <- NA
    ##
    anthroDF <- data.frame(global.waz, moderate.waz, severe.waz)
    ##
    if(add) {
      anthroDF <- data.frame(df, anthroDF)
    }
  }
  ##
  return(anthroDF)
}


################################################################################
#
#'
#' Find children who are stunting/stunted from an anthropometric dataset
#'
#' @param df A data.frame containing anthropometric z-score indices for
#'   `height-for-age`
#' @param zscore A character value for variable name for `height-for-age z-score`
#'   in `df`. Default is `haz`
#' @param flag A character value for variable name of coded flags applied to
#'   `height-for-age z-score` values in `df`. Default is NULL indicating
#'   that flags have already been applied and flagged values have been censored.
#' @param add Logical. Should recode values for stunting/stunted be added to
#'   `df`? Default is TRUE
#'
#' @return if `add` TRUE, returns `df` with recode values indicating stunting
#'   or stunted cases.
#'
#' @examples
#'
#' find_child_stunting(df = anthro1, zscore = "haz", flag = NULL, add = TRUE)
#'
#' @export
#'
#
################################################################################

find_child_stunting <- function(df, zscore = "haz",
                                flag = NULL, add = TRUE) {
  ##
  if(is.null(flag)) {
    global.haz <- ifelse(df[[zscore]] < -2, 1, 0)
    moderate.haz <- ifelse(df[[zscore]] >= -3 & df[[zscore]] < -2, 1, 0)
    severe.haz <- ifelse(df[[zscore]] < -3, 1, 0)
    ##
    anthroDF <- data.frame(global.haz, moderate.haz, severe.haz)
    ##
    if(add) {
      anthroDF <- data.frame(df, anthroDF)
    }
  }
  ##
  if(!is.null(flag)) {
    global.haz <- ifelse(df[[zscore]] < -2, 1, 0)
    global.haz[df[[flag]] %in% c(1, 3, 5, 7)] <- NA
    moderate.haz <- ifelse(df[[zscore]] >= -3 & df[[zscore]] < -2, 1, 0)
    moderate.haz[df[[flag]] %in% c(1, 3, 5, 7)] <- NA
    severe.haz <- ifelse(df[[zscore]] < -3, 1, 0)
    severe.haz[df[[flag]] %in% c(1, 3, 5, 7)] <- NA
    ##
    anthroDF <- data.frame(global.haz, moderate.haz, severe.haz)
    ##
    if(add) {
      anthroDF <- data.frame(df, anthroDF)
    }
  }
  ##
  return(anthroDF)
}
