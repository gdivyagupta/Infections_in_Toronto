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

#### Workspace setup ####
library(tidyverse)
library(lubridate)

# Load the simulated dataset
analysis_data <- read_csv("/data/00-simulated_data/simulated_infections_data.csv")

# Test if the data was successfully loaded
if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Check if the dataset has at least 500 rows
if (nrow(analysis_data) >= 500) {
  message("Test Passed: The dataset has at least 500 rows.")
} else {
  stop("Test Failed: The dataset does not have the expected number of rows.")
}

# Check if the dataset has 10 columns (expected number of columns)
if (ncol(analysis_data) == 10) {
  message("Test Passed: The dataset has 10 columns.")
} else {
  stop("Test Failed: The dataset does not have 10 columns.")
}

# Check if all values in the 'Type of Outbreak' column are valid
valid_outbreak_types <- c("Respiratory", "Enteric")

if (all(analysis_data$`Type of Outbreak` %in% valid_outbreak_types)) {
  message("Test Passed: The 'Type of Outbreak' column contains only valid values.")
} else {
  stop("Test Failed: The 'Type of Outbreak' column contains invalid values.")
}

# Check if the 'Outbreak Setting' column contains only valid settings
valid_settings <- c("Hospital", "Long-Term Care Home", "Retirement Home")

if (all(analysis_data$`Outbreak Setting` %in% valid_settings)) {
  message("Test Passed: The 'Outbreak Setting' column contains only valid settings.")
} else {
  stop("Test Failed: The 'Outbreak Setting' column contains invalid settings.")
}

# Check if there are no missing values in critical columns
critical_columns <- c(
  "Institution Name", "Type of Outbreak", "Outbreak Setting", 
  "Date Outbreak Began", "Date Declared Over", "Duration"
)

if (all(!is.na(analysis_data[critical_columns]))) {
  message("Test Passed: There are no missing values in critical columns.")
} else {
  stop("Test Failed: Missing values found in one or more critical columns.")
}

# Check if all durations are positive
if (all(analysis_data$Duration > 0)) {
  message("Test Passed: All durations are positive.")
} else {
  stop("Test Failed: Some durations are not positive.")
}

# Check if the 'Active' column contains only 'Y' or 'N'
valid_active_statuses <- c("Y", "N")

if (all(analysis_data$Active %in% valid_active_statuses)) {
  message("Test Passed: The 'Active' column contains only 'Y' or 'N'.")
} else {
  stop("Test Failed: The 'Active' column contains invalid values.")
}

# Check if the causative agent columns have at least one valid value
valid_agents <- c("COVID-19", "Influenza", "Norovirus", "RSV", "Rhinovirus", "Adenovirus", "None")

if (all(analysis_data$`Causative Agent-1` %in% valid_agents & 
        analysis_data$`Causative Agent-2` %in% valid_agents)) {
  message("Test Passed: The causative agent columns contain only valid values.")
} else {
  stop("Test Failed: Invalid values found in the causative agent columns.")
}

# Check if the dataset has at least two unique healthcare settings
if (n_distinct(analysis_data$`Outbreak Setting`) >= 2) {
  message("Test Passed: The dataset contains at least two unique healthcare settings.")
} else {
  stop("Test Failed: The dataset does not contain enough unique healthcare settings.")
}

