#' Print method for hw_lm_analysis result
#' @export
print.hw_lm_analysis <- function(x, ...) {
  cat("Height–Weight Linear Regression Test\n")
  cat("-----------------------------------\n")
  cat("P-value:", signif(x$p_value, 4), "\n")
  cat("Conclusion:", x$conclusion, "\n")
}

#' Print method for height_ttest result
#' @export
print.height_ttest <- function(x, ...) {
  cat("Independent Samples t-Test: Male vs Female Height\n")
  cat("-------------------------------------------------\n")
  cat("t =", round(x$statistic, 2), ", df =", round(x$df, 0), ", p =", signif(x$p_value, 3), "\n")
  cat("Conclusion:", x$conclusion, "\n")
}

#' Print method for gender_activity_chisq result
#' @export
print.gender_activity_chisq <- function(x, ...) {
  cat("Chi-square Test: Gender vs Physical Activity\n")
  cat("--------------------------------------------\n")
  cat("χ² =", round(x$statistic, 2), ", df =", x$df, ", p =", signif(x$p_value, 3), "\n")
  cat("Conclusion:", x$conclusion, "\n")
}
