

# Carregando pacotes
library(tidyverse)
        
# Carregando os dados
viagens <- read.csv2(
  file = "./dados/2019_Viagem.csv",
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


# =======================  EXPLORANDO OS DADOS ===================

# Histograma
hist(viagens$Valor.passagens)

# Valores min, max, média.. da coluna valor
summary(viagens$Valor.passagens)  
# Valor máximo muito distante da média, indicando a presença de outliers (valores que fogem da normalidade dos dados).
# a presença dos mesmos fazem com que o resultado de uma análise não represente a realidade

# Visualizando os valores em um boxblot
boxplot(viagens$Valor.passagens)
# com o uso do boxplot fica fácil de verificar a presença dos outliers graficamente

# Calculando o desvio padrão
desvpad <- sd(viagens$Valor.passagens)

# ------------------ Valores não preenchidos --------------

# Função usada para verificar se existem campos com valores não preenchidos
?is.na

# A função abaixo contabiliza a quantidade de campos não preenchidos por coluna
?colSums

# Usando as funções
colSums(is.na(viagens))
# Resultado muito melhor do que usar apenas o `is.na`

# ------------------ Ocorrências --------------

# Verificar a quantidade de ocorrências para cada categoria de uma determinada coluna, a quantidade de ocorrências
# para cada classe e o valor em percentual

# Veriicar a quant. de ocorr. para a coluna situação
str(viagens$Situação)

# Verificar a quant. de ocorr. para cada classe (função muito prática)
table(viagens$Situação)

# Obter o valor anterior em percentual
prop.table(table(viagens$Situação))*100


# =======================  VISUALIZAÇÃO DO DADOS ===================

# Respondendo os seguintes questionamentos:
# - Qual é o valor gasto por órgão?
# - Qual é o valor gasto por cidade?
# - Qual é a quantidade de viagens por mês?


# -----------------1. Quais orgãos estão gastando mais com passagens aéreas? --------------

# Criando um dataframe com os 15 orgãos que gastam mais
p1 <- viagens %>% 
  group_by(Nome.do.órgão.superior) %>%  #agrupando os dados por nome do orgão
  summarise(n = sum(Valor.passagens)) %>%  #descobrindo o valor gasto em passagens por orgão
  arrange(desc(n)) %>% #ordenar o resultado por ordem decrescente
  top_n(15) #filtrando somente até o décimo quinto resultado

# Renomeando as colunas (1 método)
names(p1) <- c("orgao", "valor")

# Renomeando as colunas (2 método)
p1 <- p1 %>% 
  rename(orgao = Nome.do.órgão.superior, valor = n)

p1

# Plotando os dados com ggplot
p1 %>% 
  ggplot(aes(x = reorder(orgao, valor), y = valor)) + # usando a função reorder para ordenar os dados do eixo x em função do valor
  geom_bar(stat =  "identity") + # definindo que o gráfico terá a forma geométrica de barras
  coord_flip() + # muda a orientação do gráfico
  labs(x = "Valor", y = "Orgãos") # muda o título dos eixos

# preciso reaprender como formatar o eixo y pros valores não aparecem em notação científica

# ----------------- 2. Quais os valores gastos de passagens aérea por cidade? --------------
p2 <- viagens %>% 
  group_by(Destinos) %>% 
  summarise(n = sum(Valor.passagens)) %>% 
  arrange(desc(n)) %>% 
  top_n(15)

# Renomeando as colunas (2 método)
p2 <- p2 %>% 
  rename(destino = Destinos, valor = n)
  
p2

# Plotandos os dados com ggplot
p2 %>% 
  ggplot(aes(x = reorder(destino, valor), y = valor/1000000)) +  # usando a função reorder para ordenar os dados do eixo x em função do valor
  geom_bar(stat = "identity", fill = "#0ba791") + # mudando a cor das barras usando o parâmetro "fill"
  
  geom_text(aes(label = round(valor/1000000, 2) ), hjust = 1.2, vjust = 0.3, size = 3) + # inserindo texto no gráfico,
  # label deveria inserir um retângulo para facilitar a leitura, hjust ajusta a posição na horiontal,
  # vjust ajusta a posição do texto na vertical,  e size ajusta o tamanho do mesmo
  
  coord_flip() +  # muda a orientação do gráfico
  scale_y_continuous(limits = c(0,100),expand = c(0, 0)) + # define o limite de y e gruda as barras no eixo
  # usar  " labels = function(x) paste0("R$", x, "M") " dentro da camada acima para adicionar "R$" no eixo y
  
  labs(x = "", y = "") + # títulos do eixos
  ggtitle("Valores gastos com passagem áerea por cidade (Milhões de R$)") + # título
  theme_bw() + # tema
  theme(plot.title = element_text(hjust=0.5, vjust=0.5, face = "bold"))  #ajustando posição do título
  
# Essa fórmula faz com que os valores sejam printados como números inteiros
options(scipen = 999) 


# ----------------- 3. Quão a quantidade de viagens realizadas por mês? --------------
library(lubridate)

p3 <- viagens %>% 
  group_by(data.início.formatada) %>%  #agrupando pela data de início
  summarise(qtd = n_distinct(Identificador.do.processo.de.viagem)) #contando cada viagem única usando "n_distinct",
  # garantindo que nenhuma viagem seja contada mais de uma vez

head(p3)


as.Date(p3$data.início.formatada, format = "%Y/%m") 
?strptime

# Plotando os dados com ggplot
p3 %>% 
  ggplot(aes(x = data.início.formatada, y = qtd, group = 1)) +
  geom_line() +
  geom_point() +
  scale_x_date(date_labels = "%B/%Y")+
  labs(x = "Data de início da viagem", y = "Quantidade de viagens") +
  ggtitle("Quantidade de viagens realizadas por mês") +
  theme_bw() +
  theme(plot.title = element_text(hjust=0.5, vjust=0.5, face = "bold")) #ajustando posição do título
?read_csv


# Por que é necessário colocar o "group = 1":
# For line graphs, the data points must be grouped so that it knows which points to connect. 
# In this case, it is simple -- all points should be connected, so group=1. 
# When more variables are used and multiple lines are drawn, the grouping for lines is usually done by variable.
# https://stackoverflow.com/questions/27082601/ggplot2-line-chart-gives-geom-path-each-group-consist-of-only-one-observation
  

  
  
  
  
  

