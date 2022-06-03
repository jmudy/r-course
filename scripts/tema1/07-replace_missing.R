
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema1")

# Cargar dataset
data <- read.csv('../../data/tema1/missing-data.csv', na.strings = '')

# Sustituir valores NA por la media en la columna Income
data$Income_mean <- ifelse(is.na(data$Income),
                           mean(data$Income, na.rm = TRUE),
                           data$Income)

# Aqui, primero vamos a convertir los ceros a NA y despues vamos a sustituir
# los valores NA por una muestra aleatoria de dicha columna
data <- read.csv('../../data/tema1/missing-data.csv', na.strings = '')

data$Income[data$Income == 0] <- NA

# x es un vector de datos que puede contener valores NA
rand_impute <- function(x){
  # missing de tamaño de X con valores TRUE o FALSE dependiendo de si son NA o no
  missing <- is.na(x)
  # n_missing contiene cuantos valores son NA dentro de X
  n_missing <- sum(missing)
  # x_obs son los valores conocidos que tienen dato diferente de NA en x
  x_obs <- x[!missing]
  # Por defecto devolvere lo mismo que habia entrado por parametro
  imputed <- x
  # En los valores que faltaban los reemplazamos por una muestra de lo que si conocemos (MAS)
  imputed[missing] <- sample(x_obs, n_missing, replace = TRUE)
  return (imputed)
}

random_impute_dataframe <- function(dataframe, cols){
  names <- names(dataframe)
  for (col in cols){
    name <- paste(names[col], '_imputed', sep = '')
    dataframe[name] = rand_impute(dataframe[, col])
  }
  dataframe
}

data <- random_impute_dataframe(data, c(1, 2))
