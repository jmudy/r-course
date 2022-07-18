
# Modelo autorregresivo integrado de media móvil

# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema6")

# Cargar dataset
inf <- read.csv('../../data/tema6/infy-monthly.csv')

inf_ts <- ts(inf$Adj.Close, start = c(1999, 3), frequency = 12)

inf_arima <- auto.arima(inf_ts)
summary(inf_arima)

inf_fore <- forecast(inf_arima, h = 12)
plot(inf_fore, col = 'red',
     fcol = 'green')
