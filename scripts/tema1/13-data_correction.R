
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema1")

# Cargar dataset
crime_data <- read.csv('../../data/tema1/USArrests.csv', stringsAsFactors = FALSE)
View(crime_data)

crime_data <-cbind(state = rownames(crime_data), crime_data) # Para añadir una o mas columnas

library(tidyr) # Instalar en install.packages('tidyr')
crime_data_1 <- gather(crime_data,
                       key = 'crime_type',
                       value = 'arrest_estimate',
                       Murder : UrbanPop)

crime_data_2 <- gather(crime_data,
                       key = 'crime_type',
                       value = 'arrest_estimate',
                       -state) # Concentrar todas las variables excepto la variable state

crime_data_3 <- gather(crime_data,
                       key = 'crime_type',
                       value = 'arrest_estimate',
                       Murder, Assault)

# Operación inversa de gather()
crime_data_4 <- spread(crime_data_2,
                       key = 'crime_type',
                       value = 'arrest_estimate')

# Para concatenar columnas
crime_data_5 <- unite(crime_data,
                      col = 'Murder_Assault',
                      Murder, Assault,
                      sep = '_')

# Operación inversa de unite()
crime_data_6 <- separate(crime_data_5,
                         col = 'Murder_Assault',
                         into = c('Murder', 'Assault'),
                         sep = '_')
