# Assignment: ex-5-forsapply

x <- replicate(10, rnorm(10))
foo <- function(x) {
  c(mean = mean(x), median = median(x),
    min = min(x), max = max(x),
    sd = sd(x), var = var(x))
}
apply(x, 2, foo)

