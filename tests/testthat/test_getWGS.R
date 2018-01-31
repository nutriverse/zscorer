library(zscorer)
("Tests for getWGS")

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
