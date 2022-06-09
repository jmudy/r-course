
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema2")

# Cargar dataset
auto <- read.csv('../../data/tema2/auto-mpg.csv')

auto$cylinders <- factor(auto$cylinders,
                         levels = c(3, 4, 5, 6, 8),
                         labels = c('3cil', '4cil', '5cil', '6cil', '8cil'))

attach(auto) # Para ahorrarnos usar tanto el $ en esta sesion de R

head(cylinders)

hist(acceleration,
     col = rainbow(12),
     xlab = 'Aceleracion',
     ylab = 'Frecuencias',
     main = 'Histograma de las aceleraciones',
     breaks = 12)

hist(mpg, breaks = 16, prob = T)
lines(density(mpg))

# Boxplots
boxplot(mpg,
        ylab = 'Millas por Galeon')

boxplot(mpg ~ model_year,
        ylab = 'Millas por Galeon (por año)',
        xlab = 'Año')

boxplot(mpg ~ cylinders,
        ylab = 'Consumo por Numero de cilindros')

# Scatterplot
# type = 'n' para que lo dibuje todo blanco y a partir
# de ahi empiezo yo a añadir elementos
plot(mpg ~ horsepower, type = 'n')
linearmodel <- lm(mpg ~ horsepower)
abline(linearmodel)

# Agregar colores para cada cilindrada
with(subset(auto, cylinders == '8cil'),
     points(horsepower, mpg, col = 'red'))
with(subset(auto, cylinders == '6cil'),
     points(horsepower, mpg, col = 'orange'))
with(subset(auto, cylinders == '5cil'),
     points(horsepower, mpg, col = 'green'))
with(subset(auto, cylinders == '4cil'),
     points(horsepower, mpg, col = 'blue'))
with(subset(auto, cylinders == '3cil'),
     points(horsepower, mpg, col = 'purple'))

# Matriz de Scatterplots
pairs(~ mpg + displacement + horsepower + weight)

# Combinacion de plots con par
old_par <- par()

par(mfrow = c(1, 2)) # una fila 2 columnas de dibujo

with(auto, {
  plot(mpg ~ weight, main = 'Peso vs Consumo')
  plot(mpg ~ acceleration, main = 'Aceleracion vs Consumo')
})

par(old_par)
