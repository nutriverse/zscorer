################################################################################
#
#' get_centiles_all
#'
#' Calculate centiles for length/height-for-age (HAZ), weight-for-age (WAZ),
#' weight-for-height/length (WHZ), BMI-for-age (BAZ), head circumference-for-age
#' (HCAZ), arm circumference-for-age (ACAZ), subscapular skinfold-for-age (SSAZ)
#' and triceps skinfold-for-age (TSAZ) using the WHO Growth Reference (2006)
#' for a cohort of children.
#'
#' @param data Data frame containing corresponding data on \code{sex}, \code{age},
#'     \code{weight}, \code{height}, \code{BMI}, \code{head circumference},
#'     \code{arm circumference}, \code{subscapular skinfold} and
#'     \code{triceps skinfold} of children. Default is NULL. If specified,
#'     parameters for \code{sex}, \code{age}, \code{weight}, \code{height},
#'     \code{BMI}, \code{head circumference}, \code{arm circumference},
#'     \code{subscapular skinfold} and \code{triceps skinfold} should be provided
#'     as character values of the names of variables in \code{data} corresponding
#'     to the parameters required.
#' @param sex Either numeric values (1 = male; 2 = female) indicating sex of
#'     child (default) or character value (if \code{data} is specified) indicating
#'     variable name in \code{data} containing information on sex of
#'     child/children (1 = male; 2 = female).
#' @param age Either numeric values for age in whole months (default) or character
#'     value (if \code{data} is specified) indicating variable name in \code{data}
#'     containing information on age of child/children.
#' @param weight Either numeric values for weight in kg with at least 1 decimal
#'     place (default) or character value (if \code{data} is specified) indicating
#'     variable name in \code{data} containing information on weight of
#'     child/children.
#' @param height Either numeric values for height in cm with at least 1 decimal
#'     place (default) or character value (if \code{data} is specified) indicating
#'     variable name in \code{data} containing information on height of
#'     child/children.
#' @param bmi Either numeric values for BMI in \eqn{kg / m ^ 2} (default) or
#'     character value (if \code{data} is specified) indicating variable name in
#'     \code{data} containing information on BMI of child/children.
#' @param hc Either numeric values for head circumference in cm (default) or
#'     character value (if \code{data} is specified) indicating variable name in
#'     \code{data} containing information on head circumference of child/children.
#' @param ac Either numeric values for arm circumference in cm (default) or
#'     character value (if \code{data} is specified) indicating variable name in
#'     \code{data} containing information on arm circumference of child/children.
#' @param ss Either numeric values for subscapular skinfold in cm (default) or
#'     character value (if \code{data} is specified) indicating variable name in
#'     \code{data} containing information on subscapular skinfold of child/children.
#' @param ts Either numeric values for triceps skinfold in cm (default) or
#'     character value (if \code{data} is specified) indicating variable name in
#'     \code{data} containing information on triceps skinfold of child/children.
#' @param index One of "wfh", "hfa", "wfa", "bfa", "acfa", "hcfa", "ssfa", "tsfa"
#'     (specifies the required index) or "all" to calculate all eight indices
#' @return Either a single numeric value for z-score of the anthropometric index
#'     selected if data is for single child or a data frame of numeric values for
#'     z-scores of each anthropometric index if data is for multiple children and
#'     more than one anthropometric index selected.
#'
#' @section Warning:
#' The function fails messily when \code{secondPart} is outside of the range
#' given in the WGS reference (i.e. 45 to 120 cm for height and 0 to 60 months
#' for age). It is up to you to check the ranges of your data.
#'
#' @section Reminders:
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
#'   # apply \code{get_centiles_all()} to a make believe 52 month old male child with
#'   # weight of 14.6 kg and height of 98.0 cm
#'   waz <- get_centiles_all(sex = 1,          # 1 = Male / 2 = Female
#'                           weight = 14.6,    # Weight in kilograms
#'                           height = 98,      # Height in centimetres
#'                           age = 52,         # Age in whole months
#'                           index = "wfa")    # Anthropometric index (weight-for-age)
#'   waz
#'
#'   haz <- get_centiles_all(sex = 1,
#'                           weight = 14.6,
#'                           height = 98,      # Height in centimetres
#'                           age = 52,
#'                           index = "hfa")    # Anthropometric index (height-for-age)
#'   haz
#'
#'   whz <- get_centiles_all(sex = 1,
#'                           weight = 14.6,
#'                           height = 98,
#'                           age = 52,
#'                           index = "wfh")    # Anthropometric index (weight-for-height)
#'   whz
#'
#'   # apply \code{get_centiles_all()} to \code{anthro1} dataset
#'   waz <- get_centiles_all(data = anthro1,
#'                           sex = "sex",
#'                           weight = "weight",
#'                           height = "height",
#'                           age = "age",
#'                           index = "wfa")
#'   waz
#'
#'   haz <- get_centiles_all(sex = anthro1$sex,
#'                           weight = anthro1$weight,
#'                           height = anthro1$height,
#'                           age = anthro1$age,
#'                           index = "hfa")
#'   haz
#'
#'   all <- get_centiles_all(data = anthro1,
#'                           sex = "sex",
#'                           weight = "weight",
#'                           height = "height",
#'                           age = "age",
#'                           index = c("wfa", "hfa", "wfh"))
#'   all
#'
#' @export
#'
#
################################################################################

