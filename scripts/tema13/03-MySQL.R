
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema13")

library(RODBC) # Instalar con install.packages('RODBC')
odbcDataSources()

con <- odbcConnect("MySQL",
                   uid = "XXXX", # Usuario de MySQL
                   pwd = "XXXX") # Contraseña de MySQL

custData <- sqlQuery(con, "select rating from RecommendationSystem.Rating limit 5;")
custData

customers <- c("Juan Gabriel", "Ricardo", "María")
orderdate <- as.Date(c('2018-01-25', '2017-12-31', '2017-12-1'))
orderamount <- c(350, 44.65, 105.32)
orders <- data.frame(customers, orderdate, orderamount)

sqlSave(con, orders, "RecommendationSystem.Orders", append = F)

df <- sqlQuery(con, "select * from RecommendationSystem.Orders")
df

library(RMySQL) # Instalar con install.packages('RMySQL')
con <- dbConnect(MySQL(),
                 dbname = "RecommendationSystem",
                 host = "127.0.0.1", 
                 port = 3306, 
                 username = "XXXX", # Usuario de MySQL
                 password = "XXXX") # Contraseña de MySQL

ac <- dbReadTable(con, "Accomodation")
head(ac)

df <- dbGetQuery(con, "select * from Accomodation where title like '%chalet%'")
df

dbWriteTable(con, "Orders", orders, row.names = F)

dbReadTable(con, "Orders")

rs <- dbSendQuery(con, paste("SELECT a.location, max(a.price)",
                             "FROM Accomodation a ", 
                             "GROUP BY a.location ",
                             "ORDER BY max(a.price) DESC"))

while(!dbHasCompleted(rs)){
  print(fetch(rs, n = 2)) # n = -1 para obtenerlos todos de golpe
}

dbClearResult(rs)
dbDisconnect(con)
dbListConnections(dbDriver("MySQL"))

library(RJDBC) # Instalar con install.packages('RJDBC')

driver <- JDBC("com.mysql.cj.jdbc.Driver", 
               classPath = "lib/mysql-connector-java-8.0.29/mysql-connector-java-8.0.29.jar", "'")
con <- dbConnect(driver, "jdbc:mysql://127.0.0.1:3306/RecommendationSystem", 
                 "XXXX", "XXXX", useSSL = F) # Usuario y contraseña de MySQL

dbReadTable(con, 'Accomodation')

dbGetQuery(con, "select * from Accomodation")
