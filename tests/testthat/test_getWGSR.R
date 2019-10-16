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

laz <- getWGSR(sex = 1,
               firstPart = 64.2,
               secondPart = 10 * 365.25 / 12,
               index = "lfa",
               standing = 3)

test_that("z-score is numeric", {
  expect_is(waz, "numeric")
  expect_is(haz, "numeric")
  expect_is(whz, "numeric")
  expect_is(laz, "numeric")
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


whz <- getWGSR(sex = 1,
               firstPart = 5.7,
               secondPart = 64.2,
               index = "wfb",
               standing = 3)

test_that("Result is NA when index is wrongly specified", {
  expect_true(is.na(whz))
})




testdata <- anthro3
testdata$age <- testdata$age * 365.25 / 12

addRow <- testdata[1, ]
addRow$height <- 0
testdata <- data.frame(rbind(testdata, addRow))

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

laz <- addWGSR(data = testdata,
               sex = "sex",
               firstPart = "height",
               secondPart = "age",
               index = "lfa",
               standing = 3)

bfa <- addWGSR(data = testdata,
               sex = "sex",
               firstPart = "weight",
               secondPart = "height",
               thirdPart = "age",
               index = "bfa",
               standing = 3)

test_that("z-score is numeric", {
  expect_is(waz, "data.frame")
  expect_is(haz, "data.frame")
  expect_is(laz, "data.frame")
  expect_is(whz, "data.frame")
  expect_is(bfa, "data.frame")
})

whz <- addWGSR(data = testdata,
               sex = "age",
               firstPart = "weight",
               secondPart = "height",
               index = "wfb",
               standing = 3)

test_that("Result is NA when sex is wrongly specified", {
  expect_true(all(is.na(whz$wfbz)))
})

bfa <- addWGSR(data = testdata,
               sex = "sex",
               firstPart = "weight",
               secondPart = "height",
               index = "bfa",
               standing = 3)

test_that("Result is NA when thirdPart not specified when index is bfa", {
  expect_true(all(is.na(bfa$bfaz)))
})

test_that("Result for height == 0 is NA", {
  expect_true(is.na(bfa$bfaz[nrow(bfa)]))
})
