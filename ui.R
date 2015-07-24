
library(shiny)

shinyUI(fluidPage(
  
  headerPanel("TLO Wordclouds"), 
  
  sidebarPanel(
    selectInput("category", "Category:",
                c("Motivation" = 1, 
                  "Learning Belief" = 2, 
                  "Self Efficacy" = 3,
                  "Transfer" = 4,
                  "Organization" = 5
                )#end options
    ),#end selectInput
    
    selectInput("level", "Average Score:", 
                c( "0-1" = 1,
                   "1-2" = 2,
                   "2-3" = 3,
                   "3-4" = 4
                )# end options
    ) # end select input
    
  ),#end sidebar panel
  
  mainPanel(
    plotOutput("wordcloud")
  )
  
))