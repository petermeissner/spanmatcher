# spanmatcher
Peter Meissner  
28 Januar 2016  






<br><br>
**Status:** working but experimental and possibly subject to change

**Author:** Peter Meißner

**Licence:** GPL-2

**Description:**

Merging time span data used for survival analysis via building new
    spans out of overlapping spans. For each context change (id1 data changes |
    id2 data changes)  a new span is formed. Spans neither covered within
    dataset 1 nor 2 are put into separate spans.



<br><br>
**Installation and start - development version**


```r
devtools::install_github("petermeissner/spanmatcher")
library(spanmatcher)
```



<br><br>
**Usage**

Loading the package and making up some data


```r
library(spanmatcher)

df1 = data.frame(
  id1 = letters[1:5],
  from2 = as.Date(c(1,3,4,7,8), origin = "1970-01-01"),
  to2   = as.Date(c(2,4,5,9,10), origin = "1970-01-01")
)

df2 = data.frame(
  id2   = LETTERS[11:13],
  from2 = as.Date(c(2,7,7), origin = "1970-01-01"),
  to2   = as.Date(c(5,9,11), origin = "1970-01-01")
) 

df1
```

```
##   id1      from2        to2
## 1   a 1970-01-02 1970-01-03
## 2   b 1970-01-04 1970-01-05
## 3   c 1970-01-05 1970-01-06
## 4   d 1970-01-08 1970-01-10
## 5   e 1970-01-09 1970-01-11
```

```r
df2
```

```
##   id2      from2        to2
## 1   K 1970-01-03 1970-01-06
## 2   L 1970-01-08 1970-01-10
## 3   M 1970-01-08 1970-01-12
```


Mergin/joining the data


```r
span_matcher(df1, df2)
```

```
##     id1  id2      start        end
## 1     a <NA> 1970-01-02 1970-01-02
## 2     a    K 1970-01-03 1970-01-03
## 3     b    K 1970-01-04 1970-01-05
## 4     c    K 1970-01-05 1970-01-06
## 5  <NA> <NA> 1970-01-07 1970-01-07
## 6     d    L 1970-01-08 1970-01-10
## 7     d    M 1970-01-08 1970-01-10
## 8     e    L 1970-01-09 1970-01-10
## 9     e    M 1970-01-09 1970-01-11
## 10 <NA>    M 1970-01-12 1970-01-12
```


Splitting spans


```r
span_matcher(df1,df2, split_after = c(4))
```

```
##     id1  id2      start        end
## 1     a <NA> 1970-01-02 1970-01-02
## 2     a    K 1970-01-03 1970-01-03
## 3     b    K 1970-01-04 1970-01-05
## 4     c    K 1970-01-05 1970-01-05
## 5     c    K 1970-01-06 1970-01-06
## 6  <NA> <NA> 1970-01-07 1970-01-07
## 7     d    L 1970-01-08 1970-01-10
## 8     d    M 1970-01-08 1970-01-10
## 9     e    L 1970-01-09 1970-01-10
## 10    e    M 1970-01-09 1970-01-11
## 11 <NA>    M 1970-01-12 1970-01-12
```

```r
span_matcher(df1,df2, split_before = c(10))
```

```
##     id1  id2      start        end
## 1     a <NA> 1970-01-02 1970-01-02
## 2     a    K 1970-01-03 1970-01-03
## 3     b    K 1970-01-04 1970-01-05
## 4     c    K 1970-01-05 1970-01-06
## 5  <NA> <NA> 1970-01-07 1970-01-07
## 6     d    L 1970-01-08 1970-01-10
## 7     d    M 1970-01-08 1970-01-10
## 8     e    L 1970-01-09 1970-01-10
## 9     e    M 1970-01-09 1970-01-10
## 10    e    M 1970-01-11 1970-01-11
## 11 <NA>    M 1970-01-12 1970-01-12
```



<br><br>
**Contribution**

Please note that this project is released with a Contributor Code of Conduct. By participating in this project you agree to abide by its terms:

> As contributors and maintainers of this project, we pledge to respect all people who 
contribute through reporting issues, posting feature requests, updating documentation,
submitting pull requests or patches, and other activities.
> 
> We are committed to making participation in this project a harassment-free experience for
everyone, regardless of level of experience, gender, gender identity and expression,
sexual orientation, disability, personal appearance, body size, race, ethnicity, age, or religion.
> 
> Examples of unacceptable behavior by participants include the use of sexual language or
imagery, derogatory comments or personal attacks, trolling, public or private harassment,
insults, or other unprofessional conduct.
> 
> Project maintainers have the right and responsibility to remove, edit, or reject comments,
commits, code, wiki edits, issues, and other contributions that are not aligned to this 
Code of Conduct. Project maintainers who do not follow the Code of Conduct may be removed 
from the project team.
> 
> Instances of abusive, harassing, or otherwise unacceptable behavior may be reported by 
opening an issue or contacting one or more of the project maintainers.
> 
> This Code of Conduct is adapted from the Contributor Covenant 
(http:contributor-covenant.org), version 1.0.0, available at 
http://contributor-covenant.org/version/1/0/0/


