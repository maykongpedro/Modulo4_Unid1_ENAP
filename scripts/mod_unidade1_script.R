

# Carregando pacotes
library(tidyverse)
        
# Carregando os dados
viagens <- read.csv2(
  file = "../dados/2019_Viagem.csv",
  sep = ";",
  dec = ",")

# Visualiando os dados
View(viagens)

# Resumo da coluna de valor das passagens
summary(viagens$Valor.passagens)

# Descobrindo o tipo de dado de cada coluna
dplyr::glimpse(viagens)

? as.Date

# Criando coluna formatada como data
viagens$data.início <- as.Date(viagens$Período...Data.de.início, "%d/%m/%Y")

# Verificando o tipo de dados novamente
dplyr::glimpse(viagens)

# Formatando a data para Ano/Mês
viagens$data.início.formatada <- format(viagens$data.início, "%Y-%m")
viagens$data.início.formatada
