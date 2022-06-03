
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema1")

# Cargar dataset
housing <- read.csv('../../data/tema1/BostonHousing.csv')

housing_z <- scale(housing, center = TRUE, scale = TRUE) # Por defecto
housing_none <- scale(housing, center = FALSE, scale = FALSE) # Se queda igual que el original
housing_mean <- scale(housing, center = TRUE, scale = FALSE) # Solo resta la media
housing_sd <- scale(housing, center = FALSE, scale = TRUE) # Solo divido entre la desviacion tipica

# sd = sqrt(sum(x^2)/(n-1))

scale_many <- function(dataframe, cols){
  names <- names(dataframe)
  for(col in cols){
    name <- paste(names[col], 'z', sep = '_')
    dataframe[name] <- scale(dataframe[, col])
  }
  cat(paste('Hemos normalizado', length(cols), 'variable(s)'))
  dataframe
}

housing <- scale_many(housing, c(1, 3, 5:8))
