# acquire

library(tidyverse)
library(opendatatoronto)

####### RETURNED FROM HOUSING ####### 
### BAR Graph return from housing for youth ###
ggplot(data=returned_from_housing_data, 
       aes(x = year, y = returned_from_housing, fill = year)) +
  geom_bar(stat = "identity") +
  ggtitle("Youth Returned From Permanent Housing Between 2018 and 2022") +
  theme_minimal() +
  labs(
    x = "Year",
    y = "Returned from Housing"
  )+
  theme(legend.position = "none") +
  scale_fill_brewer(palette = "set3")
### LINE Graph return from housing for youth ###
ggplot(data=returned_from_housing_data, 
       aes(x = year, y = returned_from_housing, fill = year)) +
  geom_line(aes(group=1)) +
  ggtitle("Youth Returned From Permanent Housing Between 2018 and 2022") +
  theme_minimal() +
  labs(
    x = "Year",
    y = "Returned from Housing"
  )+
  theme(legend.position = "none")
### Overall Data for returned_from_housing ###
#| echo: false
#| fig-cap: "Total Bike Thefts in Toronto By Year (2014-2021)"
#| label: fig-1
all_returned_from_housing_data |>
  ggplot(mapping = aes(x = year, y = returned_from_housing, fill = group, label = returned_from_housing)) +
  geom_bar(stat = "identity") + 
  geom_text(size = 3, position = position_stack(vjust = 0.5)) +
  labs(
    title = "People Experiencing Homelessness Returned From Housing",
    x = "Year",
    y = "Number of People", 
    fill = "Groups"
  ) + 
  theme_light()



####### MOVED TO HOUSING ####### 
### BAR Graph moved to housing for youth ###
ggplot(data=moved_to_housing_data, aes(x = year, y = moved_to_housing, fill = year)) +
  geom_bar(stat = "identity") +
  ggtitle("Youth Moved to Permanent Housing Between 2018 and 2022") +
  theme_minimal() +
  labs(
    x = "Year",
    y = "Moved to Housing"
  )+
  theme(legend.position = "none") +
  scale_fill_brewer(palette = "set3")
### LINE Graph moved to housing for youth ###
ggplot(data=moved_to_housing_data, aes(x = year, y = moved_to_housing, fill = year)) +
  geom_line(aes(group=1)) +
  ggtitle("Youth Moved to Permanent Housing Between 2018 and 2022") +
  theme_minimal() +
  labs(
    x = "Year",
    y = "Moved to Housing"
  )+
  theme(legend.position = "none")
### Overall Data for moved_to_housing ###
#| echo: false
#| fig-cap: "Total Bike Thefts in Toronto By Year (2014-2021)"
#| label: fig-1
all_moved_to_housing_data |>
  ggplot(mapping = aes(x = year, y = moved_to_housing, fill = group, label = moved_to_housing)) +
  geom_bar(stat = "identity") + 
  geom_text(size = 3, position = position_stack(vjust = 0.5)) +
  labs(
    title = "People Experiencing Homelessness Moved to Housing",
    x = "Year",
    y = "Number of People", 
    fill = "Groups"
  ) + 
  theme_light()




####### TABLE ####### 
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
