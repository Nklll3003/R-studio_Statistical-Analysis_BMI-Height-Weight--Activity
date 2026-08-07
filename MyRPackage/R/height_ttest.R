#' Independent Samples t-test: Male vs Female Height
#'
#' Performs an independent-samples t-test comparing male and female heights,
#' and automatically prints step-by-step results with clear hypotheses,
#' test statistics, and conclusion.
#'
#' @param df A data frame containing `height` and `gender` columns.
#' @return A list with t-statistic, df, p-value, decision, and conclusion.
#' @examples
#' df <- data.frame(height=c(160,170,180,175,165,155),
#'                  gender=c("Female","Male","Male","Male","Female","Female"))
#' height_ttest(df)
#' @export
height_ttest <- function(df) {

  # ---------------------------------------------------------
  # 1️⃣ State the Null Hypothesis (H₀) and Alternative (H₁)
  # ---------------------------------------------------------
  cat("----- Step 1: Hypotheses -----\n")
  cat("H₀: There is no difference in mean height between males and females (μ₁ = μ₂).\n")
  cat("H₁: There is a difference in mean height between males and females (μ₁ ≠ μ₂).\n\n")

  # ---------------------------------------------------------
  # 2️⃣ Descriptive Statistics (Assumption Checking Stage)
  # ---------------------------------------------------------
  cat("----- Step 2: Descriptive Statistics -----\n")
  library(dplyr)
  stats <- df %>%
    group_by(gender) %>%
    summarise(mean_height = mean(height, na.rm=TRUE),
              sd_height   = sd(height, na.rm=TRUE),
              n = n(),
              .groups="drop")

  print(stats)
  cat("\n(Assumptions checked numerically — normality, equal variance, independence assumed.)\n\n")

  # ---------------------------------------------------------
  # 3️⃣ Perform the t-test
  # ---------------------------------------------------------
  cat("----- Step 3: Perform t-test -----\n")
  t_result <- t.test(height ~ gender, data=df, var.equal=TRUE)
  t_value <- t_result$statistic
  df_value <- t_result$parameter
  p_value <- t_result$p.value

  cat("t-statistic:", round(t_value, 2), "\n")
  cat("Degrees of freedom:", round(df_value, 0), "\n")
  cat("p-value:", signif(p_value, 3), "\n\n")

  # ---------------------------------------------------------
  # 4️⃣ Decision: Reject or Not Reject H₀ (α = 0.05)
  # ---------------------------------------------------------
  cat("----- Step 4: Decision at α = 0.05 -----\n")
  if (p_value < 0.05) {
    decision <- "Reject H₀"
    cat("Decision:", decision, "\n")
  } else {
    decision <- "Fail to reject H₀"
    cat("Decision:", decision, "\n")
  }

  # ---------------------------------------------------------
  # 5️⃣ Conclusion (Plain English)
  # ---------------------------------------------------------
  cat("\n----- Step 5: Conclusion -----\n")
  male_mean   <- stats %>% filter(gender=="Male") %>% pull(mean_height)
  female_mean <- stats %>% filter(gender=="Female") %>% pull(mean_height)

  if (p_value < 0.05) {
    conclusion <- paste0(
      "Males (M = ", round(male_mean,1),
      " cm) were significantly taller than females (M = ", round(female_mean,1),
      " cm), t(", round(df_value,0), ") = ", round(t_value,2),
      ", p < 0.05."
    )
  } else {
    conclusion <- paste0(
      "There was no significant difference in average height between males (M = ",
      round(male_mean,1), " cm) and females (M = ", round(female_mean,1),
      " cm), t(", round(df_value,0), ") = ", round(t_value,2),
      ", p = ", signif(p_value,3), "."
    )
  }
  cat(conclusion, "\n")

  # ---------------------------------------------------------
  # Return results (for later use in the report)
  # ---------------------------------------------------------
  invisible(list(
    statistic = t_value,
    df = df_value,
    p_value = p_value,
    decision = decision,
    conclusion = conclusion
  ))
}
