
# Añadir información a un objeto SP

# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema12")

# Cargar dataset
nj_df <- read.csv('../../data/tema12/nj-county-data.csv')
rownames(nj_df) <- nj_df$name
nj_df$name <- NULL

library(maps) # Instalar con install.packages('maps')
library(maptools) # Instalar con install.packages('maptools')

nj_map <- map('county', 'new jersey', fill = T, plot = F)
nj_county <- sapply(strsplit(nj_map$names, ','), function(x) x[2])
nj_sp <- map2SpatialPolygons(nj_map, IDs = nj_county,
                             proj4string = CRS('+proj=longlat +ellps=WGS84'))
nj_spdf <- SpatialPolygonsDataFrame(nj_sp, nj_df)

# Calculamos una nueva dimensión
pop_density <- nj_spdf@data$population/nj_spdf@data$area_sq_mi
pop_density
nj_spdf <- spCbind(nj_spdf, pop_density) # Añadir una nueva columna
names(nj_spdf@data)

spplot(nj_spdf, 'pop_density')







