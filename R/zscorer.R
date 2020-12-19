################################################################################
#
#'
#' Tool for calculating z-scores for weight-for-age, height-for-age,
#' weight-for-height, BMI-for-age, head circumference-for-age,
#' arm circumference-for-age, subscapular skinfold-for-age and
#' triceps skinfold-for-age z-score using the WHO Growth
#' Reference (2006)
#'
#' @references World Health Organization. WHO Child Growth Standards:
#' Length/Height-for-age, Weight-for-age, Weight-for-length, Weight-for-height,
#' and Body Mass Index-for age: Methods and Development. 1st ed. World Health
#' Organization; 2006. ISBN ISBN 92 4 154693 X
#'
#' @docType package
#' @name zscorer
#' @keywords internal
#' @importFrom utils read.table setTxtProgressBar txtProgressBar
#' @importFrom stats approx
#' @importFrom shiny runApp
#'
#
################################################################################
"_PACKAGE"

## quiets concerns of R CMD check re: the variable bindings in zscorer
if(getRversion() >= "2.15.1")  utils::globalVariables(c("wgsData","indicator",
                                                        "sex", "given"))

