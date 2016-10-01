-   [ch-01](#ch-01)
    -   [simple loop](#simple-loop)
    -   [vectorise](#vectorise)
    -   [speed test](#speed-test)

ch-01
=====

simple loop
-----------

Matloff says to keep it simple, so prefer oddcount1 over oddcount2.

    oddcount1 <- function(x) {
      k <- 0
      for (n in x) {
        if (n %% 2 == 1) k <- k + 1
      }
      return(k)
    }

    oddcount2 <- function(x) {
      k <- 0
      for (i in 1:length(x)) {
        if (x[i] %% 2 == 1) k <- k + 1
      }
      return(k)
    }

vectorise
---------

Could also get rid of the loop entirely.

    oddcount3 <- function(x) {
      sum(x %% 2 == 1)
    }

speed test
----------

    library(microbenchmark)

    x <- sample(1:200, 50)
    mb <- microbenchmark(
      "simple" = oddcount1(x),
      "c--ish" = oddcount2(x),
      "vector" = oddcount3(x)
    )

    mb

    ## Unit: microseconds
    ##    expr    min      lq     mean  median      uq    max neval
    ##  simple 23.583 24.9245 28.80404 27.3605 31.9195 47.685   100
    ##  c--ish 32.433 34.6315 39.47292 40.1635 41.7885 72.112   100
    ##  vector  2.181  2.4620  2.81914  2.6070  2.7895 17.942   100

    Unit: microseconds
       expr    min      lq     mean  median      uq     max neval
     simple 24.357 25.0635 34.05510 25.9325 31.2460 109.947   100
     c--ish 33.380 35.1320 47.63017 36.4185 45.4605 140.943   100
     vector  2.412  2.7055  4.09381  2.8715  3.9835  20.515   100
