
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema2")

library(caret) # Instalar con install.packages('caret')

# Partición de Data Frames con Variables Numericas

# Cargar dataset
data <- read.csv('../../data/tema2/BostonHousing.csv')

training_ids <- createDataPartition(data$MEDV, p = 0.8, list = F)
data_training <- data[training_ids, ]
data_validation <- data[-training_ids, ]

# En el caso de que queramos tener conjunto de training, validation y test
# Dividimos equitativamente el 30% (en este caso) entre validation y test

training_ids_2 <- createDataPartition(data$MEDV, p = 0.7, list = F)
data_training_2 <- data[training_ids_2, ]

temp <- data[-training_ids_2, ]
validation_ids_2 <- createDataPartition(temp$MEDV, p = 0.5, list = F)
data_validation_2 <- temp[validation_ids_2, ]
data_testing_2 <- temp[-validation_ids_2, ]

# Partición de Data Frames con Variables Categóricas

# Cargar dataset
data2 <- read.csv('../../data/tema2/boston-housing-classification.csv')
training_ids_3 <- createDataPartition(data2$MEDV_CAT, p = 0.7, list = F)
data_training_3 <- data2[training_ids_3, ]
data_validation_3 <- data2[-training_ids_3, ]

# Crear 2 funciones que lo haga automáticamente

rda_cb_partition2 <- function(dataframe, target_index, prob){
  library(caret)
  training_ids <- createDataPartition(dataframe[, target_index], p = prob, list = F)
  list(train = dataframe[training_ids, ], val = dataframe[-training_ids, ])
}

rda_cb_partition3 <- function(dataframe, target_index,
                              prob_train, prob_val){
  library(caret)
  training_ids <- createDataPartition(dataframe[, target_index], p = prob_train, list = F)
  train_data <- dataframe[training_ids, ]
  temp <- dataframe[-training_ids, ]
  validation_ids <- createDataPartition(temp[, target_index], p = prob_val, list = F)
  list(train = train_data, val = temp[validation_ids, ], test = temp[-validation_ids, ])
}

new_data_1 <- rda_cb_partition2(data, 14, 0.8)
new_data_2 <- rda_cb_partition3(data2, 14, 0.7, 0.5)

head(new_data_1$val)
head(new_data_2$test)

# Extraer 40 valores aleatorios de la columna CRIM del dataframe data
sample1 <- sample(data$CRIM, 40, replace = F)


















