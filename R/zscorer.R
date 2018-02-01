################################################################################
#
#' zscorer
#'
#' Tool for calculating z-scores for WHZ, HAZ, WAZ using the WHO Growth
#' Reference (2006) using data and methods from:
#'
#' \cite{World Health Organization. WHO Child Growth Standards: Length/Height-for-age,
#' Weight-for-age, Weight-for-length, Weight-for-height, and Body Mass Index-for age:
#' Methods and Development. 1st ed. World Health Organization; 2006.
#' ISBN ISBN 92 4 154693 X}
#'
#' @docType package
#' @name zscorer
#'
#
################################################################################
NULL

## quiets concerns of R CMD check re: the variable bindings that appear in bbw
if(getRversion() >= "2.15.1")  utils::globalVariables(c("wgsData", "indicator",
                                                        "sex", "given"))

################################################################################
#
#' wgsData
#'
#' World Health Organization (WHO) Growth Reference (2006) data
#'
#' @format A data frame with 6 columns and 1746 rows.
#' \describe{
#' \item{\code{indicator}}{One of weight-for-age (\code{waz}),
#'     height-for-age (\code{haz}), or weight-for-height (\code{whz})
#'     anthropometric indicators}
#' \item{\code{sex}}{Sex of child (1 = Male; 2 = Female)}
#' \item{\code{given}}{Variable to which standardisation is to be made. For
#'     \code{waz} and \code{haz}, \code{given} is age in months. For \code{whz},
#'     \code{given} is height in cm}
#' \item{\code{l}}{\code{L} component of the LMS method for normalising growth
#'     centile standards. \code{L} is the trend in the optimal power to obtain
#'     normality}
#' \item{\code{m}}{\code{M} component of the LMS method for normalising growth
#'     centile standards. \code{M} is the trend in the mean}
#' \item{\code{s}}{\code{S} component of the LMS method for normalising growth
#'     centile standards. \code{S} is the trend in the coefficient of variation}
#' }
#' @source \cite{World Health Organization. WHO Child Growth Standards:
#' Length/Height-for-age, Weight-for-age, Weight-for-length, Weight-for-height,
#' and Body Mass Index-for age: Methods and Development. 1st ed.
#' World Health Organization; 2006.}
#'
#
################################################################################
"wgsData"


################################################################################
#
#' Example dataset for distributions of variables and indices
#'
#' Anthropometric data from a SMART survey in Kabul, Afghanistan.
#'
#' @format A data frame with 873 observations and 11 variables
#' \describe{
#' \item{\code{psu}}{Primary sampling unit}
#' \item{\code{age}}{Age of child (months)}
#' \item{\code{sex}}{Gender of child}
#' \item{\code{weight}}{Weight of child (kgs)}
#' \item{\code{height}}{Height of child (cm)}
#' \item{\code{muac}}{Mid-upper arm circumference (mm)}
#' \item{\code{oedema}}{Presence or absence of oedema}
#' \item{\code{haz}}{Height-for-age z-score}
#' \item{\code{waz}}{Weight-for-age z-score}
#' \item{\code{whz}}{Weight-for-height z-score}
#' \item{\code{flag}}{Data quality flag}
#' }
"anthro1"


################################################################################
#
#' Example dataset for digit preference function
#'
#' Anthropometric data from a single state from a Demographic and Health Survey
#' (DHS) of a West African country.
#'
#' @format A data frame with 796 observations and 6 variables
#' \describe{
#' \item{\code{psu}}{Primary sampling unit}
#' \item{\code{age}}{Age (months)}
#' \item{\code{sex}}{Gender}
#' \item{\code{wt}}{Weight (kg)}
#' \item{\code{ht}}{height (cm)}
#' \item{\code{oedema}}{Presence or absence of oedema}
#' }
"anthro2"

