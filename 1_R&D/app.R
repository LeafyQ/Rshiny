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
ui<-navbarPage(
	title = 'R&D Expense Exploration',

	# tab by country
	tabPanel(
		title = 'Country',
		sidebarLayout(
			sidebarPanel = selectInput(
				inputId = 'ctry', choice = c(1:36, 38:208)],
				label = 'Choose a country to analyze: '
			),
			mainPanel = plotOutput('trend')
		)
	),

	# tab by year
	tabPanel(
		title = 'Year',
		sidebarLayout(
			sidebarPanel = selectInput(
				inputId = 'yr',
				choice = year,
				label = 'Choose a year to analyze: '
			),
			mainPanel = plotOutput('diffCtry')
		)
	)
)


# server
server<-function(input, output){
	output$trend <- renderPlot({
		plot(data[data$Country==input$ctry,c(3,2)],type = 'b',
         main = paste("R&D expenses of ",input$ctry),
         xlab = 'Year', ylab = 'Money spent ($Million)')
	})

	output$diffCtry <- renderPlot({
		sub <- data[data$Year==input$yr,]
	    # sub <- data[data$Year==2016,]
	    ordered_data<-sub[order(-sub[,2]),]
	    ggplot(ordered_data, aes(x=reorder(Country,`Money Spent (Million $)`), y=`Money Spent (Million $)`)) +
	      # scale_x_discrete (limits = ordered_data[,'Country']) +
	      geom_bar(stat='identity') +
	      labs(x = "Country")+
	      coord_flip()
	  },
	  height = 800)

}

# call to connect app
shinyApp(ui,server)


