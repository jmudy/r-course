
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema11")

names_first <- c('Jesus', 'Jack', 'Sansa', 'Peter')
names_last <- c('Mudarra', 'Sparrow', 'Stark', 'Parker')

# Función paste combina los dos vectores como si hubiéramos hecho un bucle for
paste(names_first, names_last)

single_surname <- c('Zuckerberg')

# La función paste sirve para combinar incluso vectores de diferentes tamaño
paste(names_first, single_surname)

username <- function(first, last){
  tolower(paste0(last, substring(first, 1, 2)))
}

username(names_first, names_last)

# Cargar dataset
auto <- read.csv('../../data/tema11/auto-mpg.csv')

auto$dmpg <- auto$mpg * 2.0
auto$kmpg <- auto$mpg * 1.609
head(auto)

sum(auto$mpg)
min(auto$mpg)
max(auto$mpg)
range(auto$mpg)
prod(auto$mpg)

mean(auto$mpg)
median(auto$mpg)
var(auto$mpg)
sd(auto$mpg)

(auto$mpg - mean(auto$mpg)) / sd(auto$mpg)
