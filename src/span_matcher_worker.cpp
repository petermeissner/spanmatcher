#include <iostream>
#include <Rcpp.h>
using namespace Rcpp;
using namespace std;


// This is a simple function using Rcpp that creates an R list
// containing a character vector and a numeric vector.
//
// Learn more about how to use Rcpp at:
//
//   http://www.rcpp.org/
//   http://adv-r.had.co.nz/Rcpp.html
//
// and browse examples of code using Rcpp at:
//
//   http://gallery.rcpp.org/
//

// [[Rcpp::export]]

DataFrame span_matcher_worker(DataFrame df1, DataFrame df2) {

  // put info in neat litle vectors
  CharacterVector id_one_in    = df1[0];
  IntegerVector   start_one_in = df1[1];
  IntegerVector   end_one_in   = df1[2];

  CharacterVector id_two_in    = df2[0];
  IntegerVector   start_two_in = df2[1];
  IntegerVector   end_two_in   = df2[2];

  // determine span length
  int min_start_one = min(start_one_in);
  int min_start_two = min(start_two_in);

  int max_end_one = max(end_one_in);
  int max_end_two = max(end_two_in);

  int min_span = min(min_start_one, min_start_two) ;
  int max_span = max(max_end_one, max_end_two);

  // storage for output
  CharacterVector id_one    = df1[0];
  IntegerVector   start_one = df1[1];
  IntegerVector   end_one   = df1[2];

  CharacterVector id_two    = df2[0];
  IntegerVector   start_two = df2[1];
  IntegerVector   end_two   = df2[2];

  // access the columns
  IntegerVector dings;

  for (int i = min_span; i < max_span; i++) {
    dings.push_back(i);
  };

  // return a new data frame
  return DataFrame::create(_["dings"]=dings);
}

















