
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema6")

# Cargar dataset
wmt <- read.csv('../../data/tema6/WMT.csv', stringsAsFactors = FALSE)

plot(wmt$Adj.Close, type = 'l')

d <- diff(wmt$Adj.Close) # Diferencias de un día al siguiente
head(d)

plot(d, type = 'l')

hist(d, prob = TRUE, ylim = c(0, 0.8), breaks = 30, main ='Walmart Stocks', col = 'green')
lines(density(d), lwd = 3)

wmt_m <- read.csv('../../data/tema6/WMT-monthly.csv', stringsAsFactors = FALSE)
wmt_m_ts <- ts(wmt_m$Adj.Close)
d <- diff(as.numeric(wmt_m_ts))
d
wmt_m_return <- d/lag(as.numeric(wmt_m_ts), k = -1)
hist(wmt_m_return, prob = TRUE, col = 'blue')
