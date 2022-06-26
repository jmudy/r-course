
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema3")

library(nnet) # Instalar con install.packages('nnet')
library(caret) # Instalar con install.packages('caret')

# Cargar dataset
bn <- read.csv('../../data/tema3/banknote-authentication.csv')
bn$class <- factor(bn$class)

training_ids <- createDataPartition(bn$class, p = 0.7, list = FALSE)
mod <- nnet(class ~ ., data = bn[training_ids, ],
            size = 3, maxit = 10000, decay = .001, rang = 0.05,
            na.action = na.omit, skip = TRUE)

#rang * max(|variables|) ~ 1
apply(bn, 2, max)

pred <- predict(mod, newdata = bn[-training_ids, ], type = 'class')
table(bn[-training_ids, ]$class, pred, dnn = c('Actual', 'Predichos'))

library(ROCR)
pred2 <- predict(mod, newdata = bn[-training_ids,], type = 'raw')
perf <- performance(prediction(pred2, bn[-training_ids, 'class']),
                    'tpr', 'fpr')

plot(perf)
