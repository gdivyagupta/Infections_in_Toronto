# Load libraries
library(rstanarm)
library(brms)
library(tidyverse)
library(ggeffects)
library(ggplot2)

# Load the cleaned dataset
cleaned_data <- read_csv("cleaned_outbreak_data.csv")

# Ensure categorical variables are factors
cleaned_data <- cleaned_data |>
  mutate(
    Type_of_Outbreak = as.factor(`Type of Outbreak`),  # Outcome for logistic regression
    Outbreak_Setting = as.factor(`Outbreak Setting`),  # Predictor
    Causative_Agent_1 = as.factor(`Causative Agent-1`),  # Predictor
    Month = factor(lubridate::month(`Date Outbreak Began`, label = TRUE)),  # Categorical month
    Active = as.numeric(Active == "Y")  # For survival analysis censoring (1 = ongoing)
  )

# Model - Bayesian Logistic Regression 
# To predict the probability of respiratory outbreaks

# Construct the logistic regression model
logistic_model <- stan_glm(
  Type_of_Outbreak ~ Outbreak_Setting + Causative_Agent_1 + Month,
  data = cleaned_data,
  family = binomial(link = "logit"),  # Logistic regression
  prior = normal(0, 2.5),            # Weakly informative prior
  prior_intercept = normal(0, 5),    # Prior for intercept
  chains = 4, iter = 2000, seed = 123
)

# Model summary
summary(logistic_model)

# Default posterior predictive check (histogram)
pp_check(logistic_model) +
  labs(
    title = "Posterior Predictive Check: Observed vs. Predicted Outcomes",
    x = "Outcome (Type of Outbreak: Enteric = 0, Respiratory = 1)",
    y = "Density"
  ) +
  theme_minimal()

# Overlay observed and predicted densities (use density comparison)
pp_check(logistic_model, overlay = TRUE) +
  labs(
    title = "Posterior Predictive Check: Density Overlay",
    x = "Probability of Respiratory Outbreak",
    y = "Density"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom") +
  guides(color = guide_legend(title = "Legend")) +
  scale_color_manual(
    values = c("y" = "black", "yrep" = "lightblue"),
    labels = c("Observed Data (y)", "Predicted Data (yrep)")
  )

# Visualisations with the model
logistic_model |> posterior_summary()

# Plot credible intervals with axis labels and title
plot(logistic_model, type = "intervals") +
  labs(
    title = "Posterior Estimates and 95% Credible Intervals",
    x = "Effect Size (Log-Odds)",
    y = "Predictors"
  ) +
  theme_minimal()

# Generate predicted values
predicted <- ggpredict(logistic_model, terms = c("Outbreak_Setting", "Causative_Agent_1"))

# Plot with sufficient colors
plot(predicted) +
  scale_color_manual(values = scales::hue_pal()(20)) +  # Generate a palette with at least 20 colors
  labs(
    title = "Predicted Probabilities by Outbreak Setting and Causative Agent",
    x = "Outbreak Setting",
    y = "Predicted Probability",
    color = "Causative Agent"
  ) +
  theme_minimal()






