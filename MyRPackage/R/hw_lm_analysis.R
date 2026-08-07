#' Height vs Weight Linear Regression Analysis
#'
#' Performs a simple linear regression to test if there is a significant
#' linear relationship between height and weight. It prints step-by-step
#' results including hypotheses, model summary, decision, and conclusion.
#'
#' @param df A data frame containing at least two columns: height and weight
#' @param plot Logical. If TRUE, plots scatter plot with regression line
#' @return A list with regression summary, p-value, decision, and conclusion
#' @examples
#' df <- data.frame(height=c(160,170,180), weight=c(50,65,80))
#' hw_lm_analysis(df)
#' @export
hw_lm_analysis <- function(df, plot = TRUE) {

  # ---------------------------------------------------------
  # 1️⃣ State the Hypotheses
  # ---------------------------------------------------------
  cat("----- Step 1: Hypotheses -----\n")
  cat("H₀: There is no linear relationship between height and weight (β₁ = 0).\n")
  cat("H₁: There is a linear relationship between height and weight (β₁ ≠ 0).\n\n")

  # ---------------------------------------------------------
  # 2️⃣ Visualise the data (numerical and graphical summaries)
  # ---------------------------------------------------------
  cat("----- Step 2: Descriptive and Graphical Summary -----\n")
  cat("Numerical summary of height and weight:\n")
  summary_df <- data.frame(
    Variable = c("Height", "Weight"),
    Mean = c(mean(df$height, na.rm=TRUE), mean(df$weight, na.rm=TRUE)),
    SD = c(sd(df$height, na.rm=TRUE), sd(df$weight, na.rm=TRUE)),
    Min = c(min(df$height, na.rm=TRUE), min(df$weight, na.rm=TRUE)),
    Max = c(max(df$height, na.rm=TRUE), max(df$weight, na.rm=TRUE))
  )
  print(summary_df)
  cat("\n(Assumptions: linearity, homoscedasticity, independence, and normal residuals.)\n\n")

  if (plot) {
    plot(df$height, df$weight,
         xlab = "Height (cm)", ylab = "Weight (kg)",
         main = "Height vs Weight with Regression Line",
         pch = 19, col = "darkblue")
    abline(lm(weight ~ height, data=df), col = "red", lwd = 2)
  }

  # ---------------------------------------------------------
  # 3️⃣ Fit the Linear Regression Model
  # ---------------------------------------------------------
  cat("----- Step 3: Regression Model -----\n")
  model <- lm(weight ~ height, data=df)
  model_summary <- summary(model)
  print(model_summary$coefficients)
  cat("\n")

  # Extract key stats
  beta1 <- model_summary$coefficients[2,1]
  se_beta1 <- model_summary$coefficients[2,2]
  t_value <- model_summary$coefficients[2,3]
  p_value <- model_summary$coefficients[2,4]

  cat("Slope (β₁):", round(beta1, 3), "\n")
  cat("t-statistic:", round(t_value, 2), "\n")
  cat("p-value:", signif(p_value, 3), "\n\n")

  # ---------------------------------------------------------
  # 4️⃣ Decision (Reject or Fail to Reject H₀)
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
  if (p_value < 0.05) {
    conclusion <- paste0(
      "There is a statistically significant positive linear relationship between height and weight. ",
      "This means taller individuals tend to weigh more, ",
      "t = ", round(t_value, 2), ", p < 0.05."
    )
  } else {
    conclusion <- paste0(
      "There is no significant linear relationship between height and weight, ",
      "t = ", round(t_value, 2), ", p = ", signif(p_value, 3), "."
    )
  }
  cat(conclusion, "\n")

  # ---------------------------------------------------------
  # Return as structured output (for Quarto report)
  # ---------------------------------------------------------
  invisible(list(
    slope = beta1,
    t_value = t_value,
    p_value = p_value,
    decision = decision,
    conclusion = conclusion,
    summary = model_summary
  ))
}
