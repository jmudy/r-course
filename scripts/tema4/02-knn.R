
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema4")

# Cargar dataset
edu <- read.csv('../../data/tema4/education.csv')

library(FNN) # Instalar con install.packages('FNN')
library(dummies) # Instalar con install.packages('dummies')
library(caret) # Instalar con install.packages('caret')
library(scales) # Instalar con install.packages('scales')

dms <- dummy(edu$region, sep = '_')
edu <- cbind(edu, dms)

edu$urban_s <- rescale(edu$urban)
edu$income_s <- rescale(edu$income)
edu$under18_s <- rescale(edu$under18)

set.seed(2019)
t_id <- createDataPartition(edu$expense, p = 0.6, list = FALSE)
tr <- edu[t_id, ]
temp <- edu[-t_id, ]
v_id <- createDataPartition(temp$expense, p = 0.5, list = FALSE)
val <- temp[v_id, ]
test <- temp[-v_id, ]

# Función cálculo RMSE
rmse <- function(actual, predicted){
  return(sqrt(mean((actual-predicted)^2)))
}

reg1 <- knn.reg(tr[, 7:12], val[, 7:12], tr$expense, k = 1, algorithm = 'brute')

rmse1 <- rmse(val$expense, reg1$pred)
rmse1

reg2 <- knn.reg(tr[, 7:12], val[, 7:12], tr$expense, k = 2, algorithm = 'brute')

rmse2 <- rmse(val$expense, reg2$pred)
rmse2

reg3 <- knn.reg(tr[, 7:12], val[, 7:12], tr$expense, k = 3, algorithm = 'brute')

rmse3 <- rmse(val$expense, reg3$pred)
rmse3

df <- data.frame(actual = val$expense, pred = reg3$pred)
plot(df)
abline(0, 1)

reg4 <- knn.reg(tr[, 7:12], val[, 7:12], tr$expense, k = 4, algorithm = 'brute')

rmse4 <- rmse(val$expense, reg4$pred)
rmse4 # Aquí vuelve a subir el error por tanto nos quedamos con k = 3

errors = c(rmse1, rmse2, rmse3, rmse4)
plot(errors, type = 'o', xlab = 'k', ylab = 'RMSE') # encontramos el codo en k = 3

reg_test <- knn.reg(tr[, 7:12], test[, 7:12], tr$expense, k = 3, algorithm = 'brute')
rmse_test <- rmse(test$expense, reg_test$pred)
rmse_test

df <- data.frame(actual = test$expense, pred = reg_test$pred)
plot(df)
abline(0, 1)

# Sin partición de validación

t_id <- createDataPartition(edu$expense, p = 0.7, list = FALSE)
tr <- edu[t_id, ]
val <- edu[-t_id, ]
reg <- knn.reg(tr[, 7:12], test = NULL, y = tr$expense, k = 3, algorithm = 'brute')

rmse_reg <- sqrt(mean(reg$residuals^2))
rmse_reg

rdacb_knn_reg <- function(tr_predictor, val_predictors,
                          tr_target, val_target, k){
  library(FNN)
  res <- knn.reg(tr_predictor, val_predictors,
                 tr_target, k, algorithm = 'brute')
  rmserror <- sqrt(mean((val_target - res$pred)^2))
  cat(paste('RMSE para k = ', toString(k), ': ', rmserror, '\n', sep = ''))
  rmserror
}

rdacb_knn_reg(tr[, 7:12], val[, 7:12],
              tr$expense, val$expense, 1)

rdacb_knn_reg(tr[, 7:12], val[, 7:12],
              tr$expense, val$expense, 2)

rdacb_knn_reg(tr[, 7:12], val[, 7:12],
              tr$expense, val$expense, 3)

rdacb_knn_reg(tr[, 7:12], val[, 7:12],
              tr$expense, val$expense, 4)

rdacb_knn_reg_multi <- function(tr_predictor, val_predictors,
                                tr_target, val_target, start_k, end_k){
  rms_errors = vector()
  for (k in start_k:end_k){
    rms_error <- rdacb_knn_reg(tr_predictor, val_predictors,
                                tr_target, val_target, k)
    rms_errors <- c(rms_errors, rms_error)
  }
  plot(rms_errors, type = 'o', xlab = 'k', ylab = 'RMSE')
}

rdacb_knn_reg_multi(tr[, 7:12], val[, 7:12], tr$expense, val$expense, 1, 10)
