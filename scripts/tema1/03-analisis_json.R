
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema1")

library(jsonlite) # install.packages('jsonlite')

data_1 <- fromJSON('../../data/tema1/students.json')
data_2 <- fromJSON('../../data/tema1/student-courses.json')

library(curl) # install.packages('curl')
url <- 'http://www.floatrates.com/daily/usd.json'
currencies <- fromJSON(url)

# Extraer datos de un JSON
currencies$eur
