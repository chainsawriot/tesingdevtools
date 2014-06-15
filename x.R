winsorMean <- function(x, alpha=0.05) {
    maxTolerance <- quantile(x, probs=c(1 - (alpha/2)))
    minTolerance <- quantile(x, probs=c(0 + (alpha/2)))
    winsoredx <- x[x < maxTolerance & x > minTolerance]
    return(mean(winsoredx))
}

stupid <- function() {
    ddply(iris, .(Species), summarise, meansl = mean(Sepal.Length))
}
