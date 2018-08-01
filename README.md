
<!-- README.md is generated from README.Rmd. Please edit that file -->
aidR
====

tatata lalala

Installation
------------

You can install aidR from github with:

``` r
# install.packages("devtools")
devtools::install_github("schliebs/aidR")
```

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
aidR::downloadRawAidData(dataset = "China",
                   folder = "rawdata",
                   filename = "MyChinaData")
#> Warning in dir.create(folder, showWarnings = TRUE): 'rawdata' existiert
#> bereits
#> Please cite as follows:
#> 
#> for Academic Purposes: Dreher, A., Fuchs, A., Parks, B.C., Strange, A. M., & Tierney, M. J. (2017). Aid, China, and Growth: Evidence from a New Global Development Finance Dataset. AidData Working Paper #46. Williamsburg, VA: AidData.
#> 
#> For other Purposes: AidData. 2017. Global Chinese Official Finance Dataset, Version 1.0. Retrieved from http://aiddata.org/data/chinese-global-official-finance-dataset.
#> Writing MyChinaData.zip to 'rawdata'
```
