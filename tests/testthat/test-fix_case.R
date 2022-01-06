test_that("multiplication works", {
  expect_equal(fix_case("usda"), "USDA")
  expect_equal(fix_case("the hba1c level was reported as a1C", case = "lower"), "the HbA1c level was reported as A1c")
  expect_equal(fix_case("the hba1c level was reported as a1C", case = "lower", to_upper_known_acronyms = F), "the hba1c level was reported as a1c")
  expect_equal(fix_case("the hba1c level was reported as a1C", case = "sentence"), "The HbA1c level was reported as A1c")
  expect_equal(fix_case("the hba1c level was reported as a1C", case = "title"), "The HbA1c Level Was Reported as A1c")
})





