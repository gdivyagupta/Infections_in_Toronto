#### Preamble ####
# Purpose: Downloads and saves the healthcare institutional outbreak data from OpenDataToronto
# Author: Divya Gupta
# Date: 25 November 2024
# Contact: div.gupta@utoronto.ca
# License: University of Toronto, Open Data Toronto
# Pre-requisites: 
# - The `opendatatoronto` and `tidyverse` packages must be installed and loaded.

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

#### Download data ####

# Get the package (replace with the correct package ID for the dataset)
package <- show_package("80ce0bd7-adb2-4568-b9d7-712f6ba38e4e")

# View package details (optional, for verification)
print(package)

# Get all resources for this package
resources <- list_package_resources("80ce0bd7-adb2-4568-b9d7-712f6ba38e4e")

# Identify datastore resources (CSV or GeoJSON)
datastore_resources <- resources %>%
  filter(tolower(format) %in% c("csv", "geojson"))

# Download the first resource as a sample
healthcare_outbreak_data <- datastore_resources %>%
  filter(row_number() == 1) %>%
  get_resource()

#### Save data ####
# Define the path to save the raw data
output_path <- "data/01-raw_data/raw_data.csv"

# Save the dataset to a CSV file
write_csv(raw_data, output_path)


