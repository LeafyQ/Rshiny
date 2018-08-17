# prep
library(shiny)
library(ggplot2)
library(GGally)
library(plotly)
# 
# haed(iris)
# ggpairs(iris[,1:4])
# building the app
# ------------------------------------------
ui<- fluidPage(
  tabsetPanel(
    # statistics summary panel
    tabPanel(title = "About the dataset",
       h3('Summary of variables:'),
       verbatimTextOutput('stat'),
       h3('Tabulation about different species:'),
       verbatimTextOutput('tab')
    ),
    
    # univariate analysis
    tabPanel(title = "Univariate Plot",
       sidebarLayout(
         sidebarPanel(
           selectInput('var',label = "Select a variable to explore: ",choices = colnames(iris)[1:4])
         ),
         mainPanel(
           plotOutput('dens')
         )
       )
    ),
    
    # bivariate plotting tab
    tabPanel(title = "Bivariate Plot",
      sidebarLayout(
        sidebarPanel(
          selectInput('x',label = 'X Variable:',choices = colnames(iris)[1:4]),
          selectInput('y',label = 'Y Variable: ',choices = colnames(iris)[1:4],selected = colnames(iris)[2])
        ),
        mainPanel(
          plotOutput("scatter")
        )
      )
    ),
    
    # predictive modeling
    tabPanel(title = "Modeling")
  )
  
)

server<-function(input, output){
  # tab1 
  output$stat <- renderPrint({
    summary(iris)
  })
  
  output$tab <- renderPrint({
    table(iris[,5])
  })
  
  #tab2
  output$dens <- renderPlot({
   ggplot(iris,aes(x = iris[,input$var],col = Species))+
      geom_density()+
      xlim(min(iris[,input$var])*0.8,max(iris[,input$var])*1.2)+
      xlab(paste(input$x," "))
  })
  
  # tab3 
  output$scatter<-renderPlot({
    ggplot(iris,aes(x=iris[,input$x],y=iris[,input$y],col = Species)) +
    geom_point()+
    labs(title = paste(input$x,' v.s. ',input$y))
  })
}

shinyApp(ui, server)

