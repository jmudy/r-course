
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema3")

library(e1071) # Instalar con install.packages('e1071')
library(caret) # Instalar con install.packages('caret')

# Cargar dataset
ep <- read.csv('../../data/tema3/electronics-purchase.csv')

set.seed(2018)
training_ids <- createDataPartition(ep$Purchase, p = 0.67, list = FALSE)
mod <- naiveBayes(Purchase ~ ., data = ep[training_ids, ])
mod

pred <- predict(mod, ep[-training_ids, ])
tab <- table(ep[-training_ids, ]$Purchase, pred, dnn = c('Actual', 'Predicha'))
confusionMatrix(tab)
