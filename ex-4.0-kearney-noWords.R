cat("\n\n Basics \n\n")

# arithmatic
1 + 2 + 3
3 - 1
2^2
sqrt(4)
1 / 10
3 * 2

# store objects
x <- 1 + 2 + 3
y <- sqrt(4)
z <- x * y

# list objects
ls()

# sequences
1:6
seq(1, 10, by = 1)
seq(1, 7, length.out = 10)

# check object class
x <- 1 + 2 + 3
class(x)
y <- 3L
class(y)
z <- seq(1, 7, length.out = 10)
class(z)

# integer vs numeric
x <- as.numeric(1)
class(x)

x <- as.integer(1)
class(x)

x <- 1L
class(x)

# clear memory
rm(list = ls())

# brackets
x <- seq(1L, 10L, 1L)
x[3]
x[2:6]
x[c(1, 4, 5)]
x[x > 6]
x[-10]
x[-c(2,3)]

# quick check
stopifnot(is.integer(x))
stopifnot(is.character(x))

# boolean
5 %% 2 == 0
x <- seq(1, 10, 1)
y <- x %% 2 == 0
y
class(y)
which(y == FALSE)
which(!y)

logical_index <- which(y == TRUE)
words <- c("Apple", "Blueberry", "Change", "Dog", "Elaphant")
words[logical_index]

N <- 30L
x <- rnorm(N)
length(x)
class(x)
head(x)
y <- rnorm(N) + x

xy <- data.frame(x, y)
xy
colnames(xy)
dim(xy)
class(xy)

print(letters)
z <- replicate(N, paste0(sample(letters, 5), collapse = ""))
xyz <- data.frame(x, y, z)
xyz
str(xyz)

xyz <- data.frame(x, y, z, stringsAsFactors = FALSE)
str(xyz)


