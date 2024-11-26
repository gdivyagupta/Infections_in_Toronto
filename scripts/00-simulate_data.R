#### Preamble ####
# Purpose: Simulates a dataset of institutional outbreaks in Toronto, including 
#          the type of infection, healthcare setting, causative agents, and 
#          duration of outbreaks.
# Author: Divya Gupta
# Date: 25 November 2024
# Contact: div.gupta@utoronto.ca
# License: University of Tornto, Open Data Toronto
# Pre-requisites: The `tidyverse` and `lubridate` packages must be installed.
# Any other information needed? Make sure you are in the correct R project directory.
# Output: This script generates a file named `simulated_infections_data.csv` 
#         containing the simulated data.


# Load necessary library
library(dplyr)
library(lubridate)

# Set seed for reproducibility
set.seed(123)

# Number of records to simulate
n <- 500

# Simulate data
simulated_data <- tibble(
  `Institution Name` = paste("Institution", sample(1:100, n, replace = TRUE)),
  `Institution Address` = paste0(sample(1:999, n, replace = TRUE), " ", sample(c("Main St", "King St", "Queen St", "Bay St"), n, replace = TRUE)),
  `Outbreak Setting` = sample(c("Hospital", "Long-Term Care Home", "Retirement Home"), n, replace = TRUE, prob = c(0.4, 0.4, 0.2)),
  `Type of Outbreak` = sample(c("Respiratory", "Enteric"), n, replace = TRUE, prob = c(0.6, 0.4)),
  `Causative Agent-1` = sample(c("COVID-19", "Influenza", "Norovirus", "RSV"), n, replace = TRUE),
  `Causative Agent-2` = sample(c("None", "Rhinovirus", "Adenovirus"), n, replace = TRUE, prob = c(0.8, 0.1, 0.1)),
  `Date Outbreak Began` = sample(seq(as.Date("2023-01-01"), as.Date("2024-11-01"), by = "day"), n, replace = TRUE),
  Duration = sample(5:30, n, replace = TRUE), # Simulate durations between 5 and 30 days
  `Date Declared Over` = `Date Outbreak Began` + Duration,
  Active = ifelse(runif(n) < 0.2, "Y", "N") # 20% of outbreaks are still active
)

# Display the first few rows
head(simulated_data)

# Save the simulated dataset
write_csv(simulated_data, "/Users/Dell/Desktop/Infections in Toronto/simulated_infections_data.csv")
