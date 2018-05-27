################################################################################
#
#' calculate_bmi
#'
#' Function to calculate body mass index (BMI) using weight (in kgs) and
#' height (in metres)
#'
#' @param weight A numeric value for weight in kilograms.
#' @param height A numeric value for height in metres.
#'
#' @return A numeric value for body mass index (BMI) in \code{kgs / m ^ 2}
#'
#' @examples
#' # Calculate BMI of a child with weight 14.6 kgs and a height of 98.0 cms
#' calculate_bmi(weight = 14.6, height = 98.0 / 100)
#'
#' @export
#'
#
################################################################################

calculate_bmi <- function(weight, height) {
  #
  # calculate bmi
  #
  bmi <- weight / (height ^ 2)
  #
  #
  #
  return(bmi)
}


################################################################################
#
#' calculate_bmi_cohort
#'
#' Function to calculate body mass index for a dataset containing weight (in kgs)
#' and height (in metres). A wrapper function using \code{mapply()} to vectorise
#' application of \code{calculate_bmi()} to calculate BMI for each row in dataset.
#'
#' @param data Data frame containing corresponding data on \code{weight} and
#'     \code{height} of children. Default is NULL. If specified, parameters for
#'     \code{weight} and \code{height} should be provided as character values of the names of
#'     variables in \code{data} corresponding to the parameters required.
#' @param weight Either numeric values for weight in kg with at least 1 decimal
#'     place (default) or character value (if \code{data} is specified) indicating
#'     variable name in \code{data} containing information on weight of
#'     child/children.
#' @param height Either numeric values for height in cm with at least 1 decimal
#'     place (default) or character value (if \code{data} is specified) indicating
#'     variable name in \code{data} containing information on height of
#'     child/children.
#' @return Either a single numeric value for BMI if data is for single child or a
#'     data frame of numeric values for BMI if data is for multiple children.
#'
#' @examples
#' # apply \code{calculate_bmi_cohort} to \code{anthro1} dataset
#' calculate_bmi_cohort(weight = anthro1$weight,
#'                      height = (anthro1$height / 100) ^ 2)
#'
#' @export
#'
#
################################################################################

calculate_bmi_cohort <- function(data = NULL, weight, height) {
  #
  # If user does not provide data (is.null(data))...
  #
  if(is.null(data)) {
    #
    # If user provides non-numeric arguments for parameters...
    #
    if(!is.numeric(weight) | !is.numeric(height)) {
      #
      # Stop operation
      #
      stop("If data provided, weight and height must be numeric. Try again.", call. = TRUE)
    }
    #
    #
    #
    bmi_cohort <- mapply(FUN = calculate_bmi,
                         weight = weight,
                         height = height)
  }
  #
  #
  #
  if(!is.null(data)) {
    #
    # If user provides non-character arguments for paratmers...
    #
    if(!is.character(height) | !is.character(weight)){
      #
      # Stop operation
      #
      stop("If data not provided, sex, weight and age must be character values. Try again", call. = TRUE)
    }
    #
    #
    #
    bmi_cohort <- mapply(FUN = calculate_bmi,
                         weight = data[ , weight],
                         height = data[ , height])
  }
  #
  # Return output
  #
  return(bmi_cohort)
}

