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

haz <- getAllWGS(data = anthro1,
                 sex = "sex",
                 weight = "weight",
                 height = "height",
                 age = "age",
                 index = "hfa")

test_that("haz is a data.frame", {
  expect_is(haz, "data.frame")
})

test_that("haz is numeric", {
  expect_true(is.numeric(haz[[1]]))
})

test_that("names is haz", {
  expect_equal(names(haz), "haz")
})

whz <- getAllWGS(data = anthro1,
                 sex = "sex",
                 weight = "weight",
                 height = "height",
                 age = "age",
                 index = "wfh")

test_that("whz is a data.frame", {
  expect_is(whz, "data.frame")
})

test_that("whz is numeric", {
  expect_true(is.numeric(whz[[1]]))
})

test_that("names is whz", {
  expect_equal(names(whz), "whz")
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

test_that("produces error", {
  expect_error(getAllWGS(sex = "sex", weight = "weight", height = "height", age = "age", index = "wfa"),
               "If data provided, sex, weight and age must be numeric. Try again.")
})

waz <- getAllWGS(sex = anthro1$sex,
                 weight = anthro1$weight,
                 height = anthro1$height,
                 age = anthro1$age,
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

test_that("produces error", {
  expect_error(getAllWGS(data = anthro1, sex = anthro1$sex, weight = anthro1$weight, height = anthro1$height, age = anthro1$age, index = "wfa"),
               "If data not provided, sex, weight and age must be character values. Try again")
})

test_that("produces error", {
  expect_error(getAllWGS(sex = "sex", weight = "weight", height = "height", age = "age", index = "hfa"),
               "If data provided, sex, height and age must be numeric. Try again.")
})

haz <- getAllWGS(sex = anthro1$sex,
                 weight = anthro1$weight,
                 height = anthro1$height,
                 age = anthro1$age,
                 index = "hfa")

test_that("haz is a data.frame", {
  expect_is(haz, "data.frame")
})

test_that("haz is numeric", {
  expect_true(is.numeric(haz[[1]]))
})

test_that("names is haz", {
  expect_equal(names(haz), "haz")
})

test_that("produces error", {
  expect_error(getAllWGS(data = anthro1, sex = anthro1$sex, weight = anthro1$weight, height = anthro1$height, age = anthro1$age, index = "hfa"),
               "If data not provided, sex, height and age must be character values. Try again")
})

test_that("produces error", {
  expect_error(getAllWGS(sex = "sex", weight = "weight", height = "height", age = "age", index = "wfh"),
               "If data provided, sex, weight and height must be numeric. Try again.")
})

whz <- getAllWGS(sex = anthro1$sex,
                 weight = anthro1$weight,
                 height = anthro1$height,
                 age = anthro1$age,
                 index = "wfh")

test_that("produces error", {
  expect_error(getAllWGS(data = anthro1, sex = anthro1$sex, weight = anthro1$weight, height = anthro1$height, age = anthro1$age, index = "wfh"),
               "If data not provided, sex, weight and height must be character values. Try again")
})
