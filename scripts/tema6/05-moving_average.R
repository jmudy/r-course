
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema6")

# Cargar dataset
s <- read.csv('../../data/tema6/ts-example.csv')

n <- 7
weights <- rep(1/n, n)
weights

s_fil_1 <- filter(s$sales, filter = weights, sides = 2)

s$sales
# Lo que hace es, por ejemplo en el cuarto valor que es 101, tomar el promedio con los tres anteriores
# y 3 posteriores, promedio de = {51, 56, 37, 101, 66, 63, 45}

plot(s$sales, type = 'l') # sin filtrado
lines(s_fil_1, col = 'blue', lwd = 3)

# Con side = 1 no será hasta el séptimo día cuando promediará con los sextos anteriores
s_fil_2 <- filter(s$sales, filter =  weights, sides = 1)
lines(s_fil_2, col = 'red', lwd = 3)
