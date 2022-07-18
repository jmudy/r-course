
library(ggplot2) # Instalar con install.packages('ggplot2')

# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema7")

# Cargar dataset
mtcars <- read.csv('../../data/tema7/mtcars.csv', stringsAsFactors = FALSE)
head(mtcars)

plot <- ggplot(mtcars, aes(x = wt, mpg))
plot + geom_line()
plot + geom_line(linetype = 'dashed', color = 'red')

plot + geom_line(aes(color = as.factor(carb)))
