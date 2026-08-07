# BMI, Height, Weight & Physical Activity Analysis

A statistical analysis project examining the relationships between height, weight, gender, and physical activity in a sample of 1,000 individuals aged 26–45. Built in R using Quarto for reporting and a custom R package for reusable, testable analysis functions.

---

## 📋 Project Overview

This project addresses three research questions using a dataset of 1,000 individuals:

1. Is there a linear relationship between height and weight?
2. Is the average height the same for males and females?
3. Is there an association between gender and physical activity level?

The project is split into two complementary parts:

- **Part I — Statistical Report**: research questions answered using base R statistical functions (`lm()`, `t.test()`, `chisq.test()`), with full methodology, hypotheses, and interpretation.
- **Part II — R Package Application**: the same analyses re-implemented as reusable functions inside a custom R package (`MyRPackage`), complete with unit tests and applied to both the real and a simulated ("mock") dataset to verify reproducibility.

## 📊 Key Findings

| Question | Result |
|---|---|
| Height vs. Weight | Statistically significant positive linear relationship (p < 0.001) |
| Height: Male vs. Female | Males significantly taller than females (M = 178cm vs. 168cm, p < 0.001) |
| Gender vs. Physical Activity | No significant association (χ²(2) = 2.37, p = 0.306) |

## 📦 MyRPackage Functions

| Function | Purpose |
|---|---|
| `hw_lm_analysis(df, plot = TRUE)` | Tests the linear relationship between height and weight |
| `height_ttest(df)` | Independent-samples t-test comparing male and female heights |
| `gender_activity_chisq(df, plot = TRUE)` | Chi-square test of association between gender and physical activity |

### Example Usage

```r
library(MyRPackage)

df <- read.csv("bmi_height_weight_activity_data.csv")

res1 <- hw_lm_analysis(df, plot = TRUE)
cat("Conclusion:", res1$conclusion, "\n")

res2 <- height_ttest(df)
cat("Conclusion:", res2$conclusion, "\n")

res3 <- gender_activity_chisq(df, plot = TRUE)
cat("Conclusion:", res3$conclusion, "\n")
```

## ▶️ How to Run

**Requirements:**
- R (≥ 4.0)
- [Quarto](https://quarto.org/docs/get-started/) (for rendering `.qmd` files)
- R packages: `dplyr`, `ggplot2`, `devtools`, `testthat`

**Steps:**

1. Clone the repository:
```bash
   git clone https://github.com/NkIII3003/R-studio_Statistical-Analysis_BMI-Height-Weight--Activity.git
   cd R-studio_Statistical-Analysis_BMI-Height-Weight--Activity
```
2. Install the package locally:
```r
   library(devtools)
   install("MyRPackage")
```
3. Open and render either report in RStudio or via terminal:
```bash
   quarto render 01_statistical_analysis_report.qmd
   quarto render 02_rpackage_applied_analysis.qmd
```

> **Note:** File paths in the `.qmd` files were originally set for a local machine. Update the `datafile` path in the YAML header (or the `read.csv()` calls) to point to `bmi_height_weight_activity_data.csv` in this repository before rendering.

## 🧪 Methodology

- **Linear Regression** — tests whether weight can be predicted from height (`Weight = β₀ + β₁·Height + ε`)
- **Independent Samples t-test** — compares mean height between male and female groups, assuming equal variances
- **Chi-square Test of Independence** — tests whether gender and physical activity level are associated

A simulated ("mock") dataset with matching structure was also used to confirm the analysis pipeline is correctly parameterised and reproducible.

## 🛠️ Tech Stack / Skills Demonstrated

- **Languages & Tools:** R, Quarto, R Markdown
- **Statistics:** Linear regression, hypothesis testing, t-tests, chi-square tests
- **Packages:** `dplyr`, `ggplot2`, `devtools`, `testthat`, `roxygen2`
- **Software Engineering:** custom R package development, unit testing, reproducible reporting

## 📄 License

Add a license (e.g. MIT) here if you'd like others to reuse this code.

## ✍️ Author

Nattapon P
