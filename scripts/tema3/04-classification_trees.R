
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema3")

# Cargar dataset
banknote <- read.csv('../../data/tema3/banknote-authentication.csv')

library(rpart) # Instalar con install.packages('rpart')
library(rpart.plot) # Instalar con install.packages('rpart.plot')
library(caret) # Instalar con install.packages('caret')

# Conjunto de entrenamiento
set.seed(123)
training_ids <- createDataPartition(banknote$class, p = 0.7, list = FALSE)

# class dependiente de todas las demas variables
# class ~ . <-> class ~ variance + skew + curtosis + entropy
mod <- rpart(class ~ .,
             data = banknote[training_ids, ],
             method = 'class',
             control = rpart.control(minsplit = 20, cp = 0.01))

mod

prp(mod, type = 2, extra = 104, nn = TRUE,
    fallen.leaves = TRUE, faclen = 4, varlen = 8,
    shadow.col = 'gray')

mod$cptable

# Comprobar con el error mínimo xerror en que punto se pasa xerror(min) + xstd
# 0.09638554 + 0.01578135 = 0.1121669
# ya se pasa porque está esperando un error de máximo 0.10843373
# por tanto podamos el árbol a partir de este punto

mod_pruned <- prune(mod, mod$cptable[6, 'CP'])

prp(mod_pruned, type = 2, extra = 104, nn = TRUE,
    fallen.leaves = TRUE, faclen = 4, varlen = 8,
    shadow.col = 'gray')

pred_pruned <- predict(mod, banknote[-training_ids, ],
                       type = 'class')

table(banknote[-training_ids, ]$class, pred_pruned, dnn = c('Actual', 'Predicho'))

# En el arbol podado
pred_pruned <- predict(mod_pruned, banknote[-training_ids, ],
                       type = 'class')

table(banknote[-training_ids, ]$class, pred_pruned, dnn = c('Actual', 'Predicho'))

pred_pruned2 <- predict(mod_pruned, banknote[-training_ids, ], type = 'prob') # Modelo probabilistico

head(pred_pruned)
head(pred_pruned2)

# Crear un diagrama ROC
library(ROCR)
pred <- prediction(pred_pruned2[, 2], banknote[-training_ids, 'class'])
perf <- performance(pred, 'tpr', 'fpr')
plot(perf)
