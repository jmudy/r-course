
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema13")

library(xlsx) # Instalar con install.packages('xlsx')

auto <- read.csv("../../data/tema13/auto-mpg.csv", stringsAsFactors = F)

write.xlsx(auto, file = "../../data/tema13/auto.xlsx",
           sheetName = "Raw Data Autos", row.names = F)

auto$kpg <- auto$mpg * 1.609
auto$z_mpg <- (auto$mpg - mean(auto$mpg))/sd(auto$mpg)

auto_wb <- createWorkbook()
sheet1 <- createSheet(auto_wb, "auto1")
rows <- createRow(sheet1, rowIndex = 1)
cell_1 <- createCell(rows, colIndex = 1)[[1,1]]
setCellValue(cell_1, "Hola Data Frame de Coches!")
addDataFrame(auto, sheet1, startRow = 3, row.names = F)

cs <- CellStyle(auto_wb) +
  Font(auto_wb, isBold = T, color="red")
setCellStyle(cell_1, cs)

saveWorkbook(auto_wb, "../../data/tema13/auto-wb.xlsx")


wb <- loadWorkbook("../../data/tema13/auto-wb.xlsx")
sheets <- getSheets(wb)
sheet <- sheets[[1]]
addDataFrame(auto[,10:11], sheet, startColumn = 10, startRow = 3, row.names = F)
saveWorkbook(wb, "../../../data/tema13/auto-new.xlsx")


new_auto <- read.xlsx("../../data/tema13/auto-new.xlsx", sheetIndex = 1)
head(new_auto)
new_auto <- read.xlsx("../../data/tema13/auto-new.xlsx", 
                      sheetName = "auto1",
                      rowIndex = 3:10, colIndex= 1:9)
head(new_auto)
