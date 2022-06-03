
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema1")

students_data <- read.fwf('../../data/tema1/student-fwf.txt',
                          widths = c(4, 15, 20, 15, 4),
                          col.names = c('id', 'nombre', 'email', 'carrera', 'año'))

students_data_header <- read.fwf('../../data/tema1/student-fwf-header.txt',
                                 widths = c(4, 15, 20, 15, 4),
                                 header = TRUE, sep = '\t',
                                 skip = 2) # Ignorar las dos primeras lineas del fichero

students_data_no_email <- read.fwf('../../data/tema1/student-fwf.txt',
                                   widths = c(4, 15, -20, 15, 4), # Poner la longitud en negativo
                                   col.names = c('id', 'nombre', 'carrera', 'año'))
