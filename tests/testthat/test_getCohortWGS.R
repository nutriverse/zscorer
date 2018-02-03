library(zscorer)
context("Tests for getCohortWGS")

wazAll <- getCohortWGS(sexObserved = anthro1$sex,
                       firstPart = anthro1$weight,
                       secondPart = anthro1$age,
                       index = "wfa")
wazAll

hazAll <- getCohortWGS(sexObserved = anthro1$sex,
                       firstPart = anthro1$height,
                       secondPart = anthro1$age,
                       index = "hfa")
hazAll

whzAll <- getWGS(sexObserved = anthro1$sex,
                 firstPart = anthro1$weight,
                 secondPart = anthro1$height,
                 index = "wfh")
whzAll

test_that("result is numeric vector", {
  expect_is(wazAll, "numeric")
  expect_is(hazAll, "numeric")
  expect_is(whzAll, "numeric")
})

test_that("length of result is length of data", {
  expect_equal(length(wazAll), nrow(anthro1))
  expect_equal(length(hazAll), nrow(anthro1))
  expect_equal(length(whzAll), nrow(anthro1))
})
