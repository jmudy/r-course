
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema3")

# Cargar dataset
cp <- read.csv('../../data/tema3/college-perf.csv')

cp$Perf <- ordered(cp$Perf,
                   levels = c('Low', 'Medium', 'High'))

cp$Pred <- ordered(cp$Pred,
                   levels = c('Low', 'Medium', 'High'))

table <- table(cp$Perf, cp$Pred,
               dnn = c('Acual', 'Predecido'))

table

prop.table(table) # El 100% no está repartido por filas o columnas

round(prop.table(table, 1)*100, 2) # Indico que las filas tienen que sumar el 100%

round(prop.table(table, 2)*100, 2) # Indico que las columnas tienen que sumar el 100%

barplot(table, legend = TRUE,
        xlab = 'Nota predecida por el modelo')

mosaicplot(table, main = 'Eficiencia del modelo')

summary(table)
