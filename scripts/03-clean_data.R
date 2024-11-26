#### Preamble ####
# Purpose: Cleans a dataset of institutional outbreaks in Toronto, including 
#          the type of infection, healthcare setting, causative agents, and 
#          duration of outbreaks.
# Author: Divya Gupta
# Date: 25 November 2024
# Contact: div.gupta@utoronto.ca
# License: University of Tornto, Open Data Toronto
# Pre-requisites: The `tidyverse` and `lubridate` packages must be installed.
# Any other information needed? Make sure you are in the correct R project directory.



# Initial Data Cleaning
cleaned_data <- outbreak_data |>
  # Convert dates to Date format
  (\(df) df |> 
     mutate(
       Date_Outbreak_Began = as.Date(df$`Date Outbreak Began`, format = "%Y-%m-%d"),
       Date_Declared_Over = as.Date(df$`Date Declared Over`, format = "%Y-%m-%d")
     ))() |>
  # Remove rows with missing "Date Declared Over"
  (\(df) df |> filter(!is.na(df$Date_Declared_Over)))() |>
  # Focus on "Respiratory" and "Enteric" infections
  (\(df) df |> filter(df$`Type of Outbreak` %in% c("Respiratory", "Enteric")))() |>
  # Create a duration variable (time difference in days)
  (\(df) df |> 
     mutate(Duration = as.numeric(difftime(df$Date_Declared_Over, df$Date_Outbreak_Began, units = "days"))))() |>
  # Drop unnecessary columns (if any)
  (\(df) df |> select(-starts_with("_")))()


# Check the first few rows of the cleaned data
head(cleaned_data, 10)

# Define the output path for the cleaned dataset
output_path <- "cleaned_outbreak_data.csv"
# Save as .csv file
write_csv(cleaned_data, "data/02-analysis_data/cleaned_dataset.csv")

# Save cleaned_dataset.csv as a parquet file
if (!require("arrow")) install.packages("arrow")
library(arrow)
write_parquet(cleaned_data, "data/02-analysis_data/cleaned_dataset.parquet")


