test_that("multiplication works", {
  expect_equal(alignx_n(c(0.12345, 1.123344, 100.12345)),
               c("0.123", "1.12&numsp;", "100.1&numsp;&numsp;"))
})
