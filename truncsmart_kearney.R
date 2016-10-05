#' truncsmart
#'
#' @description Some strings are simply too long. This function
#'   cuts a string at a specified linewidth, trying to align cut
#'   with a separator
#'
#' @param textstring target string to shorten
#' @param linewidth integer specifying desired length, in characters, of
#'   returned string(s), taking into account tolerance.
#' @param tol number of characters forward/back to check; if single
#'   value then only backwards checking
#' @param capwidth integer specifying the width of capital letters
#' @param separator accepts 1- or 2-element vector to separate string,
#'   by default = c(" ", "_")
#' @return shortened character string
#' @author Brent Kaplan, Ben Kite, Paul Johnson
#' @examples
#' test <- "123_567_9"
#' (truncsmart(test, 5, tol = c(1,2)))
truncsmart <- function(textstring, linewidth = 10, tol = c(5, 5),
                       capwidth = 1.2, separator = c(" ", "_")) {

    # check paramaters
    stopifnot(is.character(textstring), is.double(linewidth),
        is.double(capwidth), is.character(separator))

    if(length(tol) > 2) stop("Please specify 1 or 2 values for tol.",
        call. = FALSE)
    if(length(capwidth) > 1) stop("Please specify 1 value for capwidth.",
        call. = FALSE)

    # split each character
    ltrs <- strsplit(textstring, split = "")[[1]]

    # dealing with uppercase
    widthval <- return_widthval(ltrs, capwidth)
    linelength <- cumsum(widthval)

    # trunc necessary?
    if(linelength[length(linelength)] <= linewidth) return(textstring)

    # keep text
    withinlength <- linelength <= linewidth

    withintol <- linelength <= (linewidth + max(tol))

    ltrswl <- ltrs[withinlength]
    ltrso <- ltrswl
    ltrswt <- ltrs[withintol]


    if(length(tol) == 2) {
        ltrso1 <- NULL
        ltrso2 <- NULL
        for (j in 0:tol[1]){
            if (ltrswl[length(ltrswl)] %in% separator) {
                ltrso1 <- ltrswl[-length(ltrswl)]
            }
            ltrswl <- ltrswl[-length(ltrswl)]
        }
        for (j in 0:tol[2]) {
            if (ltrswt[length(ltrswt)] %in% separator) {
                ltrso2 <- ltrswt[-length(ltrswt)]
            }
            ltrswt <- ltrswt[-length(ltrswt)]
        }

        if (all(!is.null(ltrso1), !is.null(ltrso2))) {
            ifelse(
                abs((length(ltrso1) - length(ltrs[withinlength]))) <= (length(ltrso2) - length(ltrs[withintol])),
                ltrso <- ltrso1,
                ltrso <- ltrso2)
        } else {
            if (!is.null(ltrso1)) ltrso <- ltrso1
            if (!is.null(ltrso2)) ltrso <- ltrso2
        }
    } else {
        if (ltrswl[length(ltrswl)] %in% separator) {
            ltrso <- ltrswl[-length(ltrswl)]
        }
        ltrswl <- ltrswl[-length(ltrswl)]
    }
    paste0(ltrso, collapse  = "")
}
truncsmart(textstring, 59)

return_widthval <- function(ltrs, capwidth) {
    caps <- vapply(ltrs, function(x) x %in% LETTERS,
        vector("logical", 1), USE.NAMES = FALSE)
    widthval <- rep(1, length(caps))
    widthval[caps] <- capwidth
    widthval
}

# speed test
textstring <- "This is a long string that needs to be Truncated. This is a long string that needs to be Truncated. This is a long string that needs to be truncated. This is a long string that needs to be truncated, and so this is a LONG STRING that needs to be truncated, and so this is a LONG STRING that needs to be truncated, and so this is a LONG STRING that needs to be TRUNCATED."
library(microbenchmark)

microbenchmark(
    truncsmart(textstring, 20),
    truncsmart_og(textstring, 20),
    times = 200L)

ltrs <- strsplit(textstring, split = "")[[1]]
caps <- vapply(ltrs, function(x) x %in% LETTERS,
    vector("logical", 1), USE.NAMES = FALSE)

foo <- function(caps, capwidth) {
        widthval <- rep(1, length(caps))
        widthval[caps] <- capwidth
        widthval
    }
 microbenchmark(
        foo(caps, capwidth),
        ifelse(caps == TRUE, capwidth, 1)
        )

truncsmart <- Vectorize(truncsmart, USE.NAMES = FALSE)

