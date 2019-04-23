
library(shiny)


ui <- fluidPage(
  titlePanel(h1("Animated Visualization of Gunfire Incidents in San Francisco", 
                align = "center")),
  
  sidebarLayout(
                sidebarPanel(
                  h3("Source"),
                  p("Thank you to Justice Tech Lab for providing data for San Francisco shootings from January 2013 through June 2015. http://justicetechlab.org/shotspotter-data/"),
                  h3("Adiya's Github Repo"),
                  p("https://github.com/adiya1/shotspotter")
                  ),
                
                mainPanel(
                  imageOutput("anim"))
  ))


server <- function(input, output) {
    
    output$anim <- renderImage(list(src = "sanfran_anim.gif"), 
                               deleteFile = FALSE)
  }

shinyApp(ui = ui, server = server)

