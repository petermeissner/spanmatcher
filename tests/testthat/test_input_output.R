# tests for functions responsible for data gathering and transformation
library(spanmatcher)
library(dplyr)

df1 = data.frame(
  id1 = letters[1:5],
  from = c(1,3,4,7,8),
  to   = c(2,4,5,9,10)
)

df2 = data.frame(
  id2   = LETTERS[11:13],
  from = c(2,7,7),
  to   = c(5,9,11)
)

df3 = df1
df3$from <- as.Date(df3$from, origin = "1970-01-01")
df3$to   <- as.Date(df3$to, origin = "1970-01-01")

df4 = df2
df4$from <- as.Date(df4$from, origin = "1970-01-01")
df4$to   <- as.Date(df4$to, origin = "1970-01-01")



context("type expectations")

test_that(
  "types match", {
    expect_true(
      is.numeric(span_matcher(df1,df2)$id1)==is.numeric(df1$id1)
    )
    expect_true(
      class(span_matcher(df1,df2)$from)==class(df1$start)
    )
    expect_true(
      class(span_matcher(df1,df2)$to)==class(df1$end)
    )

    expect_true(
      is.numeric(span_matcher(df3,df4)$id1)==is.numeric(df3$id1)
    )
    expect_true(
      class(span_matcher(df3,df4)$from)==class(df3$start)
    )
    expect_true(
      class(span_matcher(df3,df4)$to)==class(df3$end)
    )

    expect_true(
      is.numeric(span_matcher(df1,df4)$id1)==is.numeric(df1$id1)
    )
    expect_true(
      class(span_matcher(df1,df4)$from)==class(df1$start)
    )
    expect_true(
      class(span_matcher(df1,df4)$to)==class(df1$end)
    )

    expect_true(
      is.numeric(span_matcher(df4,df1)$id1)==is.numeric(df4$id1)
    )
    expect_true(
      class(span_matcher(df4,df1)$from)==class(df4$start)
    )
    expect_true(
      class(span_matcher(df4,df1)$to)==class(df4$end)
    )
  }
)


context("processing expectations - numeric")

dings <- span_matcher(df1, df2)
rows_equal_n  <- function(x,n) dim(x)[1]==n


test_that(
  "spans come out right", {
    expect_true(  dings  %>% filter(id1=="a"  , is.na(id2), start==1 , end==1 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="a"  , id2=="K"  , start==2 , end==2 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="b"  , id2=="K"  , start==3 , end==4 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="c"  , id2=="K"  , start==4 , end==5 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(is.na(id1), is.na(id2), start==6 , end==6 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="d"  , id2=="L"  , start==7 , end==9 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="d"  , id2=="M"  , start==7 , end==9 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="e"  , id2=="M"  , start==8 , end==10) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(is.na(id1), id2=="M"  , start==11, end==11) %>% rows_equal_n(1)   )
  }
)



context("processing expectations - dates")

dings <- span_matcher(df3, df4)
rows_equal_n  <- function(x,n) dim(x)[1]==n


test_that(
  "spans come out right", {
    expect_true(  dings  %>% filter(id1=="a"  , is.na(id2), start==1 , end==1 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="a"  , id2=="K"  , start==2 , end==2 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="b"  , id2=="K"  , start==3 , end==4 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="c"  , id2=="K"  , start==4 , end==5 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(is.na(id1), is.na(id2), start==6 , end==6 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="d"  , id2=="L"  , start==7 , end==9 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="d"  , id2=="M"  , start==7 , end==9 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="e"  , id2=="M"  , start==8 , end==10) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(is.na(id1), id2=="M"  , start==11, end==11) %>% rows_equal_n(1)   )
  }
)



context("splitting after date")

dings <- span_matcher(df1,df2, split_after = c(4,9))

test_that(
  "spans come out right", {
    expect_true(  dings  %>% filter(id1=="a"  , is.na(id2), start==1 , end==1 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="a"  , id2=="K"  , start==2 , end==2 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="b"  , id2=="K"  , start==3 , end==4 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="c"  , id2=="K"  , start==4 , end==4 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="c"  , id2=="K"  , start==5 , end==5 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(is.na(id1), is.na(id2), start==6 , end==6 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="d"  , id2=="L"  , start==7 , end==9 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="d"  , id2=="M"  , start==7 , end==9 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="e"  , id2=="M"  , start==8 , end==9 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="e"  , id2=="M"  , start==10, end==10) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(is.na(id1), id2=="M"  , start==11, end==11) %>% rows_equal_n(1)   )
  }
)



context("splitting before date")

dings <- span_matcher(df1,df2, split_before = c(10))

test_that(
  "spans come out right", {
    expect_true(  dings  %>% filter(id1=="a"  , is.na(id2), start==1 , end==1 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="a"  , id2=="K"  , start==2 , end==2 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="b"  , id2=="K"  , start==3 , end==4 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="c"  , id2=="K"  , start==4 , end==5 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(is.na(id1), is.na(id2), start==6 , end==6 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="d"  , id2=="L"  , start==7 , end==9 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="d"  , id2=="M"  , start==7 , end==9 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="e"  , id2=="M"  , start==8 , end==9 ) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(id1=="e"  , id2=="M"  , start==10, end==10) %>% rows_equal_n(1)   )
    expect_true(  dings  %>% filter(is.na(id1), id2=="M"  , start==11, end==11) %>% rows_equal_n(1)   )
  }
)










