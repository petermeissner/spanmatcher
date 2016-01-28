#' function for matching time spans
#' @useDynLib spanmatcher
#' @importFrom Rcpp sourceCpp
#' @export
span_matcher <- function(
  df1,
  df2,
  split_after=NULL,
  split_before=NULL
)
{

  # input checking
  stopifnot( dim(df1)[2]==3 )
  stopifnot( dim(df2)[2]==3 )

  # input conversion
  input_was_date <- class(df1[[2]])=="Date"
  df1[[1]]     <- as.character(df1[[1]])
  df2[[1]]     <- as.character(df2[[1]])
  df1[[2]]     <- as.integer(df1[[2]])
  df2[[2]]     <- as.integer(df2[[2]])
  df1[[3]]     <- as.integer(df1[[3]])
  df2[[3]]     <- as.integer(df2[[3]])

  split_after  <- as.integer(split_after)
  split_before <- as.integer(split_before)

  # matching and joining
  matched <- span_matcher_worker(df1, df2)

  matched[[2]] <- as.character(matched[[2]])
  matched[[3]] <- as.character(matched[[3]])

  matched[[2]][is.na(matched[[2]])] <- "na_na_na_na_na"
  matched[[3]][is.na(matched[[3]])] <- "na_na_na_na_na"

  res     <- aggregate(matched$days, by=list(matched$id_one, matched$id_two), min)
  res$end <- aggregate(matched$days, by=list(matched$id_one, matched$id_two), max)$x
  names(res) <- c("id1", "id2", "start", "end")

  res[[1]][res[[1]]=="na_na_na_na_na"] <- NA
  res[[2]][res[[2]]=="na_na_na_na_na"] <- NA

  # splitting according to dates supplied
  for ( i in seq_along(split_after) ){
    iffer <- res$start <= split_after[i]  & res$end  > split_after[i]
    if( sum(iffer) > 0 ){
      tmp1 <- res[iffer, ]
      tmp1$end <- split_after[i]
      tmp2 <- res[iffer, ]
      tmp2$start <- split_after[i]+1
      res <- rbind(res[!iffer, ],tmp1, tmp2)
    }
  }
  for ( i in seq_along(split_before) ){
    iffer <- res$start < split_before[i]  & res$end  >= split_before[i]
    if( sum(iffer) > 0 ){
      tmp1  <- res[iffer, ]
      tmp1$end <- split_before[i]-1
      tmp2 <- res[iffer, ]
      tmp2$start <- split_before[i]
      res <- rbind(res[!iffer, ],tmp1, tmp2)
    }
  }

  # type conversion
  res$id1   <- as(res$id1, class(df1[[1]]))
  res$id2   <- as(res$id2, class(df2[[1]]))
  if( input_was_date ){
    res$start <- as.Date(res$start, origin="1970-01-01")
    res$end   <- as.Date(res$end, origin="1970-01-01")
  }else{
    try(res$start <- as(res$start, class(df1[[2]])))
    try(res$end   <- as(res$end, class(df1[[2]])))
  }

  names(res)[1] <- names(df1)[1]
  names(res)[2] <- names(df2)[1]


  # output
  res    <- res[order(res$start, res$id1, res$id2),]
  row.names(res) <- NULL
  res <- cbind(span_id=seq_along(res$id1),res)
  return(res)
}



















