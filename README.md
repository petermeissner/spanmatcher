# spanmatcher
Peter Meissner  
28 Januar 2016  







**Status:** working but experimental and possibly subject to change

**Author:** Peter Meißner

**Licence:** GPL-2

**Description:**

Merging time span data used for survival analysis via building new
    spans out of overlapping spans. For each context change (id1 data changes |
    id2 data changes)  a new span is formed. Spans neither covered within
    dataset 1 nor 2 are put into separate spans.


**Installation and start - development version**


```r
devtools::install_github("petermeissner/spanmatcher")
library(spanmatcher)
```

**Usage**

Loading the package and making up some data ... 


```r
library(spanmatcher)

df1 = data.frame(
  id1 = paste(letters[1:5], round(runif(5)*10000), sep="_" ),
  from2 = as.Date(c(1,3000,4000,7000,8000), origin = "1960-01-01"),
  to2   = as.Date(c(2000,4000,5000,9000,10000), origin = "1960-01-01")
)

df2 = data.frame(
  id2   = paste(LETTERS[11:13], round(runif(3)*10000), sep="_" ),
  from2 = as.Date(c(2,7000,7000), origin = "1960-01-01"),
  to2   = as.Date(c(5000,9000,11000), origin = "1960-01-01")
) 
```

... having a look at the data ... 


```r
df1
```

```
##      id1      from2        to2
## 1 a_2094 1960-01-02 1965-06-23
## 2 b_5594 1968-03-19 1970-12-14
## 3 c_8344 1970-12-14 1973-09-09
## 4 d_9865 1979-03-02 1984-08-22
## 5 e_9883 1981-11-26 1987-05-19
```

```r
df2
```

```
##      id2      from2        to2
## 1 K_4979 1960-01-03 1973-09-09
## 2 L_3472 1979-03-02 1984-08-22
## 3 M_9195 1979-03-02 1990-02-12
```


Mergin/joining the data.


```r
head(span_matcher(df1, df2))
```

```
##      id1    id2 start   end
## 1 a_2094 K_4979 -3651 -1653
## 2 b_5594 K_4979  -653   347
## 3 c_8344 K_4979   347  1347
## 4 d_9865 L_3472  3347  5347
## 5 e_9883 L_3472  4347  5347
## 6 d_9865 M_9195  3347  5347
```



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


