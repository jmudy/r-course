
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema2")

# Cargar dataset
data <- read.csv('../../data/tema2/auto-mpg.csv',
                 header = TRUE,
                 stringsAsFactors = FALSE)

# split / unsplit

carslist <- split(data, data$cylinders)
carslist[1] # Acceder al objeto de la lista
carslist[[1]] # Acceder al valor asociado al objeto

str(carslist[1])
str(carslist[[1]])
names(carslist[[1]])
