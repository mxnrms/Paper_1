# simulation

library(tidyverse)
library(opendatatoronto)
library(janitor)

# cleaning data

### Basic cleaning ###
cleaned_shelter_system_data <-
  clean_names(raw_shelter_system_data)
### Renaming variables ###
cleaned_shelter_system_data <-
  cleaned_shelter_system_data |>
  rename(
    date = date_mmm_yy,
    group = population_group
  )
## Separate month and year ##
cleaned_shelter_system_data <-
  cleaned_shelter_system_data |>
  separate(
    col = date,
    into = c("month", "year"),
    sep = "-"
  )
## Save cleaned data ##
write_csv(
  x = cleaned_shelter_system_data,
  file = "cleaned_shelter_system_data.csv"
)