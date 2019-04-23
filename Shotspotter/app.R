#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(sf)
library(tigris)
library(ggthemes)

ui <- fluidPage(
  titlePanel(h1("San Francisco", style = "font-family: 'times'", align = "center")),
  
  sidebarLayout(
                sidebarPanel(
                  h3("Source", style = "font-family: 'times'; font-si16pt"),
                  p("Data from Justice Tech Lab for January 2013 through June 2015. http://justicetechlab.org/shotspotter-data/", style = "font-family: 'times'; font-si16pt")
                  ),
                
                mainPanel(
                
                  h2("Animated Map", style = "font-family: 'times'", align = "center"),)
  ))


# Define server logic required to draw a histogram
server <- function(input, output) {
    
    # Create scatterplot object the plotOutput function is expecting
    output$scatterplot <- renderPlot({
      ggplot(data = movies, aes_string(x = input$x, y = input$y)) +
        geom_point(alpha = 1)
    })
  }

# Run the application 
shinyApp(ui = ui, server = server)

