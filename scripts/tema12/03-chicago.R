
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema12")

# Cargar dataset
crimes <- read.csv('../../data/tema12/chicago-crime.csv')
head(crimes)

library(ggmap) # Instalar con install.packages('ggmap')
library(maps) # Instalar con install.packages('maps')

crimes$Date <- strptime(crimes$Date, format = '%m/%d/%y %H:%M')
head(crimes)

chicago <- get_map(location = 'chicago', zoom = 11)
ggmap(chicago) +
  geom_point(data = crimes[1:500, ], aes(x = Longitude, y = Latitude))

# Dividir el mapa en regiones para ver la frecuencia de crímenes en cada uno de
# ellos para construir después un mapa de calor
counts <- as.data.frame(table(round(crimes$Longitude, 2),
                              round(crimes$Latitude, 2)
                              )
                        )
head(counts)

# Convertir a numérico las columnas Var1 y Var2
counts$Lon <- as.numeric(as.character(counts$Var1))
counts$Lat <- as.numeric(as.character(counts$Var2))
counts$Var1 <- NULL
counts$Var2 <- NULL
head(counts)

summary(counts)

ggmap(chicago) +
  geom_tile(data = counts, aes(x = Lon, y = Lat, alpha = Freq),
            fill = 'red')
