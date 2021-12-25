# curios
A compendium of curios used in support of practical data science. From the Jim Arledge school of, "I've never written and original line of code in my life", the assembled functions have been meticulously appropriated from better developers and data scientists.

<!-- badges: start -->

[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)[![R-CMD-check](https://github.com/johnaclouse/curios/workflows/R-CMD-check/badge.svg)](https://github.com/johnaclouse/curios/actions)
[![Codecov test coverage](https://codecov.io/gh/johnaclouse/curios/branch/main/graph/badge.svg)](https://app.codecov.io/gh/johnaclouse/curios?branch=main)
<!-- badges: end -->

## Curios web site

https://johnaclouse.github.io/curios/

## Flexdashboard support functions

### create_toc_entries

Load a given html document, parse for H3 html nodes and return them as a vector formatted for use as a table of contents. Motivated by separating different phases of data science pipeline into separate html documents and the need to create a master table of contents across subpages.
