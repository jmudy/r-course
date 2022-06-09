
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema2")

# Cargar dataset
data <- read.csv('../../data/tema2/auto-mpg.csv',
                 header = TRUE,
                 stringsAsFactors = FALSE)

data$cylinders <- factor(data$cylinders,
                         levels = c(3,4,5,6,8),
                         labels = c('3cil', '4cil', '5cil', '6cil', '8cil'))

summary(data)
str(data) # Nos devuelve la estructura del dataframe, el tipo de objeto que contiene

summary(data$cylinders) # Resumen variable categórica
summary(data$mpg)
str(data$cylinders)

#install.packages(c('modeest', 'raster', 'moments'))
library(modeest) # Moda
library(raster) # Cuantiles, cv
library(moments) # Asimetria, curtosis

X = data$mpg

#### Medidas de centralizacion
mean(X) # Media
median(X) # Mediana
mfv(X) # Moda
quantile(X) # Cuantiles

#### Medidas de Dispersion
var(X) # Varianza
sd(X) # Desviacion tipica
cv(X) # Coeficiente de variacion (sd(X)/mean(X))*100

#### MEdidas de asimetria
skewness(X)
moments::kurtosis(X)

hist(X)
