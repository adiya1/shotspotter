
library(shiny)


ui <- fluidPage(
  titlePanel(h1("Animated Visualization of Data on Shootings in San Francisco", 
                align = "center")),
  
  sidebarLayout(
                sidebarPanel(
                  h3("Source"),
                  p("Data from Justice Tech Lab for January 2013 through June 2015. http://justicetechlab.org/shotspotter-data/")
                  ),
                
                mainPanel(
                  imageOutput("anim"))
  ))


server <- function(input, output) {
    
    output$anim <- renderImage(list(src = "sanfran_anim.gif"), 
                               deleteFile = FALSE)
  }

shinyApp(ui = ui, server = server)

