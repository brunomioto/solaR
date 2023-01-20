
<!-- README.md is generated from README.Rmd. Please edit that file -->

# solaR

<!-- badges: start -->
<!-- badges: end -->

The goal of solaR is to …

## Installation

You can install the development version of solaR from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("brunomioto/solaR")
```

## Example

``` r
library(solaR)

get_irradiance()
#> # A tibble: 108 x 3
#>       nm category         value
#>    <dbl> <chr>            <dbl>
#>  1   300 Global           0.008
#>  2   300 Diffuse          0.004
#>  3   300 Direct           0.004
#>  4   300 Extraterrestrial 0.525
#>  5   310 Global           0.142
#>  6   310 Diffuse          0.067
#>  7   310 Direct           0.075
#>  8   310 Extraterrestrial 0.645
#>  9   320 Global           0.332
#> 10   320 Diffuse          0.145
#> # ... with 98 more rows
```
