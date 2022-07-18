
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema7")

# Cargar dataset
mtcars <- read.csv('../../data/tema7/mtcars.csv')
head(mtcars)

rownames(mtcars) = mtcars$X
mtcars$X = NULL
head(mtcars)

library(plot3D) # Instalar con install.packages('plot3D')

scatter3D(x = mtcars$disp,
          y = mtcars$wt,
          z = mtcars$mpg,
          clab = c('Millas/Galeón'),
          pch = 19,
          cex = 1,
          theta = 45, phi = 20, # Ángulos de rotación del cubo, azimutal y colatitud
          main = 'Coches de los 70s',
          xlab = 'Desplazamiento (cu.in.)',
          ylab = 'Peso (x1000lb)',
          zlab = 'Millas por galéón',
          bty = 'g') # Forma del cubo

text3D(x = mtcars$disp,
       y = mtcars$wt,
       z = mtcars$mpg,
       labels = rownames(mtcars),
       add = T,
       colkey = F,
       cex = 0.6)

# Textos e Histogramas en 3D

data(VADeaths) # Tarda un poco en cargar
head(VADeaths)
hist3D(z = VADeaths,
       scale = F, expand = 0.01,
       bty = 'g', phi = 30,
       col = '#1188CC', border = 'black',
       shade = 0.4, ltheta = 80,
       space = 0.3,
       ticktype = 'detailed')

scatter3D(x = mtcars$disp,
          y = mtcars$wt,
          z = mtcars$mpg,
          type = 'h')
