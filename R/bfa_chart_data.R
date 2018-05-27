################################################################################
#
#' get_bfa_zchart
#'
#' Function to extract BMI-for-age z-score data from the World Health
#' Organization (WHO) website on Child Growth Standards
#' \url{http://www.who.int/childgrowth/standards/"} which contains a
#' collection of reference data from the WHO Multicentre Growth Reference Study
#' (MGRS). This function extracts the expanded data provided by WHO for creating
#' growth charts for BMI-for-age z-scores.
#'
#' @param baseurl Character value for the base URL of the WHO Child Growth
#'     Standards. The default is \url{http://www.who.int/childgrowth/standards/}.
#'     This can be adjusted should WHO change the base URL for the Child Growth
#'     Standards section of their website.
#' @param gender A character value or vector that specifies the sex-specific
#'     reference data to extract. The default is \code{c("boys", "girls")}.
#'
#' @return A data frame in tidy format with 5 coloumns and 55710 rows:
#' \describe{
#' \item{\code{sex}}{Sex of child. 1 = boy; 2 = girl}
#' \item{\code{month}}{Age of child in months. This is calculated from the
#'     original data using that data for age of child in days}
#' \item{\code{day}}{Age of child in days. This is provided for by default in
#'     the original data}
#' \item{\code{sd_type}}{Type of z-score. Can be one of \code{4SD}, \code{3SD},
#'     \code{2SD}, \code{1SD}, \code{0}, \code{-1SD}, \code{-2SD}, \code{-3SD},
#'     \code{-4SD}}
#' \item{\code{sd_value}}{Body mass index (BMI; in kgs/m^2) value for the specified
#'     \code{sd_type}}
#' }
#'
#' @examples
#' # Get bmi-for-age z-score expanded tables for charting
#' get_bfa_zchart()
#'
#' @export
#'
#
################################################################################

get_bfa_zchart <- function(baseurl = "http://www.who.int/childgrowth/standards/",
                           gender = c("boys", "girls")) {
  #
  #
  #
  temp <- NULL
  #
  #
  #
  for(i in gender) {
    #
    #
    #
    z_data <- read.table(file = paste(baseurl, "bfa_", i, "_z_exp.txt", sep = ""),
                         header = TRUE)
    #
    #
    #
    z_data <- data.frame("sex" = i, "month" = z_data$Day/30.4375, z_data)
    #
    #
    #
    temp <- data.frame(rbind(temp, z_data))
  }
  #
  #
  #
  names(temp) <- c("sex", "month", "day", "-4SD", "-3SD", "-2SD", "-1SD", "0",
                   "1SD", "2SD", "3SD", "4SD")
  #
  #
  #
  bfa_chart <- tidyr::gather(data = temp, key = "sd_type", value = "sd_value",
                             names(temp)[4]:names(temp)[ncol(temp)])
  names(bfa_chart) <- c("sex", "month", "day", "sd_type", "sd_value")
  bfa_chart$sd_type <- factor(bfa_chart$sd_type,
                              levels = c("4SD", "3SD", "2SD", "1SD", "0", "-1SD",
                                         "-2SD", "-3SD", "-4SD"))
  #
  #
  #
  return(bfa_chart)
}


################################################################################
#
#' get_bfa_pchart
#'
#' Function to extract bmi-for-age percentile data from the World Health
#' Organization (WHO) website on Child Growth Standards
#' \url{http://www.who.int/childgrowth/standards/"} which contains a
#' collection of reference data from the WHO Multicentre Growth Reference Study
#' (MGRS). This function extracts the expanded data provided by WHO for creating
#' growth charts for bmi-for-age percentiles.
#'
#' @param baseurl Character value for the base URL of the WHO Child Growth
#'     Standards. The default is \url{http://www.who.int/childgrowth/standards/}.
#'     This can be adjusted should WHO change the base URL for the Child Growth
#'     Standards section of their website.
#' @param gender A character value or vector that specifies the sex-specific
#'     reference data to extract. The default is \code{c("boys", "girls")}.
#'
#' @return A data frame in tidy format with 8 coloumns and 55710 rows:
#' \describe{
#' \item{\code{sex}}{Sex of child. 1 = boy; 2 = girl}
#' \item{\code{month}}{Age of child in months. This is calculated from the
#'     original data using that data for age of child in days}
#' \item{\code{day}}{Age of child in days. This is provided for by default in
#'     the original data}
#' \item{\code{l}}{\code{L} component of the LMS method for normalising growth
#'     centile standards. \code{L} is the trend in the optimal power to obtain
#'     normality}
#' \item{\code{m}}{\code{M} component of the LMS method for normalising growth
#'     centile standards. \code{M} is the trend in the mean}
#' \item{\code{s}}{\code{S} component of the LMS method for normalising growth
#'     centile standards. \code{S} is the trend in the coefficient of variation}
#' \item{\code{p_type}}{Type of z-score. Can be one of \code{0.10th}, \code{1st},
#'     \code{3rd}, \code{5th}, \code{10th}, \code{15th}, \code{25th}, \code{50th},
#'     \code{75th}, \code{85th}, \code{90th}, \code{95th}, \code{97th},
#'     \code{99th} and \code{99.9th}}
#' \item{\code{p_value}}{Body mass index (BMI; in kgs/m^2) value for the specified
#'     \code{p_type}}
#' }
#'
#' @examples
#' # Get bmi-for-age percentile expanded tables for charting
#' get_bfa_pchart()
#'
#' @export
#'
#
################################################################################

get_bfa_pchart <- function(baseurl = "http://www.who.int/childgrowth/standards/",
                           gender = c("boys", "girls")) {
  #
  #
  #
  temp <- NULL
  #
  #
  #
  for(i in gender) {
    #
    #
    #
    p_data <- read.table(file = paste(baseurl, "bfa_", i, "_p_exp.txt", sep = ""),
                         header = TRUE)
    #
    #
    #
    p_data <- data.frame("sex" = i, "month" = p_data$Age/30.4375, p_data)
    #
    #
    #
    temp <- data.frame(rbind(temp, p_data))
  }
  #
  #
  #
  names(temp) <- c("sex", "month", "day", "l", "m", "s",
                   "0.10th", "1st", "3rd", "5th", "10th", "15th", "25th", "50th",
                   "75th", "85th", "90th", "95th", "97th", "99th", "99.9th")
  #
  #
  #
  bfa_chart <- tidyr::gather(data = temp, key = "p_type", value = "p_value",
                             names(temp)[7]:names(temp)[ncol(temp)])
  names(bfa_chart) <- c("sex", "month", "day", "l", "m", "s", "p_type", "p_value")
  bfa_chart$p_type <- factor(bfa_chart$p_type,
                             levels = c("0.10th", "1st", "3rd", "5th", "10th",
                                        "15th", "25th", "50th", "75th", "85th",
                                        "90th", "95th", "97th", "99th", "99.9th"))
  #
  #
  #
  return(bfa_chart)
}
