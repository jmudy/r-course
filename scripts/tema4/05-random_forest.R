
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema4")

# Cargar dataset
bh <- read.csv('../../data/tema4/BostonHousing.csv')

library(randomForest) # Instalar con install.packages('randomForest')
library(caret) # Instalar con install.packages('caret')

set.seed(123)

t_id <- createDataPartition(bh$MEDV, p = 0.7, list = FALSE)
mod <- randomForest(x = bh[t_id, 1:13], y = bh[t_id, 14],
                    ntree = 1000,
                    xtest = bh[-t_id, 1:13], ytest = bh[-t_id, 14],
                    importance = TRUE, keep.forest = TRUE)

mod

mod$importance

# Conjunto de entrenamiento
plot(bh[t_id, ]$MEDV, predict(mod, newdata = bh[t_id, ]),
     xlab = 'Actual', ylab = 'Predichos')
abline(0, 1)

# Conjunto de validación
plot(bh[-t_id, ]$MEDV, predict(mod, newdata = bh[-t_id, ]),
     xlab = 'Actual', ylab = 'Predichos')
abline(0, 1)

# Variables importantes a tener en cuenta
# mtry = m/3, donde m = número de predictores
# nodesize = 5,
# maxnodes
