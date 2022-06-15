
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema1")

# Cargar dataset
ozone_data <- read.csv('../../data/tema1/ozone.csv', stringsAsFactors = FALSE)

boxplot(ozone_data$pressure_height,
        main = 'Pressure Height',
        boxwex = 0.1)

summary(ozone_data$pressure_height)

boxplot(pressure_height ~ Month,
        data = ozone_data,
        main = 'Pressure Height per Month')

boxplot(ozone_reading ~ Month,
        data = ozone_data,
        main = 'Ozone reading per Month')$out # $out para mostrar en consola los outliers

mtext('Hola') # Para escribir encima del boxplot

# Sustituir outliers por media y mediana
impute_outliers <- function(x, removeNA = TRUE){
  quantiles <- quantile(x, c(0.05, 0.95), na.rm = removeNA)
  x[x < quantiles[1]] <- mean(x, na.rm = removeNA)
  x[x > quantiles[2]] <- median(x, na.rm = removeNA)
  x
}

imputed_data <- impute_outliers(ozone_data$pressure_height)

# Comparativa con boxplots con/sin outliers
par(mfrow = c(1, 2))
boxplot(ozone_data$pressure_height, main = 'Presion con outliers')
boxplot(imputed_data, main = 'Presion sin outliers')

# Sustituir todo lo que está por debajo por el cuantil 5 y todo lo que está
# por arriba por el cuantil 95
replace_outliers <- function(x, removeNA = TRUE){
  qrts <- quantile(x, probs = c(0.25, 0.75), na.rm = removeNA)
  caps <- quantile(x, probs = c(0.05, 0.95), na.rm = removeNA)
  iqr <-qrts[2] - qrts[1] # Cálculo de rango intercuartílico
  h <- 1.5 * iqr
  x[x < qrts[1] - h]<- caps[1]
  x[x > qrts[2] + h]<- caps[2]
  x
}

capped_pressure_height <- replace_outliers(ozone_data$pressure_height)

par(mfrow = c(1, 2))
boxplot(ozone_data$pressure_height, main = 'Presion con outliers')
boxplot(capped_pressure_height, main = 'Presion sin outliers')
