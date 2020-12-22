
test_that("output is numeric", {
  expect_is(getCDC(sex = 1,
                   firstPart = 5.7,
                   secondPart = 10,
                   index = "wfa",
                   standing = 3), "numeric")
})


test_that("output is NA", {
  expect_true(is.na(getCDC(sex = NA,
                           firstPart = 5.7,
                           secondPart = 10,
                           index = "wfa",
                           standing = 3)))
})


test_that("output is NA", {
  expect_true(is.na(getCDC(sex = 1,
                           firstPart = NA,
                           secondPart = 10,
                           index = "wfa",
                           standing = 3)))
})


test_that("output is NA", {
  expect_true(is.na(getCDC(sex = 1,
                           firstPart = 5.7,
                           secondPart = NA,
                           index = "wfa",
                           standing = 3)))
})


test_that("output is NA", {
  expect_true(is.na(getCDC(sex = 1,
                           firstPart = 5.7,
                           secondPart = 10,
                           index = NA,
                           standing = 3)))
})


