
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema3")

library(caret) # Instalar con install.packages('caret')

# Cargar dataset
bh <- read.csv('../../data/tema3/boston-housing-logistic.csv')
bh$CLASS <- factor(bh$CLASS, levels = c(0, 1))

set.seed(2018)
training_ids <- createDataPartition(bh$CLASS, p = 0.7, list = FALSE)

mod <- glm(CLASS ~ ., data = bh[training_ids, ], family = 'binomial')
summary(mod)

bh[-training_ids, 'PROB_SUCCESS'] <- predict(mod, newdata = bh[-training_ids, ], type = 'response')

# Crear columna en funcion del valor de la columna PROB_SUCCESS
bh[-training_ids, 'PRED_50'] <- ifelse(bh[-training_ids, 'PROB_SUCCESS'] > 0.5, 1, 0)

table(bh[-training_ids, 'CLASS'], bh[-training_ids, 'PRED_50'], dnn = c('Actual', 'Predicho'))
