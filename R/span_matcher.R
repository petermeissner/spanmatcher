df1 = data.frame(
  id1 = letters[1:5],
  from2 = c(1,3000,4000,7000,8000),
  to2   = c(2000,4000,5000,9000,10000)
)

df2 = data.frame(
  id2   = letters[11:13],
  from2 = c(2,7000,7000),
  to2   = c(5000,9000,11000)
)


#' function for matching time spans
#' @useDynLib spanmatcher
#' @importFrom Rcpp sourceCpp
#' @export
span_matcher <- function(
  df1 = data.frame(
    id1 = letters[1:5],
    from2 = c(1,3,4,7,8),
    to2   = c(2,4,5,9,10)
  ),
  df2 = data.frame(
    id2   = letters[11:13],
    from2 = c(2,7,7),
    to2   = c(5,9,11)
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



















