
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema1")

# Cargar dataset
data <- read.csv('../../data/tema1/missing-data.csv', na.strings = '')

data_cleaned <- na.omit(data) # Eliminar filas donde hay datos faltantes

is.na(data[4, 2]) # Comprobar si el dato es NA o no
is.na(data[4, 1]) # Comprobar si el dato es NA o no
is.na(data$Income) # Comprobar si la columna Income es NA o no, duelve un vector de TRUE y FALSE

# Limpiar NA de solamente la variable Income
data_income_cleaned <- data[!is.na(data$Income), ] # Todas las filas excepto las que tienen NAs

# Filas completas para un dataframe
complete.cases(data)

# Otra forma de quedarme con las filas donde no hay ningún valor NA, similar a na.omit()
data_cleaned_2 <- data[complete.cases(data), ]

# Convertir los ceros de ingresos en NA
data$Income[data$Income == 0] <- NA

# Medidas de centralización y dispersión
mean(data$Income, na.rm = TRUE) # Eliminando los NA para que no de la media = NA
sd(data$Income, na.rm = TRUE) # Se hace lo mismo para la desviación típica
