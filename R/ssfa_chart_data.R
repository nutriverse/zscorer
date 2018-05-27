################################################################################
#
#' get_ssfa_zchart
#'
#' Function to extract subscapular skinfold-for-age z-score data from the World Health
#' Organization (WHO) website on Child Growth Standards
#' \url{http://www.who.int/childgrowth/standards/"} which contains a
#' collection of reference data from the WHO Multicentre Growth Reference Study
#' (MGRS). This function extracts the expanded data provided by WHO for creating
#' growth charts for subscapular skinfold-for-age z-scores.
#'
#' @param baseurl Character value for the base URL of the WHO Child Growth
#'     Standards. The default is \url{http://www.who.int/childgrowth/standards/}.
#'     This can be adjusted should WHO change the base URL for the Child Growth
#'     Standards section of their website.
#' @param gender A character value or vector that specifies the sex-specific
#'     reference data to extract. The default is \code{c("boys", "girls")}.
#'
#' @return A data frame in tidy format with 5 coloumns and 31788 rows:
#' \describe{
#' \item{\code{sex}}{Sex of child. 1 = boy; 2 = girl}
#' \item{\code{month}}{Age of child in months. This is calculated from the
#'     original data using that data for age of child in days}
#' \item{\code{day}}{Age of child in days. This is provided for by default in
#'     the original data}
#' \item{\code{sd_type}}{Type of z-score. Can be one of \code{4SD}, \code{3SD},
#'     \code{2SD}, \code{1SD}, \code{0}, \code{-1SD}, \code{-2SD}, \code{-3SD},
#'     \code{-4SD}}
#' \item{\code{sd_value}}{Subscapular skinfold (in centimetres) value for the specified
#'     \code{sd_type}}
#' }
#'
#' @examples
#' # Get subscapular skinfold-for-age z-score expanded tables for charting
#' get_ssfa_zchart()
#'
#' @export
#'
#
################################################################################

get_ssfa_zchart <- function(baseurl = "http://www.who.int/childgrowth/standards/",
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
    z_data <- read.table(file = paste(baseurl, "second_set/ssfa_", i, "_z_exp.txt", sep = ""),
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
  ssfa_chart <- tidyr::gather(data = temp, key = "sd_type", value = "sd_value",
                              names(temp)[4]:names(temp)[ncol(temp)])
  names(ssfa_chart) <- c("sex", "month", "day", "sd_type", "sd_value")
  ssfa_chart$sd_type <- factor(ssfa_chart$sd_type,
                               levels = c("4SD", "3SD", "2SD", "1SD", "0",
                                          "-1SD", "-2SD", "-3SD", "-4SD"))
  #
  #
  #
  return(ssfa_chart)
}


################################################################################
#
#' get_ssfa_pchart
#'
#' Function to extract subscapular skinfold-for-age percentiles data from the World Health
#' Organization (WHO) website on Child Growth Standards
#' \url{http://www.who.int/childgrowth/standards/"} which contains a
#' collection of reference data from the WHO Multicentre Growth Reference Study
#' (MGRS). This function extracts the expanded data provided by WHO for creating
#' growth charts for subscapular skinfold-for-age z-scores.
#'
#' @param baseurl Character value for the base URL of the WHO Child Growth
#'     Standards. The default is \url{http://www.who.int/childgrowth/standards/}.
#'     This can be adjusted should WHO change the base URL for the Child Growth
#'     Standards section of their website.
#' @param gender A character value or vector that specifies the sex-specific
#'     reference data to extract. The default is \code{c("boys", "girls")}.
#'
#' @return A data frame in tidy format with 8 coloumns and 52980 rows:
#' \describe{
#' \item{\code{sex}}{Sex of child. 1 = boy; 2 = girl}
#' \item{\code{month}}{Age of child in months. This is calculated from the
#'     original data using that data for age of child in days}
#' \item{\code{day}}{Age of child in days. This is provided for by default in
#'     the original data}
#' \item{\code{sd_type}}{Type of z-score. Can be one of \code{4SD}, \code{3SD},
#'     \code{2SD}, \code{1SD}, \code{0}, \code{-1SD}, \code{-2SD}, \code{-3SD},
#'     \code{-4SD}}
#' \item{\code{sd_value}}{Subscapular skinfold (in centimetres) value for the specified
#'     \code{sd_type}}
#' }
#'
#' @examples
#' # Get subscapular skinfold-for-age percentiles expanded tables for charting
#' get_ssfa_pchart()
#'
#' @export
#'
#
################################################################################

get_ssfa_pchart <- function(baseurl = "http://www.who.int/childgrowth/standards/",
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
    p_data <- read.table(file = paste(baseurl, "second_set/ssfa_", i, "_p_exp.txt", sep = ""),
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
  ssfa_chart <- tidyr::gather(data = temp, key = "p_type", value = "p_value",
                              names(temp)[7]:names(temp)[ncol(temp)])
  names(ssfa_chart) <- c("sex", "month", "day", "l", "m", "s", "p_type", "p_value")
  ssfa_chart$p_type <- factor(ssfa_chart$p_type,
                              levels = c("0.10th", "1st", "3rd", "5th", "10th",
                                         "15th", "25th", "50th", "75th", "85th",
                                         "90th", "95th", "97th", "99th", "99.9th"))
  #
  #
  #
  return(ssfa_chart)
}
