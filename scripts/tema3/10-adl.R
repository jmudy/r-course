
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema3")

library(MASS) # Instalar con install.packages('MASS')
library(caret) # Instalar con install.packages('caret')

# Cargar dataset
bn <- read.csv('../../data/tema3/banknote-authentication.csv')
bn$class <- factor(bn$class)

set.seed(2018)
training_ids <- createDataPartition(bn$class, p = 0.7, list = FALSE)

mod <- lda(bn[training_ids, 1:4], bn[training_ids, 5])
# Otra forma
# mod <- lda(class ~ ., data = bn[training_ids, ])

# Matriz de confusion con el conjunto de entrenamiento
bn[training_ids, 'Pred'] <- predict(mod, bn[training_ids, 1:4])$class
table(bn[training_ids, 'class'], bn[training_ids, 'Pred'], dnn = c('Actual', 'Predicho'))

# Matriz de confusion con el conjunto de testing
bn[-training_ids, 'Pred'] <- predict(mod, bn[-training_ids, 1:4])$class
table(bn[-training_ids, 'class'], bn[-training_ids, 'Pred'], dnn = c('Actual', 'Predicho'))
