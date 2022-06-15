
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema1")

library(XML) # install.packages('XML')

# Cargar dataset XML
url <- '../../data/tema1/cd_catalog.xml'

xmldoc <- xmlParse(url) # XMLInternalDocument
rootnode <- xmlRoot(xmldoc)
rootnode[1] # Acceder al primer elemento del nodo raiz

cds_data <- xmlSApply(rootnode, function(x) xmlSApply(x, xmlValue))
cds_catalog <- data.frame(t(cds_data), row.names = NULL) # Hacer transposición de cds_data
head(cds_catalog)
cds_catalog[1:5, ]

# Funciones xpathSApply() y getNodeSet() para profundizar más en XML en R

# Tablas HTML
population_url <- '../../data/tema1/WorldPopulation-wiki.htm'
tables <- readHTMLTable(population_url) # Devuelve una lista de todas las tablas en la página web
most_populated <- tables[[6]]
head(most_populated)

# Otra forma mas rápida de indicar la tabla que queremos leer
custom_table <- readHTMLTable(population_url, which = 6)
