
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema6")

# Cargar datasets
AMZN <- read.csv('../../data/tema6/AMZN.csv', stringsAsFactors = FALSE)
AAPL <- read.csv('../../data/tema6/AAPL.csv', stringsAsFactors = FALSE)
FB <- read.csv('../../data/tema6/FB.csv', stringsAsFactors = FALSE)
GOOG <- read.csv('../../data/tema6/GOOG.csv', stringsAsFactors = FALSE)

AMZN = AMZN[AMZN$Date >='2008-01-01', ] # Eliminar fechas inferiores a 2008-01-01
AAPL = AAPL[AAPL$Date >='2008-01-01', ]

str(AAPL)

# Hacemos el casting a fechas de las mismas
AAPL$Date <- as.Date(AAPL$Date)
AMZN$Date <- as.Date(AMZN$Date) 
FB$Date <- as.Date(FB$Date) 
GOOG$Date <- as.Date(GOOG$Date) 

library(ggplot2) # Instalar con install.packages('ggplot2')

ggplot(AAPL, aes(Date, Close)) +
  geom_line(aes(color = 'Apple')) +
  geom_line(data = AMZN, aes(color = 'Amazon')) +
  geom_line(data = FB, aes(color = 'Facebook')) +
  geom_line(data = GOOG, aes(color = 'Google')) +
  labs(color = 'Legend') +
  scale_color_manual('', breaks = c('Apple', 'Amazon', 'Facebook', 'Google'),
                     values = c('gray', 'yellow', 'blue', 'red')) +
  ggtitle('Comparaciones de cierre de stocks') +
  theme(plot.title = element_text(lineheight = 0.7, face = 'bold'))

# Cargar datos en tiempo real
library(quantmod) # Instalar con install.packages('quantmod')

getSymbols('AAPL')
barChart(AAPL)
chartSeries(AAPL, TA = 'NULL')
chartSeries(AAPL[, 4], TA = 'addMACD()') # Dibujar también las diferencias del promedio

getSymbols('NFLX')
barChart(NFLX)
chartSeries(NFLX, TA = 'NULL')
chartSeries(NFLX[, 4], TA = 'addMACD()') # Dibujar también las diferencias del promedio
