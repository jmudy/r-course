
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema4")

# Cargar dataset
auto <- read.csv('../../data/tema4/auto-mpg.csv')
auto$cylinders <- factor(auto$cylinders,
                         levels = c(3, 4, 5, 6, 8),
                         labels = c('3c', '4c', '5c', '6c', '8c'))

library(caret) # Instalar con install.packages('caret')

set.seed(123)
t_id <- createDataPartition(auto$mpg, p = 0.7, list = FALSE)
names(auto)

mod <- lm(mpg ~ ., data = auto[t_id, -c(1, 8, 9)])
mod

# mpg = 38.147543 +
#       8.507362*4c + 14.845745*5c + 5.437054*6c + 8.152621*8c
#       -0.001588*displacement -0.053856*horsepower
#       -0.005165*weight -0.062013*acceleration

summary(mod)

boxplot(mod$residuals)

sqrt(mean((mod$fitted.values - auto[t_id, ]$mpg)^2))

pred <- predict(mod, auto[-t_id, -c(1, 8, 9)])
sqrt(mean((pred - auto[-t_id, ]$mpg)^2))

par(mfrow = c(2, 2))
plot(mod)

# Cambiar variable de referencia de 3c a 4c
auto <- within(auto,
               cylinders <- relevel(cylinders, ref = '4c'))

mod <- lm(mpg ~ ., data = auto[t_id, -c(1, 8, 9)])
mod

pred <- predict(mod, auto[-t_id, -c(1, 8, 9)])
sqrt(mean((pred - auto[-t_id, ]$mpg)^2))

plot(mod)

par(mfrow = c(1, 1))

# Función step para simplificar el Modelo Lineal

library(MASS) # Instalar con install.packages('MASS')

mod
summary(mod)

step_model <- stepAIC(mod, direction = 'backward')
summary(step_model)
