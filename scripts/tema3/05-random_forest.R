
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema3")

library(randomForest) # Instalar con install.packages('rpart.plot')
library(caret) # Instalar con install.packages('caret')

# Cargar dataset
banknote <- read.csv('../../data/tema3/banknote-authentication.csv')
banknote$class <- factor(banknote$class) # Convertir a factor

set.seed(2018)
training_ids <- createDataPartition(banknote$class, p = 0.7, list = FALSE)

mod <- randomForest(x = banknote[training_ids, 1:4],
                    y = banknote[training_ids, 5],
                    ntree = 500,
                    keep.forest = TRUE)

pred <- predict(mod, banknote[-training_ids, ], type = 'class')

table(banknote[-training_ids, 'class'], pred, dnn = c('Acual', 'Predicho'))


probs <- predict(mod, banknote[-training_ids, ], type = 'prob')
library(ROCR)
pred <- prediction(probs[, 2], banknote[-training_ids, 'class'])
perf <- performance(pred, 'tpr', 'fpr')
plot(perf) # Diagrama ROC
