
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema7")

# Cargar dataset
mtcars <- read.csv('../../data/tema7/mtcars.csv')

head(mtcars)

mosaicplot(~ gear + carb, data = mtcars,
           color = 2:7, las = 1)
