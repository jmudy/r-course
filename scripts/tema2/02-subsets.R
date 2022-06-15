
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema2")

# Cargar dataset
data <- read.csv('../../data/tema2/auto-mpg.csv',
                 header = TRUE,
                 stringsAsFactors = FALSE)

# Index by position
data[1:5, 8:9]
data[1:5, c(8, 9)] # Otra forma

# Index by name
data[1:5, c('model_year', 'car_name')]

# Operadores Logicos
# & : AND
# | : OR
# ! : NOT
# ==

# Min / Max de mpg
data[data$mpg == max(data$mpg) | data$mpg == min(data$mpg), ]

# Filtros con condiciones
data[data$mpg > 30 & data$cylinders == 6, c('car_name', 'mpg')]

# R es capaz de detectar el nombre de la variable si la acortamos
data[data$mpg > 30 & data$cyl == 6, c('car_name', 'mpg')]

# Subset
subset(data, mpg > 30 & cylinders == 6, select = c('car_name', 'mpg'))

# FALLOS A TENER EN CUENTA
data[data$mpg > 30] # Olvidarse de la coma después de la condición en filas

# Excluir columnas
data[1:5, c(-1, -9)] # Dame las filas 1 a 5 de todas las columnas menos a la 1 y 9
data[1:5, -c(1, 9)] # Otra forma (No válido para nombres)
data[1:5, !names(data) %in% c('No', 'car_name')]

data[data$mpg %in% c(15, 20), c('car_name', 'mpg')]

data[c(F, F, F, F, T), c(F, F, T)] # R "recicla" el vector de T/F que le das para la información a mostrar
