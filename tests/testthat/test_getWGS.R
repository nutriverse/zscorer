library(zscorer)
context("Tests for getWGS")

waz <- getWGS(sexObserved = anthro1$sex[1],
              firstPart = anthro1$weight[1],
              secondPart = anthro1$age[1],
              index = "wfa")

haz <- getWGS(sexObserved = anthro1$sex[1],
              firstPart = anthro1$height[1],
              secondPart = anthro1$age[1],
              index = "hfa")

whz <- getWGS(sexObserved = anthro1$sex[1],
              firstPart = anthro1$weight[1],
              secondPart = anthro1$height[1],
              index = "wfh")

test_that("z-score is correct", {
  expect_equal(round(waz, digits = 2), anthro1$waz[1])
  expect_equal(round(haz, digits = 2), anthro1$haz[1])
  expect_equal(round(whz, digits = 2), anthro1$whz[1])
})

wazAll <- mapply(getWGS, sexObserved = anthro1$sex, firstPart = anthro1$weight,
                 secondPart = anthro1$age, index = "wfa")

hazAll <- mapply(getWGS, sexObserved = anthro1$sex, firstPart = anthro1$height,
                 secondPart = anthro1$age, index = "hfa")

whzAll <- mapply(getWGS, sexObserved = anthro1$sex, firstPart = anthro1$weight,
                 secondPart = anthro1$height, index = "wfh")

test_that("z-score all is numeric vector", {
  expect_is(wazAll, "numeric")
  expect_is(hazAll, "numeric")
  expect_is(whzAll, "numeric")
})

test_that("length of z-score vector as long as anthro1", {
  expect_equal(length(wazAll), nrow(anthro1))
  expect_equal(length(hazAll), nrow(anthro1))
  expect_equal(length(whzAll), nrow(anthro1))
})

waz <- getWGS(sexObserved = NA,
              firstPart = anthro1$weight[1],
              secondPart = anthro1$age[1],
              index = "wfa")

test_that("NA is produced", {
  expect_equal(waz, NA)
})
