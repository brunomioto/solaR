
<!-- README.md is generated from README.Rmd. Please edit that file -->

# solarcalc

<!-- badges: start -->
<!-- badges: end -->

The goal of solarcalc is to …

## Installation

You can install the development version of solarcalc from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("brunomioto/solarcalc")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(solarcalc)
## basic example code
```

``` r
get_irradiance()
#> # A tibble: 108 x 3
#>    nm    category value
#>    <chr> <chr>    <chr>
#>  1 560.0 Global   1.704
#>  2 550.0 Global   1.739
#>  3 540.0 Global   1.736
#>  4 530.0 Global   1.746
#>  5 520.0 Global   1.696
#>  6 510.0 Global   1.793
#>  7 500.0 Global   1.782
#>  8 490.0 Global   1.752
#>  9 480.0 Global   1.883
#> 10 470.0 Global   1.834
#> # ... with 98 more rows
```
