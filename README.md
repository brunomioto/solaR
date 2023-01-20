
<!-- README.md is generated from README.Rmd. Please edit that file -->

# solaR

<!-- badges: start -->
<!-- badges: end -->

The goal of solaR is to …

## Installation

You can install the development version of solarcalc from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("brunomioto/solaR")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
#library(solaR)
## basic example code
```

``` r
get_irradiance()
#> # A tibble: 108 x 3
#>    nm    category         value
#>    <chr> <chr>            <chr>
#>  1 300.0 Global           0.008
#>  2 300.0 Diffuse          0.004
#>  3 300.0 Direct           0.004
#>  4 300.0 Extraterrestrial 0.525
#>  5 310.0 Global           0.142
#>  6 310.0 Diffuse          0.067
#>  7 310.0 Direct           0.075
#>  8 310.0 Extraterrestrial 0.645
#>  9 320.0 Global           0.332
#> 10 320.0 Diffuse          0.145
#> # ... with 98 more rows
```
