#### Preamble ####
# Purpose: Tests a dataset of institutional outbreaks in Toronto, including 
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
library(testthat)

# Load the cleaned/analysis dataset
analysis_data <- read_csv("data/02-analysis_data/cleaned_dataset.csv")


#### Test data ####

# Test that the dataset has at least 500 rows
test_that("dataset has at least 500 rows", {
  expect_true(nrow(analysis_data) >= 500)
})

# Test that the dataset has exactly 10 columns
test_that("dataset has 10 columns", {
  expect_equal(ncol(analysis_data), 10)
})

# Test that the 'Type of Outbreak' column contains only valid values
valid_outbreak_types <- c("Respiratory", "Enteric")
test_that("'Type of Outbreak' contains only valid values", {
  expect_true(all(analysis_data$`Type of Outbreak` %in% valid_outbreak_types))
})

# Test that the 'Outbreak Setting' column contains only valid settings
valid_settings <- c("Hospital", "Long-Term Care Home", "Retirement Home")
test_that("'Outbreak Setting' contains only valid settings", {
  expect_true(all(analysis_data$`Outbreak Setting` %in% valid_settings))
})

# Test that the dataset contains no missing values in critical columns
critical_columns <- c(
  "Institution Name", "Type of Outbreak", "Outbreak Setting", 
  "Date Outbreak Began", "Date Declared Over", "Duration"
)
test_that("no missing values in critical columns", {
  expect_true(all(!is.na(analysis_data[critical_columns])))
})

# Test that the 'Duration' column contains only positive values
test_that("all durations are positive", {
  expect_true(all(analysis_data$Duration > 0))
})

# Test that the 'Active' column contains only 'Y' or 'N'
valid_active_statuses <- c("Y", "N")
test_that("'Active' contains only 'Y' or 'N'", {
  expect_true(all(analysis_data$Active %in% valid_active_statuses))
})

# Test that the 'Causative Agent-1' column contains valid agent names
valid_agents <- c("COVID-19", "Influenza", "Norovirus", "RSV", "Rhinovirus", "Adenovirus", "None")
test_that("'Causative Agent-1' contains valid values", {
  expect_true(all(analysis_data$`Causative Agent-1` %in% valid_agents))
})

# Test that there are at least two unique values in 'Outbreak Setting'
test_that("'Outbreak Setting' contains at least two unique values", {
  expect_true(length(unique(analysis_data$`Outbreak Setting`)) >= 2)
})

# Test that the 'Duration' column has reasonable maximum and minimum values
test_that("'Duration' column values are within a reasonable range", {
  expect_true(max(analysis_data$Duration, na.rm = TRUE) <= 90)
  expect_true(min(analysis_data$Duration, na.rm = TRUE) >= 1)
})

