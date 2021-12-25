test_that("create_toc_entries creates a vector with 4 values", {
  expect_equal(length(create_toc_entries(
    system.file("extdata", "curios-test-flexdashboard.html", package = "curios")
  )), 4)
})

