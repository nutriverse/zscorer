################################################################################
#
#' get_wfh_zchart
#'
#' Function to extract weight-for-length/height z-score data from the World Health
#' Organization (WHO) website on Child Growth Standards
#' \url{http://www.who.int/childgrowth/standards/"} which contains a
#' collection of reference data from the WHO Multicentre Growth Reference Study
#' (MGRS). This function extracts the expanded data provided by WHO for creating
#' growth charts for weight-for-length/height z-scores.
#'
#' @param baseurl Character value for the base URL of the WHO Child Growth
#'     Standards. The default is \url{http://www.who.int/childgrowth/standards/}.
#'     This can be adjusted should WHO change the base URL for the Child Growth
#'     Standards section of their website.
#' @param gender A character value or vector that specifies the sex-specific
#'     reference data to extract. The default is \code{c("boys", "girls")}.
#'
#' @return A data frame in tidy format with 4 coloumns and 21636 rows:
#' \describe{
#' \item{\code{sex}}{Sex of child. 1 = boy; 2 = girl}
#' \item{\code{lh}}{Length/height of child in centimetres.}
#' \item{\code{sd_type}}{Type of z-score. Can be one of \code{4SD}, \code{3SD},
#'     \code{2SD}, \code{1SD}, \code{0}, \code{-1SD}, \code{-2SD}, \code{-3SD},
#'     \code{-4SD}}
#' \item{\code{sd_value}}{Weight (kgs) value for the specified \code{sd_type}}
#' }
#'
#' @examples
#' # Get weight-for-length/height z-score expanded tables for charting
#' get_wfh_zchart()
#'
#' @export
#'
#
################################################################################

get_wfh_zchart <- function(baseurl = "http://www.who.int/childgrowth/standards/",
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
    z_data_2 <- read.table(file = paste(baseurl, "wfl_", i, "_z_exp.txt", sep = ""),
                           header = TRUE)
    z_data_5 <- read.table(file = paste(baseurl, "wfh_", i, "_z_exp.txt", sep = ""),
                           header = TRUE)
    #
    #
    #
    z_data_2 <- data.frame("sex" = i, z_data_2)
    names(z_data_2) <- c("sex", "lh", "-4SD", "-3SD", "-2SD", "-1SD", "0",
                         "1SD", "2SD", "3SD", "4SD")

    z_data_5 <- data.frame("sex" = i, z_data_5)
    names(z_data_5) <- c("sex", "lh", "-4SD", "-3SD", "-2SD", "-1SD", "0",
                         "1SD", "2SD", "3SD", "4SD")

    z_data   <- data.frame(rbind(z_data_2, z_data_5))

    temp <- data.frame(rbind(temp, z_data))
  }
  #
  #
  #
  names(temp) <- c("sex", "lh", "-4SD", "-3SD", "-2SD", "-1SD", "0",
                   "1SD", "2SD", "3SD", "4SD")
  #
  #
  #
  wfh_chart <- tidyr::gather(data = temp, key = "sd_type", value = "sd_value",
                             names(temp)[3]:names(temp)[ncol(temp)])
  names(wfh_chart) <- c("sex", "lh", "sd_type", "sd_value")
  wfh_chart$sd_type <- factor(wfh_chart$sd_type,
                              levels = c("4SD", "3SD", "2SD", "1SD", "0", "-1SD",
                                         "-2SD", "-3SD", "-4SD"))
  #
  #
  #
  return(wfh_chart)
}



################################################################################
#
#' get_wfh_pchart
#'
#' Function to extract weight-for-length/height percentile data from the World Health
#' Organization (WHO) website on Child Growth Standards
#' \url{http://www.who.int/childgrowth/standards/"} which contains a
#' collection of reference data from the WHO Multicentre Growth Reference Study
#' (MGRS). This function extracts the expanded data provided by WHO for creating
#' growth charts for weight-for-length/height percentiles.
#'
#' @param baseurl Character value for the base URL of the WHO Child Growth
#'     Standards. The default is \url{http://www.who.int/childgrowth/standards/}.
#'     This can be adjusted should WHO change the base URL for the Child Growth
#'     Standards section of their website.
#' @param gender A character value or vector that specifies the sex-specific
#'     reference data to extract. The default is \code{c("boys", "girls")}.
#'
#' @return A data frame in tidy format with 7 coloumns and 36060 rows:
#' \describe{
#' \item{\code{sex}}{Sex of child. 1 = boy; 2 = girl}
#' \item{\code{lh}}{Length/height (in centimetres) of child in months.}
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
#' \item{\code{p_value}}{Weight (kgs) value for the specified \code{p_type}}
#' }
#'
#' @examples
#' # Get weight-for-length/height percentile expanded tables for charting
#' get_wfh_pchart()
#'
#' @export
#'
#
################################################################################

get_wfh_pchart <- function(baseurl = "http://www.who.int/childgrowth/standards/",
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
    p_data_2 <- read.table(file = paste(baseurl, "wfl_", i, "_p_exp.txt", sep = ""),
                           header = TRUE)
    p_data_5 <- read.table(file = paste(baseurl, "wfh_", i, "_p_exp.txt", sep = ""),
                           header = TRUE)
    #
    #
    #
    p_data_2 <- data.frame("sex" = i, p_data_2)
    names(p_data_2) <- c("sex", "lh", "l", "m", "s",
                         "0.10th", "1st", "3rd", "5th", "10th", "15th", "25th", "50th",
                         "75th", "85th", "90th", "95th", "97th", "99th", "99.9th")
    p_data_5 <- data.frame("sex" = i, p_data_5)
    names(p_data_5) <- c("sex", "lh", "l", "m", "s",
                         "0.10th", "1st", "3rd", "5th", "10th", "15th", "25th", "50th",
                         "75th", "85th", "90th", "95th", "97th", "99th", "99.9th")
    #
    #
    #
    p_data <- data.frame(rbind(p_data_2, p_data_5))

    temp <- data.frame(rbind(temp, p_data))
  }
  #
  #
  #
  names(temp) <- c("sex", "lh", "l", "m", "s",
                   "0.10th", "1st", "3rd", "5th", "10th", "15th", "25th", "50th",
                   "75th", "85th", "90th", "95th", "97th", "99th", "99.9th")
  #
  #
  #
  wfh_chart <- tidyr::gather(data = temp, key = "p_type", value = "p_value",
                             names(temp)[6]:names(temp)[ncol(temp)])
  names(wfh_chart) <- c("sex", "lh", "l", "m", "s", "p_type", "p_value")
  wfh_chart$p_type <- factor(wfh_chart$p_type,
                             levels = c("0.10th", "1st", "3rd", "5th", "10th",
                                        "15th", "25th", "50th", "75th", "85th",
                                        "90th", "95th", "97th", "99th", "99.9th"))
  #
  #
  #
  return(wfh_chart)
}
