% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getAllWGS.R
\name{getAllWGS}
\alias{getAllWGS}
\title{Calculate z-scores for WHZ, HAZ, WAZ using the WHO Growth Reference (2006)
for a single child data.}
\usage{
getAllWGS(data = NULL, sex, weight, height, age, index)
}
\arguments{
\item{data}{Data frame containing corresponding data on \code{sex}, \code{weight},
\code{height}, and \code{age} of children. Default is NULL. If specified,
parameters for \code{sex}, \code{weight}, \code{height} and \code{age} should be provided as
character values of the names of variables in \code{data} corresponding to
the parameters required.}

\item{sex}{Either numeric values (1 = male; 2 = female) indicating sex of
child (default) or character value (if \code{data} is specified) indicating
variable name in \code{data} containing information on sex of child/children
(1 = male; 2 = female).}

\item{weight}{Either numeric values for weight in kg with at least 1 decimal
place (default) or character value (if \code{data} is specified) indicating
variable name in \code{data} containing information on weight of
child/children.}

\item{height}{Either numeric values for height in cm with at least 1 decimal
place (default) or character value (if \code{data} is specified) indicating
variable name in \code{data} containing information on height of
child/children.}

\item{age}{Either numeric values for age in whole months (default) or
character value (if \code{data} is specified) indicating variable name in
\code{data} containing information on age of child/children.}

\item{index}{One of \emph{"wfh"}, \emph{"hfa"}, \emph{"wfa"} (specifies the required index)
or \emph{"all"} to calculate all three indices}
}
\value{
Either a single numeric value for z-score of the anthropometric index
selected if data is for single child or a data frame of numeric values
for z-scores of each anthropometric index if data is for multiple
children and more than one anthropometric index selected.

The function fails messily when \code{secondPart} is outside of the range
given in the WGS reference (i.e. 45 to 120 cm for height and 0 to 60 months
for age). It is up to you to check the ranges of your data.

The reference data for W/H assumes supine length is used for children with a
standing height below 85cm

Heights should be specified in cm to the nearest mm (i.e. to 1 d.p.)

Ages should be specified in whole months

Weights should be specified in kg to available precision

The function requires reference data \code{wgsData} included in this package
}
\description{
Calculate z-scores for WHZ, HAZ, WAZ using the WHO Growth Reference (2006)
for a single child data.
}
\examples{
  # apply getAllWGS to a make believe 52 month old male child with weight of
  # 14.6 kg and height of 98.0 cm
  waz <- getAllWGS(sex = 1,        # 1 = Male / 2 = Female
                   weight = 14.6,  # Weight in kilograms
                   height = 98,    # Height in centimetres
                   age = 52,       # Age in whole months
                   index = "wfa")  # Anthropometric index (weight-for-age)
  waz

  haz <- getAllWGS(sex = 1,
                   weight = 14.6,
                   height = 98,    # Height in centimetres
                   age = 52,
                   index = "hfa")  # Anthropometric index (height-for-age)
  haz

  whz <- getAllWGS(sex = 1,
                   weight = 14.6,
                   height = 98,
                   age = 52,
                   index = "wfh")  # Anthropometric index (weight-for-height)
  whz

  # apply getAllWGS to anthro1 dataset
  waz <- getAllWGS(data = anthro1,
                   sex = "sex",
                   weight = "weight",
                   height = "height",
                   age = "age",
                   index = "wfa")
  waz

  haz <- getAllWGS(sex = anthro1$sex,
                   weight = anthro1$weight,
                   height = anthro1$height,
                   age = anthro1$age,
                   index = "hfa")
  haz

  all <- getAllWGS(data = anthro1,
                   sex = "sex",
                   weight = "weight",
                   height = "height",
                   age = "age",
                   index = "all")
  all

}
