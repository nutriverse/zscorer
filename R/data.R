################################################################################
#
#' World Health Organization (WHO) Growth Reference (2006) data
#'
#' @format A data frame with 6 columns and 2338 rows.
#'
#' | **Variable** | **Description** |
#' | :--- | :---- |
#' | *indicator* | One of weight-for-age (`waz`), height-for-age (`haz`), or weight-for-height (`whz`) anthropometric indicators |
#' | *sex* | Sex of child (1 = Male; 2 = Female) |
#' | *given* | Variable to which standardisation is to be made. For `waz` and `haz`, `given` is age in months. For `whz`, `given` is height in cm |
#' | *l* | `L` component of the LMS method for normalising growth centile standards. `L` is the trend in the optimal power to obtain normality |
#' | *m* | `M` component of the LMS method for normalising growth centile standards. `M` is the trend in the mean |
#' | *s* | `S` component of the LMS method for normalising growth centile standards. `S` is the trend in the coefficient of variation |
#'
#' @examples
#' head(wgsData)
#'
#' @source World Health Organization. WHO Child Growth Standards:
#' Length/Height-for-age, Weight-for-age, Weight-for-length, Weight-for-height,
#' and Body Mass Index-for age: Methods and Development. 1st ed.
#' World Health Organization; 2006.
#'
#
################################################################################
"wgsData"


################################################################################
#
#'
#' Anthropometric data from a SMART survey in Kabul, Afghanistan.
#'
#' @format A data frame with 873 observations and 11 variables
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *psu* | Primary sampling unit |
#' | *age* | Age of child (months) |
#' | *sex* | Gender of child |
#' | *weight* | Weight of child (kgs) |
#' | *height* | Height of child (cm) |
#' | *muac* | Mid-upper arm circumference (mm) |
#' | *oedema* | Presence or absence of oedema |
#' | *haz* | Height-for-age z-score |
#' | *waz* | Weight-for-age z-score |
#' | *whz* | Weight-for-height z-score |
#' | *flag* | Data quality flag |
#'
#' @examples
#' head(anthro1)
#'
#
################################################################################
"anthro1"


################################################################################
#
#'
#' Anthropometric data from a single state from a Demographic and Health Survey
#' (DHS) of a West African country.
#'
#' @format A data frame with 796 observations and 6 variables
#'
#' | **Variable** | **Definition** |
#' | :--- | :--- |
#' | *psu* | Primary sampling unit |
#' | *age* | Age (months) |
#' | *sex* | Gender |
#' | *wt* | Weight (kg) |
#' | *ht* | Height (cm) |
#' | *oedema* | Presence or absence of oedema |
#'
#' @examples
#' head(anthro2)
#'
#
################################################################################
"anthro2"


################################################################################
#
#'
#' Anthropometric data from a Rapid Assessment Method (RAM) survey from Burundi.
#'
#' @format A data frame with 221 observations and 7 variables
#'
#' | **Variable** | **Definition** |
#' | :--- | :--- |
#' | *psu* | Primary sampling unit |
#' | *age* | Age (months) |
#' | *sex* | Gender |
#' | *weight* | Weight (kg) |
#' | *height* | Height (cm) |
#' | *muac* | Mid-upper arm circumference (cm) |
#' | *oedema* | Presence or absence of oedema |
#'
#' @examples
#' head(anthro3)
#'
#
################################################################################
"anthro3"


################################################################################
#
#' A subset of mid-upper arm circumference data from study conducted to create
#' MUAC-for-age z-scores
#'
#' @format A data.frame with 257 observations and 4 variables
#'
#' | **Variable** | **Definition** |
#' | :--- | :--- |
#' | *pk_serial* | Unique identifier |
#' | *muac* | Mid-upper arm circumference in centimetres |
#' | *agemons* | Age in months |
#' | *sex* | Sex; 1 = Male; 2 = Female |
#'
#' @examples
#' head(anthro4)
#'
#' @source Mramba Lazarus, Ngari Moses, Mwangome Martha, Muchai Lilian, Bauni
#'   Evasius, Walker A Sarah et al. A growth reference for mid upper arm
#'   circumference for age among school age children and adolescents, and
#'   validation for mortality: growth curve construction and longitudinal
#'   cohort study BMJ 2017; 358 :j3423 https://doi.org/10.1136/bmj.j3423
#'
#
################################################################################
"anthro4"
