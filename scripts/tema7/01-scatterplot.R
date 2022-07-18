
library(ggplot2) # Instalar con install.packages('ggplot2')

# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema7")

# Cargar dataset
auto <- read.csv('../../data/tema7/auto-mpg.csv', stringsAsFactors = FALSE)
auto$cylinders <- factor(auto$cylinders,
                         labels = c('3C', '4C', '5C', '6C', '8C'))

head(auto)

plot <- ggplot(auto, aes(x = weight, y = mpg))
plot + geom_point()
plot + geom_point(alpha = 1/2, size = 5,
                  aes(color = factor(cylinders))) +
  geom_smooth(method = 'lm', se = TRUE, col = 'green') +
  facet_grid(cylinders ~ .) +
  theme_bw(base_family = 'Arial', base_size = 10) +
  labs(x = 'Peso', y = 'Millas por Galeón', title = 'Consumo vs Peso')

qplot(x = weight, y = mpg, data = auto,
      geom = c('point', 'smooth'), method = 'lm',
      formula = y ~ x, color = cylinders,
      main = 'Regresión de MPG sobre el Peso')
