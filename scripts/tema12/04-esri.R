
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema12")

library(rgdal) # Instalar con install.packages('rgdal')
library(sp) # Instalar con install.packages('sp')

countries_sp <- readOGR('../../data/tema12/natural_earth/', # dsn
                        'ne_50m_admin_0_countries')

airports_sp <- readOGR('../../data/tema12/natural_earth/', # dsn
                    'ne_50m_airports')

class(countries_sp)
class(airports)

plot(countries_sp)

plot(airports_sp, add = TRUE)

spplot(countries_sp, c('economy')) # Salta error
spplot(countries_sp, c('pop_est'))
spplot(countries_sp, c('gdp_md_est'))
spplot(countries_sp, c('mapcolor13'))
spplot(countries_sp, col = countries_sp@data$mapcolor13) # Tampoco funciona
