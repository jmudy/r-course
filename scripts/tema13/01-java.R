
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema13/java-files/")

library(rJava) # Instalar con install.packages('rJava')
.jinit()
.jcall('java/lang/System', 'S', 'getProperty', 'java.runtime.version')
.jaddClassPath(getwd())
.jclassPath()

