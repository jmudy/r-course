
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema3")

library(class) # Instalar con install.packages('class')
library(caret) # Instalar con install.packages('caret')

# Cargar dataset
vac <- read.csv('../../data/tema3/vacation-trip-classification.csv')
vac$Income_z <- scale(vac$Income)
vac$Family_size_z <- scale(vac$Family_size)

set.seed(2018)

training_ids <- createDataPartition(vac$Result, p = 0.5, list = FALSE)
train <- vac[training_ids, ]
temp <- vac[-training_ids, ]
v_ids <- createDataPartition(temp$Result, p = 0.5, list = FALSE)
val <- temp[v_ids, ]
test <- temp[-v_ids, ]

pred1 <- knn(train[, 4:5], val[, 4:5], train[, 3], k = 3)
errmat1 <- table(val$Result, pred1, dnn = c('Actual', 'Predichos'))
errmat1

pred2 <- knn(train[, 4:5], test[, 4:5], train[, 3], k = 3)
errmat2 <- table(test$Result, pred2, dnn = c('Actual', 'Predichos'))
errmat2

knn_automate <- function(tr_predictors, val_predictors, tr_target,
                         val_target, start_k, end_k){
  for (k in start_k:end_k){
    pred <- knn(tr_predictors, val_predictors, tr_target, k)
    tab <- table(val_target, pred, dnn = c('Actual', 'Predichos'))
    cat(paste('Matriz de confusión para k = ', k, '\n'))
    cat('===================\n')
    print(tab)
    cat('-------------------\n')
  }
}

knn_automate(train[, 4:5], val[, 4:5], train[, 3], val[, 3], 1, 8)

trcntrl <- trainControl(method = 'repeatedcv', number = 10, repeats = 3)
caret_knn_fit <- train(Result ~ Family_size + Income, data = train,
                       method = 'knn', trControl = trcntrl,
                       preProcess = c('center', 'scale'),
                       tuneLength = 10)

caret_knn_fit

pred5 <- knn(train[, 4:5], val[, 4:5], train[, 3], k = 5, prob = TRUE)
pred5
