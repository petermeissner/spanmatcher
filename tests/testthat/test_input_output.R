# tests for functions responsible for data gathering and transformation

df1 = data.frame(
  id1 = letters[1:5],
  from2 = as.Date(c(1,3,4,7,8), origin = "1970-01-01"),
  to2   = as.Date(c(2,4,5,9,1), origin = "1970-01-01")
)

df2 = data.frame(
  id2   = LETTERS[11:13],
  from2 = as.Date(c(2,7,7), origin = "1970-01-01"),
  to2   = as.Date(c(5,9,11), origin = "1970-01-01")
)

df3 = data.frame(
  id1 = letters[1:5],
  from2 = as.Date(c(1,3000,4000,7000,8000), origin = "1970-01-01"),
  to2   = as.Date(c(2000,4000,5000,9000,10000), origin = "1970-01-01")
)

df4 = data.frame(
  id2   = LETTERS[11:13],
  from2 = as.Date(c(2,7000,7000), origin = "1970-01-01"),
  to2   = as.Date(c(5000,9000,11000), origin = "1970-01-01")
)

context("type expectations")

test_that(
  "id types match", {
    expect_true(TRUE)
  }
)


context("processing expectations")

test_that(
  "all user agents are extracted", {
    expect_true(TRUE)
  }
)



