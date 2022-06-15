
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema1")

# Cargar dataset
housing_data <- read.csv('../../data/tema1/housing-with-missing-value.csv',
                       header = TRUE,
                       stringsAsFactors = FALSE)

library(mice) # Instalar con install.packages('mice')
columns <- c('ptratio', 'rad')
imputed_data <- mice(housing_data[, names(housing_data) %in% columns],
                     m = 5,
                     maxit = 50,
                     method = 'pmm',
                     seed = 2018)

## pmm - comparación predictiva de medias
## logreg - regresión logística
## polyreg - regresión logística politómica
## polr - modelo de probabilidades proporcionales

summary(imputed_data)

# Los dos puntos es para indicar que la función complete es del paquete mice,
# ya que en el paquete curl también se utiliza y se puede confundir R con que función utilizar
complete_data <- mice::complete(imputed_data)

# Sustituir columnas de housing data por las calculadas en complete_data
housing_data$ptratio <- complete_data$ptratio
housing_data$rad <- complete_data$rad

# Comprobar que ahora ya no hay NAs
anyNA(housing_data)

# Otra forma de hacer el modelo predictivo para eliminar los NAs
housing_data <- read.csv('../../data/tema1/housing-with-missing-value.csv',
                         header = TRUE,
                         stringsAsFactors = FALSE)

library(Hmisc) # Instalar con install.packages('Hmisc')
impute_arg <- aregImpute(~ptratio + rad, data = housing_data, n.impute = 5)
impute_arg

# Todos los valores de NAs (5 posibles valores para cada uno de los 40 NAs del dataframe original)
impute_arg$imputed$rad
