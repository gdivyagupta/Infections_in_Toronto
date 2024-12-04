library(forcats)
library(ggplot2)

cleaned_data -> read_csv("data/02-analysis_data/cleaned_dataset.csv")

# EDA 
# Visual 1 - number of outbreaks by outbreak type
cleaned_data |> 
  ggplot(aes(x = `Type of Outbreak`, fill = `Type of Outbreak`)) +
  geom_bar() +
  labs(
    title = "Distribution of Outbreak Types",
    x = "Type of Outbreak",
    y = "Count"
  ) +
  theme_minimal()

# Visual 2 - Outbreak count by setting
cleaned_data |> 
  ggplot(aes(x = fct_infreq(`Outbreak Setting`), fill = `Outbreak Setting`)) +
  geom_bar() +
  coord_flip() +
  labs(
    title = "Outbreak Counts by Healthcare Setting",
    x = "Healthcare Setting",
    y = "Count"
  ) +
  theme_minimal()


# Visual 3 - Interaction between Outbreak Type and Setting
cleaned_data |> 
  ggplot(aes(x = `Outbreak Setting`, fill = `Type of Outbreak`)) +
  geom_bar(position = "fill") +
  coord_flip() +
  labs(
    title = "Proportion of Outbreak Types by Setting",
    x = "Healthcare Setting",
    y = "Proportion"
  ) +
  theme_minimal()

# Visual 4 - Interaction between Outbreak Duration, Causative Agent and Setting
# Density plot for outbreak duration
cleaned_data |> 
  ggplot(aes(x = Duration, fill = `Causative Agent-1`, color = `Causative Agent-1`)) +
  geom_density(alpha = 0.3) +
  facet_wrap(~ `Outbreak Setting`, scales = "free_y") +
  labs(
    title = "Outbreak Duration by Causative Agent and Setting",
    x = "Outbreak Duration (days)",
    y = "Density",
    fill = "Causative Agent",
    color = "Causative Agent"
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    legend.text = element_text(size = 8),
    legend.title = element_text(size = 10)
  )


