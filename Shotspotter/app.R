library(shiny)

# i load the shiny package to be able to build this shiny app

ui <- fluidPage(
  titlePanel(h1("Animated Visualization of Gunfire Incidents in San Francisco", 
                align = "center")),
  # fluidpage ensures that the shiny app will work smoothly on all devices and
  # work neatly
  # i assign a title to my shiny app and give it an appropriate size and
  # position by specifying header size and aligning it to the center
  
  sidebarLayout(
                sidebarPanel(
                  
  # i am working in the sidebar panel now, where i will be listing additional
  # information for my app
                  
                  h3("Source"),
                  p("Thank you to Justice Tech Lab for providing data for San Francisco shootings from January 2013 through June 2015. http://justicetechlab.org/shotspotter-data/"),
                  
                  # i am specifiying the source for my data and give my
                  # acknowledgements to Justice Tech Lab
                  
                  h3("Adiya's Github Repo"),
                  p("https://github.com/adiya1/shotspotter"),
                  
                  # i am now specifying my github repo and provide a link to it
                  
                  h4("Adiya Abdilkhay")
                  ),
  
                  # i am listing the author's name aka me
                
                mainPanel(
                  imageOutput("anim"))
  
                # i want my image gif output to show up in the main panel, so i
                # specify the name of my image output, which i assign in the
                # server, to the appropriate gif i want to show up
  ))


server <- function(input, output) {
  
  # in the server section of my shiny app, i am rendering my gif to the shiny
  # app, and say that deleteFile is false so that renderImage does not
  # automatically delete the gif
    
    output$anim <- renderImage(list(src = "sanfran_anim.gif"), 
                               deleteFile = FALSE)
}

  # i name the image here by specifying output$anim and then use list to find
  # the gif

shinyApp(ui = ui, server = server)

  # this final call will make sure that the shiny app actually works and assigns
  # ui and server to their respective sections
