
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema1")

library(scales) # Instalar con install.packages('scales')

# Cargar dataset
students <- read.csv('../../data/tema1/data-conversion.csv')

students$Income_rescaled <- rescale(students$Income) # El valor mas grande 1 el más pequeño 0

(students$Income - min(students$Income))/
  (max(students$Income) - min(students$Income))

rescale(students$Income, to = c(0, 100)) # Para reescalar de 0 a 100

rescale_many <- function(dataframe, cols){
  names <- names(dataframe)
  for(col in cols){
    name <- paste(names[col], 'rescaled', sep = '_')
    dataframe[name] <- rescale(dataframe[, col])
  }
  cat(paste('Hemos reescalado', length(cols), 'variable(s)'))
  dataframe
}

students <- rescale_many(students, c(1, 4))
