
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema4")

# Cargar dataset
data <- read.csv('../../data/tema4/rmse.csv')

rmse <- sqrt(mean((data$price - data$pred)^2))
rmse

plot(data$price, data$pred,
     xlab = 'Actual', ylab = 'Predicho')

abline(0, 1)

# Función cálculo RMSE
rmse <- function(actual, predicted){
  return(sqrt(mean((actual-predicted)^2)))
}

rmse(data$price, data$pred)
