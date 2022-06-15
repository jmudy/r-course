
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema1")

# Cargar dataset
housing_data <- read.csv('../../data/tema1/housing-with-missing-value.csv',
                         header = TRUE, stringsAsFactors = FALSE)

# Formas de eliminar la información que falta
summary(housing_data)

# Eliminar todas las observaciones que contengan algun NA puede provocar
# grandes variaciones en el modelo de datos
housing_data_1 <- na.omit(housing_data)
summary(housing_data_1)

# Eliminar las NA de ciertas columnas
drop_na <- c('rad') # Columnas que quiero mantener los NA
housing_data_2 <- housing_data[
  complete.cases(housing_data[, !(names(housing_data)) %in% drop_na]), ]
summary(housing_data_2)

# Eliminar toda una columna
housing_data$rad <- NULL
summary(housing_data)

# Eliminar varias columnas
drops <- c('rad', 'ptratio')
housing_data_3 <- housing_data[, !(names(housing_data) %in% drops)]
summary(housing_data_3)

# Sustituir valores NA por valores como la media, mediana, moda, desv. típica...
library(Hmisc) # Instalar con install.packages('Hmisc')

# Sustituir por la media
housing_data_copy1 <- housing_data
housing_data_copy1$ptratio <- impute(housing_data_copy1$ptratio, mean)
housing_data_copy1$rad <- impute(housing_data_copy1$rad, mean)
summary(housing_data_copy1)

# Sustituir por la mediana
housing_data_copy2 <- housing_data
housing_data_copy2$ptratio <- impute(housing_data_copy2$ptratio, median)
housing_data_copy2$rad <- impute(housing_data_copy2$rad, median)
summary(housing_data_copy2)

# Sustituir por un número
housing_data_copy3 <- housing_data
housing_data_copy3$ptratio <- impute(housing_data_copy3$ptratio, 18)
housing_data_copy3$rad <- impute(housing_data_copy3$rad, 7)
summary(housing_data_copy3)

library(mice) # Instalar con install.packages('mice')
# Para ver que información de las variables no es conocida al completo
md.pattern(housing_data)

# Otra forma de ver la información de las variables mediante gráficos
library(VIM) # Instalar con install.packages('VIM')
aggr(housing_data,
     col = c('green', 'red'),
     numbers = TRUE,
     sortVars = TRUE,
     labels = names(housing_data),
     cex.axis = 0.75,
     gap = 2,
     ylab = c('Histograma de NAs', 'Patron'))
