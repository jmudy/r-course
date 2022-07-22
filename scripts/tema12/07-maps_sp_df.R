
# Conversiones entre DF, mapas y objetos espaciales

# Todos los objetos tienen la forma SpatialXXXXXXXXDataFrame

# maps ->  spatial polygons -> spatial polygons dataframe

# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema12")

# Cargar dataset
nj_data <- read.csv('../../data/tema12/nj-county-data.csv')
rownames(nj_data) <- nj_data$name
nj_data$name <- NULL
head(nj_data)

library(maps) # Instalar con install.packages('maps')
library(maptools) # Instalar con install.packages('maptools')

nj_map <- map('county', 'new jersey', fill = T, plot = F)
str(nj_map)

nj_county <- sapply(strsplit(nj_map$names, ','), function(x) x[2])

nj_sp <- map2SpatialPolygons(nj_map, IDs = nj_county,
                             proj4string = CRS('+proj=longlat +ellps=WGS84'))

class(nj_sp)

nj_spdf <- SpatialPolygonsDataFrame(nj_sp, nj_data)
class(nj_spdf)

plot(nj_spdf)
spplot(nj_spdf, 'per_capita_income',
       main = 'Renta per Cápita')
spplot(nj_spdf, 'population',
       main = 'Población')
spplot(nj_spdf, 'median_family_income',
       main = 'Ingresos promedio familiares')
spplot(nj_spdf, c('per_capita_income', 'median_family_income'),
       main = 'Ingresos') # Dos plots a la vez
