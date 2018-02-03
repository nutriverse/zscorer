library(zscorer)
context("Tests for getCohortWGS")

wazAll <- getCohortWGS(data = anthro1,
                       sexObserved = "sex",
                       firstPart = "weight",
                       secondPart = "age",
                       index = "wfa")
wazAll

hazAll <- getCohortWGS(data = anthro1,
                       sexObserved = "sex",
                       firstPart = "height",
                       secondPart = "age",
                       index = "hfa")
hazAll

whzAll <- getCohortWGS(data = anthro1,
                       sexObserved = "sex",
                       firstPart = "weight",
                       secondPart = "height",
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
