### TESTS ###

# tests number of observations
simulated_shelter_data |>
  nrow() == 1095

# test class
simulated_shelter_data$shelter |>
  class() == "character"

# test that there are no years greater than 2023
simulated_shelter_data$date |>
  lubridate::year() %>% 
  max() == 2023