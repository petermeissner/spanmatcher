// This file was generated by Rcpp::compileAttributes
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// span_matcher_worker
DataFrame span_matcher_worker(DataFrame df1, DataFrame df2);
RcppExport SEXP spanmatcher_span_matcher_worker(SEXP df1SEXP, SEXP df2SEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< DataFrame >::type df1(df1SEXP);
    Rcpp::traits::input_parameter< DataFrame >::type df2(df2SEXP);
    __result = Rcpp::wrap(span_matcher_worker(df1, df2));
    return __result;
END_RCPP
}
