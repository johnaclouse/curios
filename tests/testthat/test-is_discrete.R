test_that("multiplication works", {
  expect_equal(is_discrete(1:10), TRUE)
  expect_equal(is_discrete(runif(1000)), FALSE)
})
