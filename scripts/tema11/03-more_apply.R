
# lapply -> l = lista, se puede aplicar a vectores, list, dataframe

# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema11")

# Cargar dataset
auto <- read.csv('../../data/tema11/auto-mpg.csv', stringsAsFactors = F)
head(auto)

x <- c(1, 2, 3)
x
lapply(x, sqrt)

x <- list(a = 1:10, b = c(1, 10, 100, 1000), c = seq(5, 50, by = 50))
x
lapply(x, mean)
class(lapply(x, mean))

sapply(x, mean)
class(sapply(x, mean))

lapply(auto[, 2:8], min)
sapply(auto[, 2:8], min)

lapply(auto[, 2:8], summary)
sapply(auto[, 2:8], summary)

sapply(auto[, 2:8], range)

sapply(auto[, 2:8], min)
sapply(auto[, 2], min) # Esto falla por R trabaja con vector
# Habría que hacer lo siguiente
sapply(as.data.frame(auto[, 2]), min)
# Para que lo devuelva en forma de lista
sapply(as.data.frame(auto[, 2]), min, simplify = F)

# Función tapply
auto$cylinders <- factor(auto$cylinders,
                         levels = c(3, 4, 5, 6, 8),
                         labels = c('3C', '4C', '5C', '6C', '8C'))

tapply(auto$mpg, auto$cylinders, mean)
tapply(auto$mpg, list(cyl = auto$cylinders), mean)

# Correlación para cada cilindrada entre mpg y acceleration
by(auto, auto$cylinders,
function(row){cor(row$mpg, row$acceleration)})
