
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema4")

# Cargar dataset
bh <- read.csv('../../data/tema4/BostonHousing.csv')

library(rpart) # Instalar con install.packages('rpart')
library(rpart.plot) # Instalar con install.packages('rpart.plot')
library(caret) # Instalar con install.packages('caret')

set.seed(2018)

t_id <- createDataPartition(bh$MEDV, p = 0.7, list = FALSE)

bfit <- rpart(MEDV ~ ., data = bh[t_id, ])
bfit

prp(bfit, type = 2, nn = TRUE,
    fallen.leaves = TRUE, faclen = 4,
    varlen = 8, shadow.col = 'gray')

bfit$cptable

0.1639482 + 0.2731917
# 0.4371399

# El tamaño del árbol que más se acerca a este error es el de tamaño 3 (xerror = 0.4190907)

plotcp(bfit) # Aquí también se puede ver como optimizar el tamaño del árbol

bfitpruned <- prune(bfit, cp = 0.07872616)

prp(bfitpruned, type = 2, nn = TRUE,
    fallen.leaves = TRUE, faclen = 4,
    varlen = 8, shadow.col = 'gray')

## Con el árbol original
# Con el conjunto de entrenamiento
pred <- predict(bfit, bh[t_id, ])
sqrt(mean((pred - bh[t_id, ]$MEDV)^2))

# Con el conjunto de test
pred <- predict(bfit, bh[-t_id, ])
sqrt(mean((pred - bh[-t_id, ]$MEDV)^2))

# Con el conjunto de entrenamiento
pred <- predict(bfitpruned, bh[t_id, ])
sqrt(mean((pred - bh[t_id, ]$MEDV)^2))

## Con el árbol podado
# Con el conjunto de test
pred <- predict(bfitpruned, bh[-t_id, ])
sqrt(mean((pred - bh[-t_id, ]$MEDV)^2))

# No hay tanta diferencia de error al disminuir el número de hojas


# PREDICTORES CATEGORICOS

# Cargar dataset
ed <- read.csv('../../data/tema4/education.csv')
ed$region <- factor(ed$region)

t_id <- createDataPartition(ed$expense, p = 0.7, list = FALSE)
fit <- rpart(expense ~ region + urban + income + under18, data = ed[t_id, ])
prp(fit, type = 2, nn = TRUE,
    fallen.leaves = TRUE, faclen = 4,
    varlen = 8, shadow.col = 'gray')

# Técnica de bagging o Bootstrap aggregation
library(ipred) # Instalar con install.packages('ipred')

bagging_fit <- bagging(MEDV ~ ., data = bh[t_id, ])
prediction_t <- predict(bagging_fit, bh[t_id, ])
sqrt(mean((prediction_t - bh[t_id, ]$MEDV)^2))

prediction_v <- predict(bagging_fit, bh[-t_id, ])
sqrt(mean((prediction_v - bh[-t_id, ]$MEDV)^2))

# Técnica de Boosting
library(gbm) # Instalar con install.packages('gbm')

gbmfit <- gbm(MEDV ~ ., data = bh, distribution = 'gaussian')
# Como data le pasamos todo el dataset porque si no salta error de que el
# dataset es demasiado pequeño
prediction_t <- predict(gbmfit, bh)
