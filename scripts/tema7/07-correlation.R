
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema7")

# Cargar dataset
mtcars <- read.csv('../../data/tema7/mtcars.csv')
mtcars$X = NULL

library(ggplot2) # Instalar con install.packages('ggplot2')
library(corrplot) # Instalar con install.packages('corrplot')

mtcars_cor <- cor(mtcars, method = 'pearson')

round(mtcars_cor, digits = 2) # redondear a dos decimales

corrplot(mtcars_cor)
corrplot(mtcars_cor, method = 'shade',
         shade.col = NA, tl.col = 'black',
         tl.srt = 45)

col <- colorRampPalette(c('#BB4444', '#EE9988', '#FFFFFF',
                          '#77AADD', '#4477AA'))

corrplot(mtcars_cor, method = 'shade',
         shade.col = NA, tl.col = 'black',
         tl.srt = 45, col = col(200),
         addCoef.col = 'black',
         order = 'AOE', type = 'upper',
         diag = FALSE, addshade = 'all')

# Otra forma con la librería reshape2
library(reshape2) # Instalar con install.packages('reshape2')
mtcars_melted <- melt(mtcars_cor)
head(mtcars_melted)

ggplot(data = mtcars_melted, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile()

# Agregando tonalidades a las Matrices de Color

get_lower_traingle <- function(cormat){
  cormat[upper.tri(cormat)] <- NA
  return(cormat)
}

get_upper_traingle <- function(cormat){
  cormat[lower.tri(cormat)] <- NA
  return(cormat)
}

reorder_cormat <- function(cormat){
  dd <- as.dist((1 - cormat)/2)
  hc <- hclust(dd)
  cormat <- cormat[hc$order, hc$order]
}

cormat <- reorder_cormat(mtcars_cor)
cormat_ut <- get_upper_traingle(cormat)
cormat_ut_melted <- melt(cormat_ut, na.rm = TRUE)

ggplot(cormat_ut_melted, aes(Var2, Var1, fill = value)) +
  geom_tile(color = 'white') +
  scale_fill_gradient2(low = 'blue', high = 'red', mid = 'white',
                       midpoint = 0, limit = c(-1, 1), space = 'Lab',
                       name = 'Pearson\nCorrelation') +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1,
                                   size = 12, hjust = 1)) +
  coord_fixed()
