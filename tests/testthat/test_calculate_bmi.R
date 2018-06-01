library(zscorer)
context("Tests for calculate_bmi")

library(zscorer)

test_that("calculate_bmi produces a numeric value", {
  expect_is(calculate_bmi(weight = 14.6, height = 98/100), "numeric")
})

test_that("calculate_bmi_cohort produces a numeric vector", {
  expect_is(calculate_bmi_cohort(weight = anthro1$weight, height = anthro1$height / 100), "numeric")
})
