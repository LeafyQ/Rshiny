# prep
library(shiny)
library(ggplot2)
library(readr)

# data prep
data<- na.omit(read_csv('GIT/Rshiny/1_R&D/R&D.csv'))
M<-1000000 # currency divisor
data[,2]<-data[,2]/M
colnames(data)[2]<-'Money Spent (Million $)'
c <- unique(data$Country)
year <- unique(sort(data$Year), descending = T)
 
# ui
ui<-navbarPage()


# server
server<-function(input, output){



}

# call to connect app
shinyApp(ui,server)

