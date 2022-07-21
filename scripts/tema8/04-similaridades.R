
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema8")

# Cargar dataset
mtcars <- read.csv('../../data/tema8/mtcars.csv')
mtcars$X <- NULL

library(lsa) # Instalar con install.packages('lsa')

## Distancia Euclidea

coche1 <- mtcars[1, ]
coche2 <- mtcars[2, ]

dist(coche1, coche2, method = 'euclidean')

x1 <- rnorm(100)
x2 <- rnorm(100)
dist(rbind(x1, x2), method = 'euclidean')

## Función del coseno
v1 <- c(1, 0, 1, 1, 0, 1, 1, 0, 0, 1)
v2 <- c(0, 1, 1, 1, 0, 0, 1, 0, 1, 0)
cosine(v1, v2)

## Correlación de Pearson
pear <- cor(mtcars, method = 'pearson')
pear








