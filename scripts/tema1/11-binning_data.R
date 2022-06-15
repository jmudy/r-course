
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema1")

# Cargar dataset
students <- read.csv('../../data/tema1/data-conversion.csv')

bp <- c(-Inf, 10000, 31000, Inf)
names <- c('Low', 'Average', 'High')

students$Income_cat <- cut(students$Income, breaks = bp, labels = names)

# Sin etiquetas solo se indica en el intervalo donde se encuentra el valor
students$Income_cat2 <- cut(students$Income, breaks = bp)

# Con breaks = un número, R decide los rangos de los cortes
students$Income_cat3 <- cut(students$Income,
                            breaks = 4,
                            labels = c('Level 1', 'Level 2',
                                       'Level 3', 'Level 4'))

# Variables ficticias (Dummy variables)
students <- read.csv('../../data/tema1/data-conversion.csv')

# Esta librería ya no está disponible instalar descargando
# https://cran.r-project.org/src/contrib/Archive/dummies/dummies_1.5.6.tar.gz
library(dummies)

students_dummy <- dummy.data.frame(students, sep = '_')
names(students_dummy)

dummy(students$State, sep = '_') # Para crear variables dummy de una sola variable categórica
dummy.data.frame(students, names = c('State', 'Gender'), sep = '_') # Para crear variables dummy de State y Gender
dummy.data.frame(students, names = c('Gender'), sep = '_') # Para crear variables dummy de solo Gender
