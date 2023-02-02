# simulation

library(tidyverse)
library(opendatatoronto)
library(janitor)

# cleaning data

############ Basic cleaning ############ 
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

############ RETURNED FROM HOUSING ############ 
## Select youth ##
returned_from_housing_data <-
  cleaned_shelter_system_data |>
  filter(
    group == 'Youth'
  )
## Selecting year and returned_from_housing variables ##
returned_from_housing_data <-
  returned_from_housing_data |>
  select(
    year,
    returned_from_housing
  )
## Group year and sum up return_from_housing ##
returned_from_housing_data <-
  returned_from_housing_data %>%
  group_by(year) %>%
  summarise(returned_from_housing = sum(returned_from_housing))
## Save cleaned RFH data ##
write_csv(
  x = returned_from_housing_data,
  file = "returned_from_housing_data.csv"
)

#### ALL GROUPS #### 
all_returned_from_housing_data <-
  cleaned_shelter_system_data
## select relevant variables ##
all_returned_from_housing_data <-
  all_returned_from_housing_data |>
  select(
    year,
    group,
    returned_from_housing
  )
## Group year and sum up return_from_housing ##
all_returned_from_housing_data <-
  all_returned_from_housing_data %>%
  group_by(year, group) %>%
  summarise(returned_from_housing = sum(returned_from_housing))
## Save cleaned data ##
write_csv(
  x = all_returned_from_housing_data,
  file = "all_returned_from_housing_data.csv"
)


############ MOVED TO HOUSING ############ 
## Select youth ##
moved_to_housing_data <-
  cleaned_shelter_system_data |>
  filter(
    group == 'Youth'
  )
### Selecting moved_to_housing variable ###
moved_to_housing_data <-
  moved_to_housing_data |>
  select(
    year,
    moved_to_housing
  )
## Group year and sum up return_from_housing ##
moved_to_housing_data <-
  moved_to_housing_data %>%
  group_by(year) %>%
  summarise(moved_to_housing = sum(moved_to_housing))
## Save cleaned data ##
write_csv(
  x = moved_to_housing_data,
  file = "moved_to_housing_data.csv"
)

#### ALL GROUPS ####
all_moved_to_housing_data <-
  cleaned_shelter_system_data
## select relevant variables ##
all_moved_to_housing_data <-
  all_moved_to_housing_data |>
  select(
    year,
    group,
    moved_to_housing
  )
## Group year and sum up return_from_housing ##
all_moved_to_housing_data <-
  all_moved_to_housing_data %>%
  group_by(year, group) %>%
  summarise(moved_to_housing = sum(moved_to_housing))
## Save cleaned data ##
write_csv(
  x = all_moved_to_housing_data,
  file = "all_moved_to_housing_data.csv"
)