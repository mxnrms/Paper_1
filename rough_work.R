### Preamble ###
# Purpose: Read in data from the Toronto Shelter System Flow and make a
# graph of the number of families that used overnight servies.
# Author: Aliyah Maxine Ramos
# Email: aliyahmaxine.ramos@mail.utoronto.ca
# Date: 31 January 2023

install.packages("tidyverse")
install.packages("opendatatoronto")
install.packages("janitor")
install.packages("usethis")
install.packages("gitcreds")

library(tidyverse)
library(opendatatoronto)
library(usethis)
library(gitcreds)
library(janitor)

### Read in the data ###

library(opendatatoronto)
library(dplyr)

# get package
package <- show_package("ac77f532-f18b-427c-905c-4ae87ce69c93")
package

# get all resources for this package
resources <- list_package_resources("ac77f532-f18b-427c-905c-4ae87ce69c93")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()
data

### Save raw data ###
write_csv(
  x = data,
  file = "raw_shelter_system_data.csv"
)

### Basic cleaning ###
cleaned_shelter_system_data <-
  clean_names(data)
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

####### done up till here

### Selecting returned_from_housing variable ###
returned_from_housing_data <-
  cleaned_shelter_system_data |>
  select(
    year,
    group,
    returned_from_housing
  )
## Select families ##
returned_from_housing_data <-
  returned_from_housing_data |>
  filter(
    group == 'Families'
  )
## group year and sum up return_from_housing ##
returned_from_housing_data <-
  returned_from_housing_data %>%
    group_by(year) %>%
    summarise(returned_from_housing = sum(returned_from_housing))
### Graph return from housing for families ###
ggplot(data=returned_from_housing_data, aes(x = year, y = returned_from_housing, fill = year)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(
    x = "Year",
    y = "Returned from Housing"
  )+
  theme(legend.position = "none") +
  scale_fill_brewer(palette = "set3")
## Save cleaned RFH data ##
write_csv(
  x = returned_from_housing_data,
  file = "returned_from_housing_data.csv"
)


### Selecting moved_to_housing variable ###
moved_to_housing_data <-
  cleaned_shelter_system_data |>
  select(
    year,
    group,
    moved_to_housing
  )
## Select families ##
moved_to_housing_data <-
  moved_to_housing_data |>
  filter(
    group == 'Families'
  )
## group year and sum up return_from_housing ##
moved_to_housing_data <-
  moved_to_housing_data %>%
  group_by(year) %>%
  summarise(moved_to_housing = sum(moved_to_housing))
### Graph moved to housing for families ###
ggplot(data=moved_to_housing_data, aes(x = year, y = moved_to_housing, fill = year)) +
  geom_bar(stat = "identity") +
  ggtitle("Families Moved to Housing Between 2018 and 2022") +
  theme_minimal() +
  labs(
    x = "Year",
    y = "Moved to Housing"
  )+
  theme(legend.position = "none") +
  scale_fill_brewer(palette = "set3")
## Save cleaned data ##
write_csv(
  x = moved_to_housing_data,
  file = "moved_to_housing_data.csv"
)



### NOTES ###
# look at unique values in "group"
cleaned_shelter_system_data$group |>
  unique()
# another method --- count
cleaned_shelter_system_data <-
  count(cleaned_shelter_system_data, year)
### Graph yes ###
ggplot(data=cleaned_shelter_system_data, aes(x = year, y = returned_from_housing, fill = year)) +
  geom_bar(stat = "identity") +
  ggtitle("Families Returning From Housing Between 2018 and 2022") +
  theme_minimal() +
  labs(
    x = "Year",
    y = "Returned from Housing"
  ) +
  theme(legend.position = "none") +
  scale_fill_brewer(palette = "set3")



# #| echo: false
# #| warning: false
# #| fig-cap: "Total homeless youths that moved to permanent housing in Toronto by year (2018 to 2022)."
# #| label: fig-4
# 
# #### MOVED TO HOUSING ####
# ### LINE Graph moved to housing for youth ###
# ggplot(data=moved_to_housing_data, aes(x = year, y = moved_to_housing, fill = year)) +
#   geom_line(aes(group=1)) +
#   ggtitle("Homeless Youths that Moved to Housing \n Between 2018 and 2022") +
#   theme_minimal() +
#   labs(
#     x = "Year",
#     y = "Number of Youths"
#   )+
#   theme(legend.position = "none")



# #| echo: false
# #| warning: false
# #| fig-cap: "Total number of person(s) in various population groups experiencing homelessness that moved to permanent housing in Toronto by year (2018 to 2022)."
# #| label: fig-2
# 
# #### ALL MOVED TO HOUSING ###
# ### Overall Data for moved_to_housing ###
# all_moved_to_housing_data |>
#   ggplot(mapping = aes(x = year, y = moved_to_housing, fill = group, label = moved_to_housing)) +
#   geom_bar(stat = "identity") +
#   geom_text(size = 2, position = position_stack(vjust = 0.5)) +
#   labs(
#     title = "Population Groups that Moved to Housing \n Between 2018 and 2022",
#     x = "Year",
#     y = "Number of Person(s)",
#     fill = "Population Groups"
#   ) +
#   scale_y_continuous(breaks=seq(0, 30000, 5000)) +
#   theme_light()
