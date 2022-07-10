
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema6")

# Cargar dataset
inf <- read.csv('../../data/tema6/infy-monthly.csv')

head(inf)
tail(inf)

inf_ts <- ts(inf$Adj.Close, start = c(1999, 3), frequency = 12)
inf_ts
plot(inf_ts)

inf_hw <- HoltWinters(inf_ts)
head(inf_hw)
plot(inf_hw, col = 'blue', col.predicted = 'red')

inf_hw$SSE
inf_hw$alpha
inf_hw$beta
inf_hw$gamma

head(inf_hw$fitted)

library(forecast) # Instalar con install.packages('forecast')

infy_fore <- forecast(inf_hw, h = 24)
plot(infy_fore)
