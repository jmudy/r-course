
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema12")

library(RgoogleMaps) # Instalar con install.packages('RgoogleMaps')

lat <- 39.47558890400351
lon <- -0.37524358833622323

vlc_map <- GetMap(center = c(lat, lon), zoom = 16,
                  destfile = 'vlc.pdf', # Con pdf no funciona...
                  format = 'pdf',
                  maptype = 'terrain')
PlotOnStaticMap(vlc_map)

# satellite, roadmap, terrain
