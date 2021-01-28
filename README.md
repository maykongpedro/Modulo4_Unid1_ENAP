# Módulo 4 - Unidade 1
## Curso Análise de dados em Linguagem R - ENAP
Anotações do Módulo 4: Análise de Dados na Prática, Unidade 1: Analisando dados abertos de viagens a serviço".
Os dados aqui presentes são basicamente o passo a passo dessa unidade com algumas adições e modificações pessoais realizadas como incremento dos meus estudos com a Linguagem R.

Curso gratuito disponível no seguinte link:
https://www.escolavirtual.gov.br/curso/325

## Analisando dados abertos de viagens a serviço:

### 1. Definição do problema

Gastos com viagens a serviço a partir de dados do Portal da Transparência, as perguntas a serem respondidas foram:

- Qual é o valor gasto por órgão?
- Qual é o valor gasto por cidade?
- Qual é a quantidade de viagens por mês?

### 2. Obtenção dos dados
Os dados podem ser optidos a partir do [Portal da Transparência](http://www.portaltransparencia.gov.br/download-de-dados), Viagens a serviço, clicar no link do **"Arquivo"** e selecionar o ano da consulta (2019). Após isso é só baixar e abrir no R.
No exemplo aqui demonstrado foi usado o pacote [Vroom](https://cran.r-project.org/web/packages/vroom/vignettes/vroom.html) para importação dos dados, pacote este que tem como objetivo abrir rapidamente arquivos "pesados" com extensão “.csv”.

O dicionários dos dados pode ser consultado no seguinte link:
[Dicionário de Dados - Viagens a serviço - Pagamentos](http://www.portaltransparencia.gov.br/pagina-interna/603364-dicionário-de-dados-viagens-a-Serviço-Pagamentos)

### 3. Transformação dos dados obtidos
- Uso da função dplyr::glimpse para verificar o tipo de cada coluna.
- Ajuste do tipo dos dados (formato de data, principalmente)

### 4. Exploração dos dados
- Geração de Histograma, boxplot, cálculo do desvio padrão e resumo dos dados pela função *summary*.
- Tratamento dos valores não preenchidos.
- Verificação da quantidade de ocorrências por coluna e por classe usando funções como: *str*, *table*, *prop.table*.

### 5. Visualização dos resultados
- Respostas aos questionamentos levantados
- Uso de algumas funções do pacote *dplyr*
- Renomeando colunas
- Uso do pacote lubridate para formatar data
- Visualizações com ggplot2, onde aproveitei para testar temas e novas opções para os gráficos.
