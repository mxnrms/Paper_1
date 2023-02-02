# acquire

library(tidyverse)
library(opendatatoronto)

#### RETURNED FROM HOUSING ###
### BAR Graph return from housing for families ###
ggplot(data=returned_from_housing_data, aes(x = year, y = returned_from_housing, fill = year)) +
  geom_bar(stat = "identity") +
  ggtitle("Families Returned From Permanent Housing Between 2018 and 2022") +
  theme_minimal() +
  labs(
    x = "Year",
    y = "Returned from Housing"
  )+
  theme(legend.position = "none") +
  scale_fill_brewer(palette = "set3")
### LINE Graph return from housing for families ###
ggplot(data=returned_from_housing_data, aes(x = year, y = returned_from_housing, fill = year)) +
  geom_line(stat = "identity") +
  ggtitle("Families Returned From Permanent Housing Between 2018 and 2022") +
  theme_minimal() +
  labs(
    x = "Year",
    y = "Returned from Housing"
  )+
  theme(legend.position = "none")

### LINE Graph return from housing for youth ###
ggplot(data=returned_from_housing_youthdata, aes(x = year, y = returned_from_housing, fill = year)) +
  geom_line(stat = "identity") +
  ggtitle("Youth Returned From Permanent Housing Between 2018 and 2022") +
  theme_minimal() +
  labs(
    x = "Year",
    y = "Returned from Housing"
  )+
  theme(legend.position = "none")

#### MOVED TO HOUSING ####
### BAR Graph moved to housing for families ###
ggplot(data=moved_to_housing_data, aes(x = year, y = moved_to_housing, fill = year)) +
  geom_bar(stat = "identity") +
  ggtitle("Families Moved to Permanent Housing Between 2018 and 2022") +
  theme_minimal() +
  labs(
    x = "Year",
    y = "Moved to Housing"
  )+
  theme(legend.position = "none") +
  scale_fill_brewer(palette = "set3")
### LINE Graph moved to housing for families ###
ggplot(data=moved_to_housing_data, aes(x = year, y = moved_to_housing, fill = year)) +
  geom_line(stat = "identity") +
  ggtitle("Families Moved to Permanent Housing Between 2018 and 2022") +
  theme_minimal() +
  labs(
    x = "Year",
    y = "Moved to Housing"
  )+
  theme(legend.position = "none")

### LINE Graph moved to housing for youth ###
ggplot(data=moved_to_housing_youthdata, aes(x = year, y = moved_to_housing, fill = year)) +
  geom_line(stat = "identity") +
  ggtitle("Youth Moved to Permanent Housing Between 2018 and 2022") +
  theme_minimal() +
  labs(
    x = "Year",
    y = "Moved to Housing"
  )+
  theme(legend.position = "none")

#### TABLE ####
## FAMILIES ##
# returned from housing mean table 
cleaned_shelter_system_data |>
  select(group, year, returned_from_housing) |>
  filter(group == "Families") |>
  group_by(year) |>
  summarise(families_mean = mean(returned_from_housing)) |>
  knitr::kable()

# moved to housing mean table
cleaned_shelter_system_data |>
  select(group, year, moved_to_housing) |>
  filter(group == "Families") |>
  group_by(year) |>
  summarise(families_mean = mean(moved_to_housing)) |>
  knitr::kable()


## YOUTH ##
# mean table 
cleaned_shelter_system_data |>
  select(
    group, 
    year, 
    returned_from_housing, 
    moved_to_housing, 
    actively_homeless) |>
  filter(group == "Youth") |>
  group_by(year) |>
  summarise(
    return_from_housing = mean(returned_from_housing), 
    moved_to_housing = mean(moved_to_housing), 
    actively_homeless_youth = mean(actively_homeless)) |>
  knitr::kable()
