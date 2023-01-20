
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

#default values
get_irradiance()
#> # A tibble: 164 x 3
#>       nm category         value
#>    <dbl> <chr>            <dbl>
#>  1   350 Global           0.708
#>  2   350 Diffuse          0.243
#>  3   350 Direct           0.465
#>  4   350 Extraterrestrial 0.994
#>  5   360 Global           0.725
#>  6   360 Diffuse          0.23 
#>  7   360 Direct           0.494
#>  8   360 Extraterrestrial 0.977
#>  9   370 Global           0.883
#> 10   370 Diffuse          0.261
#> # ... with 154 more rows
```
