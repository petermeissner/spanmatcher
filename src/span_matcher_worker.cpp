#include <iostream>
#include <vector>
#include <Rcpp.h>
using namespace Rcpp;
using namespace std;

// [[Rcpp::plugins(cpp11)]]
// [[Rcpp::export]]

DataFrame span_matcher_worker(DataFrame df1, DataFrame df2) {

  // put info in neat litle vectors
  CharacterVector id_one_in = df1[0];
  IntegerVector   start_one_in = df1[1];
  IntegerVector   end_one_in   = df1[2];


  CharacterVector id_two_in = df2[0];
  IntegerVector   start_two_in = df2[1];
  IntegerVector   end_two_in   = df2[2];

  // determine span length
  int min_start_one = min(start_one_in);
  int min_start_two = min(start_two_in);

  int max_end_one = max(end_one_in);
  int max_end_two = max(end_two_in);

  int min_span = min(min_start_one, min_start_two) ;
  int max_span = max(max_end_one, max_end_two);

  // put days:ids into multimap
  multimap<int, string> days_id_one;
  multimap<int, string> days_id_two;

  for( int i = 0; i < id_one_in.size(); i++ ){
    for (int day = start_one_in[i]; day <= end_one_in[i]; day++ ){
      days_id_one.insert(pair<int, string>(day, as<string>(id_one_in[i]) ));
    }
  }

  for( int i = 0; i < id_two_in.size(); i++ ){
    for (int day = start_two_in[i]; day <= end_two_in[i]; day++ ){
      days_id_two.insert(pair<int, string>(day, as<string>(id_two_in[i])));
    }
  }


  // access the columns
  IntegerVector days;
  CharacterVector id_one ;
  CharacterVector id_two ;

  for (int i = min_span; i <= max_span; i++) {
    // no matches
    if( days_id_one.count(i)==0 && days_id_two.count(i)==0 ){
      days.push_back(i);
      id_one.push_back(NA_STRING);
      id_two.push_back(NA_STRING);
      continue;
    }
    // matches for one but not for two
    if( days_id_one.count(i)>0 && days_id_two.count(i)==0 ){
      auto range = days_id_one.equal_range(i);
      for (auto iterate = range.first; iterate != range.second; ++iterate) {
        days.push_back(i);
        id_one.push_back(iterate->second);
        id_two.push_back(NA_STRING);
      }
      continue;
    }
    // matches for two but not for one
    if( days_id_one.count(i)==0 && days_id_two.count(i)>0 ){
      auto range = days_id_two.equal_range(i);
      for (auto iterate = range.first; iterate != range.second; ++iterate) {
        days.push_back(i);
        id_one.push_back(NA_STRING);
        id_two.push_back(iterate->second);
      }
      continue;
    }
    // matches in both
    if( days_id_one.count(i)>0 && days_id_two.count(i)>0 ){
      auto range = days_id_one.equal_range(i);
      for (auto it = range.first; it != range.second; it++) {
        auto range_two = days_id_two.equal_range(i);
        for (auto it_two = range_two.first; it_two != range_two.second; it_two++) {
          days.push_back(i);
          id_one.push_back(it->second);
          id_two.push_back(it_two->second);
        }
      }
    }
  };

  // return a new data frame
  return DataFrame::create(
    _["days"]=days,
    _["id_one"]=id_one,
    _["id_two"]=id_two)
    ;
}

















