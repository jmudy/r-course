
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema1")

# Cargar dataset
auto <- read.csv('../../data/tema1/auto-mpg.csv',header = TRUE, sep = ',', na.strings = '', stringsAsFactors = FALSE)

names(auto) # para leer los nombres de las variables

# read.csv2 == read.csv('filename', sep = ';', dec = ',')
# Tambien es comun separaciones por tabulacion con sep = '\t'

# Datasets sin cabecera utilizar header = FALSE
auto_no_header <- read.csv('../../data/tema1/auto-mpg-noheader.csv', header = FALSE)

head(auto_no_header, 4) # para ver las primeras 4 lineas del dataset

# Dar nombres a las columnas cuando el dataset no tiene cabecera
auto_custom_header <- read.csv('../../data/tema1/auto-mpg-noheader.csv',
                              header = FALSE,
                              col.names = c('numero', 'millas_por_galeon', 'cilindrada',
                                            'desplazamiento', 'caballos de potencia', 'peso',
                                            'aceleracion', 'año', 'modelo')
                              )

# Cargar csv de Internet
who_from_internet <- read.csv('https://frogames.es/course-contents/r/intro/tema1/WHO.csv')

# NA: not available
# na.strings = '' # tratar como NAs los espacios en blanco
# as.character si queremos tarbajar como caracter una variable que fue convertida a factor
