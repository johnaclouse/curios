test_that("values >= 100 have one decimal place", {
  expect_equal(roundx_n(100.123456), 100.1)
})
test_that("values >= 1 and < 100 have two decimal places", {
  expect_equal(roundx_n(10.123456), 10.12)
})
test_that("values >= 100 have one decimal place", {
  expect_equal(roundx_n(0.123456), 0.123)
})
test_that("negative values are processed by magnitude", {
  expect_equal(roundx_n(-100.123456), -100.1)
})
