#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readxl)
library(dplyr)
data <- read_excel("2019_Expenses.xlsx", col_types = c("date", "text", "text","numeric", "numeric", "numeric","text"))
data2 <- data.frame(data) %>% group_by(Year_Month, category) %>% summarize(count=n(), Total_Spent=sum(Money.Spent), Average_Spent=mean(Money.Spent))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    
    output$summary <- renderPrint({
        summary(data2[data2$category==input$category,c("Year_Month","Total_Spent")])
                                  })
    
    output$Data <- renderPrint({
        data.frame(data2[data2$category==input$category,])
    })
    
    
    output$barchart <- renderPlot({
        
        barplot(Total_Spent ~ Year_Month, data=data2[data2$category==input$category,],
                main=paste("Expenses spent on", input$category) )
        
    })

})
