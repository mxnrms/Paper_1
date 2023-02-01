# acquire

library(tidyverse)
library(opendatatoronto)

#### RETURNED FROM HOUSING ###
### Graph return from housing for families ###
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


#### MOVED TO HOUSING ####
### Graph moved to housing for families ###
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