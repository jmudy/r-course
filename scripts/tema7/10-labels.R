
# Directorio de trabajo
setwd("~/repos/r-course/scripts/tema7")

# Cargar dataset
tooth <- read.csv('../../data/tema7/ToothGrowth.csv')
head(tooth)

library(ggplot2) # Instalar con install.packages('ggplot2')

ggplot(tooth, aes(x = dose, y = len, fill = as.factor(dose))) +
  geom_boxplot() +
  ggtitle('Crecimiento dental en función de una dosis (mg/día) de medicamento') +
  xlab('Dosis de vitamina C (mg/día)') +
  ylab('Crecimiento dental (en mm)') +
  labs(fill = "Dosis en mg/día") +
  theme(legend.position = 'bottom') +
  guides(fill = F)

# Colores y temas
ggplot(tooth, aes(x = dose, y = len)) +
  geom_boxplot() +
  theme_bw() +
  #theme_dark() +
  #theme_classic() +
  #theme_grey() +
  #theme(plot.background = element_rect(fill = 'darkblue')) +
  theme(axis.text.x = element_text(face = 'bold',
                                   family = 'Times',
                                   size = 14,
                                   angle = 45,
                                   color = '995566'),
        axis.text.y = element_text(face = 'italic',
                                   family = 'Courier',
                                   size = 16,
                                   angle = 30,
                                   color = '#449955')) +
  theme(panel.border = element_blank()) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
