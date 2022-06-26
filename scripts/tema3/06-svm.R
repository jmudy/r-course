
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema3")

# Cargar dataset
banknote <- read.csv('../../data/tema3/banknote-authentication.csv')

library(e1071) # Instalar con install.packages('e1071')
library(caret) # Instalar con install.packages('caret')

banknote$class = factor(banknote$class)
set.seed(2018)
training_ids <- createDataPartition(banknote$class, p = 0.7, list = FALSE)
mod <- svm(class ~ ., data = banknote[training_ids, ],
           class.weights = c('0' = 0.7,
                             '1' = 0.3))

# Matriz de confusion
table(banknote[training_ids, 'class'], fitted(mod), dnn = c('Acual', 'Predicho'))
pred <- predict(mod, banknote[-training_ids, ])

# Con el conjunto de test
table(banknote[-training_ids, 'class'], pred, dnn = c('Acual', 'Predicho'))

# Representación gráfica
plot(mod, data = banknote[training_ids, ], skew ~ variance)

# Con el conjunto de test
plot(mod, data = banknote[-training_ids, ], skew ~ variance)

# Como ver los mejores parámetros para el modelo SVM
tuned <- tune.svm(class ~ ., data = banknote[training_ids, ],
                  gamma = 10^(-6:-1),
                  cost = 10^(1:2))

summary(tuned)
