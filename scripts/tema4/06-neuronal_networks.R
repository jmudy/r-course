
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema4")

# Cargar dataset
bh <- read.csv('../../data/tema4/BostonHousing.csv')

library(nnet) # Instalar con install.packages('nnet')
library(caret) # Instalar con install.packages('caret')
library(devtools) # Instalar con install.packages('devtools')

set.seed(123)

t_id <- createDataPartition(bh$MEDV, p = 0.7, list = FALSE)
summary(bh$MEDV)

fit <- nnet(MEDV/50 ~ ., data = bh[t_id, ], # Entre 50 ya que es el valor máximo y así está en el rango [0, 1]
            size = 6, decay = 0.1,
            maxit = 1000, linout = TRUE)

source_url("https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r")

plot(fit, max.sp = TRUE)

sqrt(mean((fit$fitted.values*50 - bh[t_id, 'MEDV'])^2))

pred <- predict(fit, bh[-t_id, ])
sqrt(mean((pred*50 - bh[-t_id, 'MEDV'])^2))
