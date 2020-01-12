#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("2019 Expenses"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("category", "Category:", 
                        choices=unique(data2$category)),
            helpText("My Expenses from June to December 2019")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type="tab",
                        tabPanel("Summary",verbatimTextOutput("summary")),
                        tabPanel("Data",verbatimTextOutput("Data")),
                        tabPanel("Plot",plotOutput("barchart"))
                        
                        )
        )
    )
))
