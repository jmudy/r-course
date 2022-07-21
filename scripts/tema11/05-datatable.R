
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema11")

# Cargar dataset
auto <- read.csv('../../data/tema11/auto-mpg.csv', stringsAsFactors = F)
auto$cylinders <- factor(auto$cylinders,
                         levels = c(3, 4, 5, 6, 8),
                         labels = c('3C', '4C', '5C', '6C', '8C'))

library(data.table) # Instalar con install.packages('data.table')

auto_dt <- data.table(auto)
class(auto_dt)

auto_dt[, .(mpg)]
auto_dt[, .(mpg, horsepower, acceleration)]

auto_dt[cylinders %in% c('3C', '4C', '5C')]
auto_dt[cylinders == '4C' & horsepower > 100]
auto_dt[car_name %like% 'mazda']

auto_dt[, mean(mpg), by = cylinders]
auto_dt[, meanmpg := mean(mpg), by = cylinders]
head(auto_dt)

auto_dt[, c('sd_mpg', 'z_mpg') := list(
  sd(mpg), round((mpg - mean(mpg))/sd(mpg), 2)
), by = cylinders
]
auto_dt[1:5, c(1:3, 9:12), with = F]

auto_dt[, lapply(.SD, mean),
        .SDcols = c('mpg', 'horsepower')]

setkey(auto_dt, cylinders) # Para que actue esa columna como clave
tables()

auto_dt['4C', c(1:3, 9:10), with = F]

auto_dt[, list(mean = mean(mpg), min = min(mpg),
               max = max(mpg), sd = sd(mpg)),
        by = cylinders]

## DT[i, j, by]

setkeyv(auto_dt, c('cylinders', 'model_year')) # Para crear más de una clave
auto_dt[.('4C'), c(1:3, 9:10), with = F] # Cuando tenemos clave múltiple

auto_dt[, .N, by = cylinders] # Cuantos elementos hay por cilindradas
auto_dt['3C', .N]

auto_dt[, meanmpg := NULL] # Para borrar una columna
head(auto_dt)

# DT[i, j, by]

empl <- read.csv('../../data/tema11/employees.csv', stringsAsFactors = F)
dept <- read.csv('../../data/tema11/departments-1.csv', stringsAsFactors = F)

empl_dt <- data.table(empl)
dept_dt <- data.table(dept)

setkey(empl_dt, 'DeptId')

combine <- empl_dt[dept_dt]
head(combine)
combine[, .N]

dept2 <- read.csv('../../data/tema11/departments-2.csv', stringsAsFactors = F)
dept2_dt <- data.table(dept2)
combine <- empl_dt[dept2_dt] # Right join
#combine <- empl_dt[dept2_dt, nomatch = 0] # Inner join
combine[, .N] # Se han añadido dos filas con NA porque no hay empleados en esos departamentos

merge(empl_dt, dept2_dt, by = 'DeptId') # Inner join
merge(empl_dt, dept2_dt, by = 'DeptId', all.x = T) # Left join
merge(empl_dt, dept2_dt, by = 'DeptId', all.y = T) # Right join
merge(empl_dt, dept2_dt, by = 'DeptId', all = T) # Full join

# DT[i, j, by]
# .SD -> guardar referencias a todas las columnas (salvo las del by)
  # .SDcols -> la referencia guardada a las columnas (son las que se pueden incluir o excluir en la j)
# .EACHI -> para agrupar por claves
# .N -> número de filas
# .I -> los índices indicados en el DT

# Ejemplos

# Sueldo máximo de cada departamento
empl_dt[dept_dt, max(.SD), by = .EACHI, .SDcols = 'Salary']
empl_dt[dept2_dt, max(.SD), by = .EACHI, .SDcols = 'Salary']

# Sueldo promedio por departamento
empl_dt[, .(avgSalary = lapply(.SD, mean)),
        by = 'DeptId', .SDcols = 'Salary']

empl_dt[dept2_dt, list(DeptName,
                       AvgSalary = lapply(.SD, mean)),
        by = .EACHI, .SDcols = 'Salary']
