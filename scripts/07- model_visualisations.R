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







