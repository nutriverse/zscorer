################################################################################
#
#' getAllWGS
#'
#' Calculate z-scores for WHZ, HAZ, WAZ using the WHO Growth Reference (2006)
#' for a single child data.
#'
#' @param data Data frame containing corresponding data on \code{sex},
#'     \code{weight}, \code{height}, and \code{age} of children. Default is NULL.
#'     If specified, parameters for \code{sex}, \code{weight}, \code{height} and
#'     \code{age} should be provided as character values of the names of
#'     variables in \code{data} corresponding to the paramters required.
#' @param sex Either numeric values (1 = male; 2 = female) indicating sex of
#'     child (default) or character value (if \code{data} is specified) indicating
#'     variable name in \code{data} containing information on sex of
#'     child/children (1 = male; 2 = female).
#' @param weight Either numeric values for weight in kg with at least 1 decimal
#'     place (default) or character value (if \code{data} is specfiied) indicating
#'     variable name in \code{data} containing information on weight of
#'     child/children.
#' @param height Either numeric values for height in cm with at least 1 decimal
#'     place (default) or character value (if \code{data} is specified) indicating
#'     variable name in \code{data} containing information on height of
#'     child/children.
#' @param age Either numeric values for age in whole months (default) or character
#'     value (if \code{data} is specified) indicating variable name in \code{data}
#'     containing information on age of child/children.
#' @param index One of "wfh", "hfa", "wfa" (specifies the required index) or "all"
#'     to calculate all three indices
#' @return Either a single numeric value for z-score of the anthropometric index
#'     selected if data is for single child or a data frame of numeric values for
#'     z-scores of each anthropometric index if data is for multiple children and
#'     more than one anthropometric index selected.
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
#'   # apply \code{getAllWGS()} to a make believe 52 month old male child with weight of
#'   # 14.6 kg and height of 98.0 cm
#'   waz <- getAllWGS(sex = 1,          # 1 = Male / 2 = Female
#'                    weight = 14.6,    # Weight in kilograms
#'                    height = 98,      # Height in centimetres
#'                    age = 52,         # Age in whole months
#'                    index = "wfa")    # Anthropometric index (weight-for-age)
#'   waz
#'
#'   haz <- getAllWGS(sex = 1,
#'                    weight = 14.6,
#'                    height = 98,      # Height in centimetres
#'                    age = 52,
#'                    index = "hfa")    # Anthropometric index (height-for-age)
#'   haz
#'
#'   whz <- getAllWGS(sex = 1,
#'                    weight = 14.6,
#'                    height = 98,
#'                    age = 52,
#'                    index = "wfh")    # Anthropometric index (weight-for-height)
#'   whz
#'
#'   # apply \code{getAllWGS()} to \code{anthro1} dataset
#'   waz <- getAllWGS(data = anthro1,
#'                    sex = "sex",
#'                    weight = "weight",
#'                    height = "height",
#'                    age = "age",
#'                    index = "wfa")
#'   waz
#'
#'   haz <- getAllWGS(sex = anthro1$sex,
#'                    weight = anthro1$weight,
#'                    height = anthro1$height,
#'                    age = anthro1$age,
#'                    index = "hfa")
#'   haz
#'
#'   all <- getAllWGS(data = anthro1,
#'                    sex = "sex",
#'                    weight = "weight",
#'                    height = "height",
#'                    age = "age",
#'                    index = "all")
#'   all
#'
#' @export
#'
#
################################################################################

getAllWGS <- function(data = NULL, sex, weight, height, age, index) {
  #
  # If user selects index of "wfa" or "all"...
  #
  if(index == "wfa" | index == "all"){
    #
    # If user does not provide data (is.null(data))...
    #
    if(is.null(data)){
      #
      # If user provides non-numeric arguments for parameters...
      #
      if(!is.numeric(weight) | !is.numeric(sex) | !is.numeric(age)){
        #
        # Stop operation
        #
        stop("sex, weight and age must be numeric. Try again.", call. = TRUE)
      }
      #
      #
      #
      waz <- mapply(FUN = getWGS,
                    sexObserved = sex,
                    firstPart = weight,
                    secondPart = age,
                    index = "wfa")
    }
    #
    # If !is.null(data)...
    #
    if(!is.null(data)){
      #
      # If user provides non-character arguments for paratmers...
      #
      if(!is.character(sex) | !is.character(weight) | !is.character(age)){
        #
        # Stop operation
        #
        stop("sex, weight and age must be characer values. Try again", call. = TRUE)
      }
      #
      #
      #
      waz <- mapply(FUN = getWGS,
                    sexObserved = data [, sex],
                    firstPart = data[ , height],
                    secondPart = data[ , age],
                    index = "wfa")
    }
  }
  #
  # If user selects index of haz or all...
  #
  if(index == "hfa" | index == "all"){
    #
    # If user does not provide data (is.null(data))...
    #
    if(is.null(data)){
      #
      # If user provides non-numeric arguments for parameters...
      #
      if(!is.numeric(sex) | !is.numeric(height) | !is.numeric(age)){
        #
        # Stop operation
        #
        stop("sex, height and age must be numeric. Try again.", call. = TRUE)
      }
      #
      #
      #
      haz <- mapply(FUN = getWGS,
                    sexObserved = sex,
                    firstPart = height,
                    secondPart = age,
                    index = "hfa")
    }
    #
    #
    #
    if(!is.null(data)){
      #
      #
      #
      if(!is.character(sex) | !is.character(height) | !is.character(age)){
        #
        #
        #
        stop("sex, height and age must be character values. Try again.", call. = TRUE)
      }
      #
      #
      #
      haz <- mapply(FUN = getWGS,
                    sexObserved = data[ , sex],
                    firstPart = data[ , height],
                    secondPart = data[ , age],
                    index = "hfa")
    }
  }
  #
  # If user selects index of "whz" or "all"...
  #
  if(index == "wfh" | index == "all"){
    #
    #
    #
    if(is.null(data)){
      #
      #
      #
      if(!is.numeric(sex) | !is.numeric(weight) | !is.numeric(height)){
        #
        #
        #
        stop("sex, weight and height must be numeric. Try again.", call. = TRUE)
      }
      #
      #
      #
      whz <- mapply(FUN = getWGS,
                    sexObserved = sex,
                    firstPart = weight,
                    secondPart = height,
                    index = "wfh")
    }
    #
    #
    #
    if(!is.null(data)){
      #
      #
      #
      if(!is.character(sex) | !is.character(weight) | !is.character(height)){
        #
        #
        #
        stop("sex, weight and height must be character values. Try again.", call. = TRUE)
      }
      #
      #
      #
      whz <- mapply(FUN = getWGS,
                    sexObserved = data[ , sex],
                    firstPart = data[ , weight],
                    secondPart = data[ , height],
                    index = "wfh")
    }
  }
  #
  #
  #
  if(index == "wfa") { z <- data.frame(waz) }
  if(index == "hfa") { z <- data.frame(haz) }
  if(index == "wfh") { z <- data.frame(whz) }
  if(index == "all") {
    z <- data.frame(cbind(waz, haz, whz))
    names(z) <- c("waz", "haz", "whz")
  }
  return(z)
}

