#' function for matching time spans

span_matcher <- function(
  df1 = data.frame(
    id1 = letters[1:4],
    from2 = c(1,3,6,8),
    to2   = c(2,4,7,10)
    ),
  df2 = data.frame(
    id2   = letters[11:3],
    from2 = c(2,6,8),
    to2   = c(5,7,18)
    ),
  split_after=NA,
  split_before=NA
)
{

  # input checking
  stopifnot( dim(df1)[2]==3 )
  stopifnot( dim(df2)[2]==3 )

  # input conversion
  df1[[1]]     <- as.character(df1[[1]])
  df1[[2]]     <- as.integer(df1[[2]])
  df1[[3]]     <- as.integer(df1[[3]])

  df2[[1]]     <- as.character(df2[[1]])
  df2[[2]]     <- as.integer(df2[[2]])
  df2[[3]]     <- as.integer(df2[[3]])

  split_after  <- as.integer(split_after)
  split_before <- as.integer(split_before)

  # output conversion

  # output
  return(span_matcher_worker(df1, df2))
}
