library(zscorer)
context("Tests for getWGSR and addWGSR")

whz <- getWGSR(sex = 1,
               firstPart = 5.7,
               secondPart = 64.2,
               index = "wfh",
               standing = 3)

waz <- getWGSR(sex = 1,
               firstPart = 5.7,
               secondPart = 10 * 365.25 / 12,
               index = "wfa",
               standing = 3)

haz <- getWGSR(sex = 1,
               firstPart = 64.2,
               secondPart = 10 * 365.25 / 12,
               index = "hfa",
               standing = 3)

test_that("z-score is numeric", {
  expect_is(waz, "numeric")
  expect_is(haz, "numeric")
  expect_is(whz, "numeric")
})

test_that("getWGSR same as getWGS", {
  expect_equal(round(waz, digits = 1), round(getWGS(sexObserved = 1,
                                                    firstPart = 5.7,
                                                    secondPart = 10,
                                                    index = "wfa"), digits = 1))
  expect_equal(round(haz, digits = 1), round(getWGS(sexObserved = 1,
                                                    firstPart = 64.2,
                                                    secondPart = 10,
                                                    index = "hfa"), digits = 1))
  expect_equal(round(whz, digits = 1), round(getWGS(sexObserved = 1,
                                                    firstPart = 5.7,
                                                    secondPart = 64.2,
                                                    index = "wfh"), digits = 1))
})


testdata <- anthro3
testdata$age <- testdata$age * 365.25 / 12

whz <- addWGSR(data = testdata,
               sex = "sex",
               firstPart = "weight",
               secondPart = "height",
               index = "wfh",
               standing = 3)

waz <- addWGSR(data = testdata,
               sex = "sex",
               firstPart = "weight",
               secondPart = "age",
               index = "wfa")

haz <- addWGSR(data = testdata,
               sex = "sex",
               firstPart = "height",
               secondPart = "age",
               index = "hfa",
               standing = 3)


test_that("z-score is numeric", {
  expect_is(waz, "data.frame")
  expect_is(haz, "data.frame")
  expect_is(whz, "data.frame")
})

