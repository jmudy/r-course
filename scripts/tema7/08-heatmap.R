
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema7")

# Cargar dataset
tartu_data <- read.csv('../../data/tema7/tartu_housing.csv',
                       sep = ';')

library(ggmap) # Instalar con install.packages('ggmap')
library(maps) # Instalar con install.packages('maps')

# Just go to https://cloud.google.com/maps-platform/maps/ and complete the registration
# (credit card requiered), you would get an API key and then you can register that key
# on ggmap using register_google() function.

# register_google(key=API_KEY)

tartu_map <- get_map(location = 'tartu', maptype = 'satellite', zoom = 12)
ggmap(tartu_map, extent = 'device') +
  geom_point(data = tartu_data,
             aes(x = lon, y = lat),
             colour = 'red', alpha = 0.12, size = 2)

tartu_map2 <- get_map(location = 'tartu', zoom = 13)
ggmap(tartu_map2, extent = 'device') +
  geom_density2d(data = tartu_data, aes(x = lon, y = lat),
                 size = 0.3) +
  stat_density2d(data = tartu_data, aes(x = lon, y = lat,
                                        fill = ..level..,
                                        alpha = ..level..),
                 size = 0.01, bins = 16, geom = 'polygon') +
  scale_fill_gradient(low = 'green', high = 'red') +
  scale_alpha(range = c(0, 0.25), guide = 'none')
