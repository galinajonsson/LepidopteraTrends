# Long-term Lepidoptera Trends - Model development and diagnosis

Author(s): [Galina M. Jönsson](https://github.com/galinajonsson)

This repository contains all the code for:

>Jönsson, G. M. 2023. Chapter 2. Development and diagnosis of occupancy models for integrating historical specimens and contemporary data. *[PhD Thesis]*.


## Data
As of 20 May 2023, I have not uploaded the expert scores for the same reason as below. 


## Analyses
The analyses code is contained in one multiple .Rmd files that run the analyses for the chapter and associated supplementary materials. More detailed scripts for some functions used in analyses and called by the .Rmd file, and scripts for the figures found in the chapter.

Note that throughout I've commented out `write.csv` and `saveRDS` commands in order to not clog up your machine. For code chunks that run the models, I've set `eval` to FALSE, again, to not clog up your machine as the analyses are computationally expensive and were run on high performance machines.

* __00-XX.dm__ [description]. 


## Other folders

* `/plots` contains the figures with file names matching those of the manuscript


## Session Info
For reproducibility purposes, here is the output of devtools::session_info() used to perform the analyses in the publication.
```
─ Session info ─────────────────────────────────────────────────────────────────────────────────────────
 setting  value
 version  R version 4.0.2 (2020-06-22)
 os       OS X  13.3.1
 system   x86_64, darwin17.0
 ui       RStudio
 language (EN)
 collate  en_GB.UTF-8
 ctype    en_GB.UTF-8
 tz       Europe/London
 date     2023-05-20
 rstudio  2022.07.2+576 Spotted Wakerobin (desktop)
 pandoc   2.19.2 @ /Applications/RStudio.app/Contents/MacOS/quarto/bin/tools/ (via rmarkdown)

─ Packages ─────────────────────────────────────────────────────────────────────────────────────────────
 package     * version date (UTC) lib source
 abind         1.4-5   2016-07-21 [2] CRAN (R 4.0.2)
 assertthat    0.2.1   2019-03-21 [2] CRAN (R 4.0.2)
 backports     1.4.1   2021-12-13 [2] CRAN (R 4.0.2)
 broom         1.0.3   2023-01-25 [2] CRAN (R 4.0.2)
 cachem        1.0.6   2021-08-19 [2] CRAN (R 4.0.2)
 callr         3.7.0   2021-04-20 [2] CRAN (R 4.0.2)
 car           3.1-1   2022-10-19 [2] CRAN (R 4.0.2)
 carData       3.0-5   2022-01-06 [2] CRAN (R 4.0.5)
 cli           3.6.0   2023-01-09 [2] CRAN (R 4.0.2)
 colorspace    2.0-3   2022-02-21 [2] CRAN (R 4.0.5)
 crayon        1.5.2   2022-09-29 [2] CRAN (R 4.0.2)
 DBI           1.1.3   2022-06-18 [2] CRAN (R 4.0.2)
 devtools      2.4.5   2022-10-11 [2] CRAN (R 4.0.2)
 digest        0.6.29  2021-12-01 [2] CRAN (R 4.0.2)
 dplyr         1.0.10  2022-09-01 [2] CRAN (R 4.0.2)
 ellipsis      0.3.2   2021-04-29 [2] CRAN (R 4.0.2)
 evaluate      0.20    2023-01-17 [2] CRAN (R 4.0.2)
 fansi         1.0.4   2023-01-22 [2] CRAN (R 4.0.2)
 fastmap       1.1.0   2021-01-25 [2] CRAN (R 4.0.2)
 fs            1.5.2   2021-12-08 [2] CRAN (R 4.0.2)
 generics      0.1.3   2022-07-05 [2] CRAN (R 4.0.2)
 ggplot2       3.4.0   2022-11-04 [2] CRAN (R 4.0.2)
 ggpubr        0.4.0   2020-06-27 [2] CRAN (R 4.0.2)
 ggsignif      0.6.1   2021-02-23 [2] CRAN (R 4.0.2)
 glue          1.6.2   2022-02-24 [2] CRAN (R 4.0.5)
 gtable        0.3.1   2022-09-01 [2] CRAN (R 4.0.2)
 htmltools     0.5.2   2021-08-25 [2] CRAN (R 4.0.2)
 htmlwidgets   1.5.3   2020-12-10 [2] CRAN (R 4.0.2)
 httpuv        1.6.5   2022-01-05 [2] CRAN (R 4.0.5)
 knitr         1.33    2021-04-24 [2] CRAN (R 4.0.2)
 later         1.3.0   2021-08-18 [2] CRAN (R 4.0.2)
 lifecycle     1.0.3   2022-10-07 [2] CRAN (R 4.0.2)
 magrittr      2.0.3   2022-03-30 [2] CRAN (R 4.0.5)
 memoise       2.0.1   2021-11-26 [2] CRAN (R 4.0.2)
 mime          0.12    2021-09-28 [2] CRAN (R 4.0.2)
 miniUI        0.1.1.1 2018-05-18 [2] CRAN (R 4.0.2)
 munsell       0.5.0   2018-06-12 [2] CRAN (R 4.0.2)
 pillar        1.8.1   2022-08-19 [2] CRAN (R 4.0.2)
 pkgbuild      1.4.0   2022-11-27 [2] CRAN (R 4.0.2)
 pkgconfig     2.0.3   2019-09-22 [2] CRAN (R 4.0.2)
 pkgload       1.3.2   2022-11-16 [2] CRAN (R 4.0.2)
 prettyunits   1.1.1   2020-01-24 [2] CRAN (R 4.0.2)
 processx      3.5.3   2022-03-25 [2] CRAN (R 4.0.5)
 profvis       0.3.7   2020-11-02 [2] CRAN (R 4.0.2)
 promises      1.2.0.1 2021-02-11 [2] CRAN (R 4.0.2)
 ps            1.6.0   2021-02-28 [2] CRAN (R 4.0.2)
 purrr         1.0.1   2023-01-10 [2] CRAN (R 4.0.2)
 R6            2.5.1   2021-08-19 [2] CRAN (R 4.0.2)
 Rcpp          1.0.10  2023-01-22 [2] CRAN (R 4.0.2)
 remotes       2.4.2   2021-11-30 [2] CRAN (R 4.0.2)
 rlang         1.0.6   2022-09-24 [2] CRAN (R 4.0.2)
 rmarkdown     2.20    2023-01-19 [2] CRAN (R 4.0.2)
 rsconnect     0.8.29  2023-01-09 [2] CRAN (R 4.0.2)
 rstatix       0.7.1   2022-11-09 [2] CRAN (R 4.0.2)
 rstudioapi    0.14    2022-08-22 [2] CRAN (R 4.0.2)
 scales        1.2.1   2022-08-20 [2] CRAN (R 4.0.2)
 sessioninfo   1.2.2   2021-12-06 [2] CRAN (R 4.0.2)
 shiny         1.6.0   2021-01-25 [2] CRAN (R 4.0.2)
 stringi       1.7.12  2023-01-11 [2] CRAN (R 4.0.2)
 stringr       1.5.0   2022-12-02 [2] CRAN (R 4.0.2)
 tibble        3.1.8   2022-07-22 [2] CRAN (R 4.0.2)
 tidyr         1.3.0   2023-01-24 [2] CRAN (R 4.0.2)
 tidyselect    1.2.0   2022-10-10 [2] CRAN (R 4.0.2)
 urlchecker    1.0.1   2021-11-30 [2] CRAN (R 4.0.2)
 usethis       2.1.6   2022-05-25 [2] CRAN (R 4.0.2)
 utf8          1.2.2   2021-07-24 [2] CRAN (R 4.0.2)
 vctrs         0.5.2   2023-01-23 [2] CRAN (R 4.0.2)
 xfun          0.36    2022-12-21 [2] CRAN (R 4.0.2)
 xtable        1.8-4   2019-04-21 [2] CRAN (R 4.0.2)
 yaml          2.3.5   2022-02-21 [2] CRAN (R 4.0.5)

 [1] /Users/galinajonsson/Library/R/4.0/library
 [2] /Library/Frameworks/R.framework/Versions/4.0/Resources/library

────────────────────────────────────────────────────────────────────────────────────────────────────────
```