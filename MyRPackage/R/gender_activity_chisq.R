#' Chi-square Test: Gender vs Physical Activity
#'
#' Tests the association between gender and physical activity level.
#' @param df Data frame with `gender` and `phys` columns.
#' @param plot Logical. If TRUE, draw a bar chart.
#' @return A list with chi-square statistic, df, p-value, and conclusion.
#' @export
gender_activity_chisq <- function(df, plot=TRUE) {
  tbl <- table(df$gender, df$phys)
  chi <- chisq.test(tbl)
  chi_p <- chi$p.value
  chi_value <- chi$statistic
  chi_df <- chi$parameter

  if (chi_p < 0.05) {
    conclusion <- paste0("Significant association between gender and physical activity, χ²(", chi_df, ")=", round(chi_value,2), ", p<0.05.")
  } else {
    conclusion <- paste0("No significant association between gender and physical activity, χ²(", chi_df, ")=", round(chi_value,2), ", p=", signif(chi_p,3), ".")
  }

  if (plot) {
    ggplot2::ggplot(df, ggplot2::aes(x = gender, fill = phys)) +
      ggplot2::geom_bar(position = "dodge") +
      ggplot2::labs(
        title = "Gender vs Physical Activity",
        x = "Gender", y = "Count", fill = "Physical Activity Level"
      ) +
      ggplot2::theme_minimal(base_size = 14)
  }

  structure(list(statistic=chi_value, df=chi_df, p_value=chi_p, conclusion=conclusion, table=tbl),
            class="gender_activity_chisq")
}
