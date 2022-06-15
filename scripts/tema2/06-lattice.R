
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema2")

# Cargar dataset
auto <- read.csv('../../data/tema2/auto-mpg.csv')

auto$cylinders <- factor(auto$cylinders,
                         levels = c(3, 4, 5, 6, 8),
                         labels = c('3C', '4C', '5C', '6C', '8C'))

library(lattice) # Instalar con install.packages('lattice')

## Diagramas: bwplot, xyplot, densityplot, splom

bwplot(~ auto$mpg | auto$cylinders, # Como auto$mpg está a la derecha de la ~ estamos indicando el eje X
       main = 'MPG segun cilindrada',
       xlab = 'Millas por Galeon',
       layout = c(2, 3), aspect = 1)

xyplot(mpg~weight | cylinders, data = auto, # Eje y -> mpg, Eje x -> weight
       main = 'Peso vs Consumo vs Cilindrada',
       xlab = 'Peso (kg)',
       ylab = 'Consumo (mpg)')

trellis.par.set(theme = col.whitebg()) # Para cambiar el tema de los gráficos
bwplot(~ auto$mpg | auto$cylinders,
       main = 'MPG segun cilindrada',
       xlab = 'Millas por Galeon',
       layout = c(2, 3), aspect = 1)
