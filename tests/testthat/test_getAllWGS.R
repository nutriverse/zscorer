library(zscorer)
context("Tests for getAllWGS function")

waz <- getAllWGS(data = anthro1,
                 sex = "sex",
                 weight = "weight",
                 height = "height",
                 age = "age",
                 index = "wfa")

test_that("waz is a data.frame", {
  expect_is(waz, "data.frame")
})

test_that("waz is numeric", {
  expect_true(is.numeric(waz[[1]]))
})

test_that("names is waz", {
  expect_equal(names(waz), "waz")
})


all <- getAllWGS(data = anthro1,
                 sex = "sex",
                 weight = "weight",
                 height = "height",
                 age = "age",
                 index = "all")

test_that("all is a data.frame", {
  expect_is(all, "data.frame")
})

test_that("all cols and rows", {
  expect_equal(ncol(all), 3)
  expect_equal(nrow(all), nrow(anthro1))
})

test_that("names is waz, haz and whz", {
  expect_equal(names(all)[1], "waz")
  expect_equal(names(all)[2], "haz")
  expect_equal(names(all)[3], "whz")
})