get_centiles_all <- function(data = NULL, sex, age,
                             weight = NULL, height = NULL, bmi = NULL,
                             hc = NULL, ac = NULL, ss = NULL, ts = NULL,
                             index = c("hfa", "wfa", "wfh", "bfa",
                                       "acfa", "hcfa", "ssfa", "tsfa")) {
  #
  # If user selects index of "wfa" or "all"...
  #
  if("wfa" %in% index | "all" %in% index){
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
        stop("If data provided, sex, weight and age must be numeric. Try again.", call. = TRUE)
      }
      #
      #
      #
      waz <- mapply(FUN = get_centiles,
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
        stop("If data not provided, sex, weight and age must be character values. Try again", call. = TRUE)
      }
      #
      #
      #
      waz <- mapply(FUN = get_centiles,
                    sexObserved = data [, sex],
                    firstPart = data[ , weight],
                    secondPart = data[ , age],
                    index = "wfa")
    }
  }
  #
  # If user selects index of haz or all...
  #
  if("hfa" %in% index | "all" %in% index){
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
        stop("If data provided, sex, height and age must be numeric. Try again.", call. = TRUE)
      }
      #
      #
      #
      haz <- mapply(FUN = get_centiles,
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
        stop("If data not provided, sex, height and age must be character values. Try again.", call. = TRUE)
      }
      #
      #
      #
      haz <- mapply(FUN = get_centiles,
                    sexObserved = data[ , sex],
                    firstPart = data[ , height],
                    secondPart = data[ , age],
                    index = "hfa")
    }
  }
  #
  # If user selects index of "whz" or "all"...
  #
  if("wfh" %in% index | "all" %in% index){
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
        stop("If data provided, sex, weight and height must be numeric. Try again.", call. = TRUE)
      }
      #
      #
      #
      whz <- mapply(FUN = get_centiles,
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
        stop("If data not provided, sex, weight and height must be character values. Try again.", call. = TRUE)
      }
      #
      #
      #
      whz <- mapply(FUN = get_centiles,
                    sexObserved = data[ , sex],
                    firstPart = data[ , weight],
                    secondPart = data[ , height],
                    index = "wfh")
    }
  }
  #
  # If user selects index of baz or all...
  #
  if("bfa" %in% index | "all" %in% index){
    #
    # If user does not provide data (is.null(data))...
    #
    if(is.null(data)){
      #
      # If user provides non-numeric arguments for parameters...
      #
      if(!is.numeric(sex) | !is.numeric(bmi) | !is.numeric(age)){
        #
        # Stop operation
        #
        stop("If data provided, sex, bmi and age must be numeric. Try again.", call. = TRUE)
      }
      #
      #
      #
      baz <- mapply(FUN = get_centiles,
                    sexObserved = sex,
                    firstPart = bmi,
                    secondPart = age,
                    index = "bfa")
    }
    #
    #
    #
    if(!is.null(data)){
      #
      #
      #
      if(!is.character(sex) | !is.character(bmi) | !is.character(age)){
        #
        #
        #
        stop("If data not provided, sex, bmi and age must be character values. Try again.", call. = TRUE)
      }
      #
      #
      #
      baz <- mapply(FUN = get_centiles,
                    sexObserved = data[ , sex],
                    firstPart = data[ , bmi],
                    secondPart = data[ , age],
                    index = "bfa")
    }
  }
  #
  # If user selects index of acaz or all...
  #
  if("acfa" %in% index | "all" %in% index){
    #
    # If user does not provide data (is.null(data))...
    #
    if(is.null(data)){
      #
      # If user provides non-numeric arguments for parameters...
      #
      if(!is.numeric(sex) | !is.numeric(ac) | !is.numeric(age)){
        #
        # Stop operation
        #
        stop("If data provided, sex, ac and age must be numeric. Try again.", call. = TRUE)
      }
      #
      #
      #
      acaz <- mapply(FUN = get_centiles,
                     sexObserved = sex,
                     firstPart = ac,
                     secondPart = age,
                     index = "acfa")
    }
    #
    #
    #
    if(!is.null(data)){
      #
      #
      #
      if(!is.character(sex) | !is.character(ac) | !is.character(age)){
        #
        #
        #
        stop("If data not provided, sex, ac and age must be character values. Try again.", call. = TRUE)
      }
      #
      #
      #
      acaz <- mapply(FUN = get_centiles,
                     sexObserved = data[ , sex],
                     firstPart = data[ , ac],
                     secondPart = data[ , age],
                     index = "acfa")
    }
  }
  #
  # If user selects index of hcaz or all...
  #
  if("hcfa" %in% index | "all" %in% index){
    #
    # If user does not provide data (is.null(data))...
    #
    if(is.null(data)){
      #
      # If user provides non-numeric arguments for parameters...
      #
      if(!is.numeric(sex) | !is.numeric(hc) | !is.numeric(age)){
        #
        # Stop operation
        #
        stop("If data provided, sex, hc and age must be numeric. Try again.", call. = TRUE)
      }
      #
      #
      #
      hcaz <- mapply(FUN = get_centiles,
                     sexObserved = sex,
                     firstPart = hc,
                     secondPart = age,
                     index = "hcfa")
    }
    #
    #
    #
    if(!is.null(data)){
      #
      #
      #
      if(!is.character(sex) | !is.character(hc) | !is.character(age)){
        #
        #
        #
        stop("If data not provided, sex, hc and age must be character values. Try again.", call. = TRUE)
      }
      #
      #
      #
      hcaz <- mapply(FUN = get_centiles,
                     sexObserved = data[ , sex],
                     firstPart = data[ , hc],
                     secondPart = data[ , age],
                     index = "hcfa")
    }
  }
  #
  # If user selects index of ssaz or all...
  #
  if("ssfa" %in% index | "all" %in% index){
    #
    # If user does not provide data (is.null(data))...
    #
    if(is.null(data)){
      #
      # If user provides non-numeric arguments for parameters...
      #
      if(!is.numeric(sex) | !is.numeric(ss) | !is.numeric(age)){
        #
        # Stop operation
        #
        stop("If data provided, sex, ss and age must be numeric. Try again.", call. = TRUE)
      }
      #
      #
      #
      ssaz <- mapply(FUN = get_centiles,
                     sexObserved = sex,
                     firstPart = ss,
                     secondPart = age,
                     index = "ssfa")
    }
    #
    #
    #
    if(!is.null(data)){
      #
      #
      #
      if(!is.character(sex) | !is.character(ss) | !is.character(age)){
        #
        #
        #
        stop("If data not provided, sex, ss and age must be character values. Try again.", call. = TRUE)
      }
      #
      #
      #
      ssaz <- mapply(FUN = get_centiles,
                     sexObserved = data[ , sex],
                     firstPart = data[ , ss],
                     secondPart = data[ , age],
                     index = "ssfa")
    }
  }
  #
  # If user selects index of tsaz or all...
  #
  if("tsfa" %in% index | "all" %in% index){
    #
    # If user does not provide data (is.null(data))...
    #
    if(is.null(data)){
      #
      # If user provides non-numeric arguments for parameters...
      #
      if(!is.numeric(sex) | !is.numeric(ts) | !is.numeric(age)){
        #
        # Stop operation
        #
        stop("If data provided, sex, ts and age must be numeric. Try again.", call. = TRUE)
      }
      #
      #
      #
      tsaz <- mapply(FUN = get_centiles,
                     sexObserved = sex,
                     firstPart = ts,
                     secondPart = age,
                     index = "tsfa")
    }
    #
    #
    #
    if(!is.null(data)){
      #
      #
      #
      if(!is.character(sex) | !is.character(ts) | !is.character(age)){
        #
        #
        #
        stop("If data not provided, sex, ts and age must be character values. Try again.", call. = TRUE)
      }
      #
      #
      #
      tsaz <- mapply(FUN = get_centiles,
                     sexObserved = data[ , sex],
                     firstPart = data[ , ts],
                     secondPart = data[ , age],
                     index = "tsfa")
    }
  }
  #
  #
  #
  z <- NULL
  #
  #
  #
  if("wfa" %in% index)  { z <- data.frame(cbind(z, waz)) }
  if("hfa" %in% index)  { z <- data.frame(cbind(z, haz)) }
  if("wfh" %in% index)  { z <- data.frame(cbind(z, whz)) }
  if("bfa" %in% index)  { z <- data.frame(cbind(z, baz)) }
  if("hcfa" %in% index) { z <- data.frame(cbind(z, hcaz)) }
  if("acfa" %in% index) { z <- data.frame(cbind(z, acaz)) }
  if("ssfa" %in% index) { z <- data.frame(cbind(z, ssaz)) }
  if("tsfa" %in% index) { z <- data.frame(cbind(z, tsaz)) }
  if("all" %in% index) {
    z <- data.frame(cbind(waz, haz, whz, baz, hcaz, acaz, ssaz, tsaz))
    names(z) <- c("waz", "haz", "whz", "baz", "hcaz", "acaz", "ssaz", "tsaz")
  }
  return(z)
}

