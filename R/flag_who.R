################################################################################
#
#'
#' Apply World Health Organization (WHO) anthropometric z-score indices flagging
#' criteria
#'
#' @param df A data.frame containing anthropometric z-score indices for
#'   `height-for-age`, `weight-for-age` and/or `weight-for-height`
#' @param haz A character value indicating the variable name in `df` for the
#'   `height-for-age z-score`
#' @param waz A character value indicating the variable name in `df` for the
#'   `weight-for-age z-score`
#' @param whz A character value indicating the variable name in `df` for the
#'   `weight-for-height z-score`
#' @param add Logical. Should flag values be added to `df`. Default is TRUE.
#'
#' @return If `add` FALSE, returns a vector of `flag` coded values indicating
#'   problematic measurements. if `add` TRUE, returns `df` with additional
#'   column named `flag` containing coded values indicating problematic
#'   measurements
#'
#' @examples
#' flag_who(df = anthro1, haz = "haz", waz = "waz", whz = "whz")
#'
#' @export
#'
#
################################################################################

flag_who <- function(df, haz = NULL, waz = NULL, whz = NULL, add = TRUE) {
  ##
  flag <- vector(mode = "numeric", length = nrow(df))
  ##
  if(!is.null(haz)) {
    flag <- ifelse(!is.na(df[[haz]]) & (df[[haz]] < -6 | df[[haz]] > 6), flag + 1, flag)
  }
  ##
  if(!is.null(whz)) {
    flag <- ifelse(!is.na(df[[whz]]) & (df[[whz]] < -5 | df[[whz]] > 5), flag + 2, flag)
  }
  ##
  if(!is.null(waz)) {
    flag <- ifelse(!is.na(df[[waz]]) & (df[[waz]] < -6 | df[[waz]] > 5), flag + 4, flag)
  }
  ##
  if(add) {
    df$flag <- flag
    flag <- df
  }
  return(flag)
}
