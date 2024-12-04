# Load libraries
library(rstanarm)
library(brms)
library(tidyverse)
library(ggeffects)
library(ggplot2)

# Load the cleaned dataset
cleaned_data <- read_csv("data/02-analysis_data/cleaned_dataset.csv")

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

# Save the logistic model as an RDS file
saveRDS(logistic_model, "models/model.rds")


