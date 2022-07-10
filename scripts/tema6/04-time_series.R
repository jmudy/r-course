
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema6")

# Cargar dataset
s <- read.csv('../../data/tema6/ts-example.csv')
head(s)

s_ts <- ts(s)
class(s_ts)

head(s_ts)
plot(s_ts)

s_ts_a <- ts(s, start = 2001)
s_ts_a
plot(s_ts_a)

s_ts_m <- ts(s, start = c(2001, 1), frequency = 12)
s_ts_m
plot(s_ts_m)

s_ts_q <- ts(s, start = 2001, frequency = 4)
s_ts_q
plot(s_ts_q)

start(s_ts_m)
end(s_ts_m)
frequency(s_ts_m)

start(s_ts_q)
end(s_ts_q)
frequency(s_ts_q)

prices <- read.csv('../../data/tema6/prices.csv')
head(prices)

prices_ts <- ts(prices, start = c(1980, 1), frequency = 12)
prices_ts
plot(prices_ts)

plot(prices_ts, plot.type = 'single', col = 1:2)
legend('topleft', colnames(prices_ts), col = 1:2, lty = 1)

# log(a*b) = log(a) + log(b)

# Descomposición de una Serie Temporal 

# stl
# Seasonal Decomposition of Time Series by Loess
flour_l <- log(prices_ts[, 1])
flour_stl <- stl(flour_l, s.window = 'period')
plot(flour_stl)
flour_stl

gas_l <- log(prices_ts[, 2])
gas_stl <- stl(gas_l, s.window = 'period')
plot(gas_stl)

# decompose
# Classical Seasonal Decomposition by Moving Averages
flour_dec <- decompose(flour_l)
plot(flour_dec)

gas_dec <- decompose(gas_l)
plot(gas_dec)

# Ajustar los valores iniciales eliminando información que la Serie Temporal
# determina que es estacional

flour_season_adjusted <- prices_ts[, 1] - (flour_dec$seasonal)
plot(flour_season_adjusted)

gas_season_adjusted <- prices_ts[, 2] - (gas_dec$seasonal)
plot(gas_season_adjusted)

# Filtrado de Series Temporales para Localizar Tendencias
# Para entender lo que se hace acontinuación consultar el script 05-moving_average.R

n <- 12
weights = rep(1/n, n)

gas_f_1 <- filter(prices_ts[, 2], filter = weights, sides = 2)
gas_f_2 <- filter(prices_ts[, 2], filter = weights, sides = 1)
plot(prices_ts[, 2])
lines(gas_f_1, col = 'blue', lwd = 3)
lines(gas_f_2, col = 'red', lwd = 3)
