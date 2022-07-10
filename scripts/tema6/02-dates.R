
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema6")

# EPOCH : 1 de enero de 1970

# Fecha de hoy
Sys.Date()

# Año con dos dígitos
as.Date('1/1/80', format = '%m/%d/%y')

# Año con cuatro dígitos
as.Date('1/1/1980', format = '%m/%d/%Y')

# yyyy-mm-dd ó yyyy/mm/dd
as.Date('2018-01-06')
as.Date('88/05/19')

# Ver días que han pasado desde el EPOCH
as.numeric(as.Date('1992/12/26'))
as.numeric(Sys.Date())

as.Date('Jul 10, 2022', format = '%b %d, %Y')
as.Date('July 10, 2022', format = '%B %d, %Y')

# Fechas desde días de EPOCH

dt <- 2022 # 2022 días después del EPOCH
class(dt) <- 'Date'
dt

dt <- -2022 # 2022 días antes del EPOCH
class(dt) <- 'Date'
dt

dt <- as.Date(2022, origin = as.Date('1992-12-26')) # 2022 días después de mi nacimiento
as.Date(-2022, origin = as.Date('1992-12-26')) # 2022 días antes de mi nacimiento

# Componentes de las fechas
dt

# Año en cuatro dígitos
format(dt, '%Y')

# Año en cuatro dígitos como número en lugar de String
as.numeric(format(dt, '%Y'))

# Año en dos dígitos
format(dt, '%y')

# Año en dos dígitos como número en lugar de String
as.numeric(format(dt, '%y'))

# Mes como String
format(dt, '%b')
format(dt, '%B')
months(dt)
weekdays(dt)
quarters(dt)
julian(dt)

julian(dt, origin = as.Date('1992/12/26')) # Días que han pasado desde dt hasta mi nacimiento

# Operaciones y Secuencias de fechas

dt <- as.Date('1/1/2001', format = '%d/%m/%Y')
dt + 100
dt - 100
dt + 31

dt2 <- as.Date('2001/01/02')
dt2 - dt
dt - dt2
as.numeric(dt - dt)

dt < dt2
dt == dt2
dt2 < dt

seq(dt, dt + 365, 'month') # Crear secuencia mensual
seq(dt, dt + 365, '2 month') # Crear secuencia bimensual
seq(dt, as.Date('2001/01/10'), 'day') # Crear secuencia diaria
seq(from = dt, by = '4 months', length.out = 6) # Secuencia de 6 elementos cada 4 meses
seq(from = dt, by = '4 months', length.out = 6)[3] # Quedarte con el tercer elemento
seq(from = dt, by = '3 weeks', length.out = 6) # Secuencia de 6 elementos cada 3 semanas
seq(from = dt, by = '3 weeks', length.out = 6) # Quedarte con el cuarto elemento