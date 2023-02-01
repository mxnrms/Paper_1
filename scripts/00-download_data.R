# download data

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
raw_shelter_system_data <- filter(datastore_resources, row_number()==1) %>% get_resource()
raw_shelter_system_data

### Save raw data ###
write_csv(
  x = raw_shelter_system_data,
  file = "raw_shelter_system_data.csv"
)