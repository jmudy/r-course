
library(ggplot2) # Instalar con install.packages('ggplot2')

# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema7")

# Cargar dataset
geiser <- read.csv('../../data/tema7/geiser.csv')
head(geiser)

plot <- ggplot(geiser, aes(x = waiting)) +
  geom_histogram(binwidth = 5,
                 fill = 'white', colour = 'black')
  
ggplot(geiser, aes(x = waiting, y = ..density..)) +
  geom_histogram(fill = 'cornsilk', colour = 'grey60', size = .2) +
  geom_density() +
  xlim(35, 105)

ggplot(geiser, aes(x = eruptions, y = ..density..)) +
  geom_histogram(fill = 'cornsilk', colour = 'grey60', size = .2) +
  geom_density() +
  xlim(0, 7)
