#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Anima : choix aléatoires"),
  
  # Sidebar avec choix des entrées 
  sidebarLayout(
    #position = "right",
    
    sidebarPanel(
      ## 1 : dé normal
      h4("1) Dé normal"),
      
      actionButton("deNormal", "Dé"),
      
      
      ## 2 : dé Anima ouvert
      h4("2) Dé Anima (ouvert)"),
      
      numericInput("seuilUp", "Seuil crit :", 90, min = 1, max = 100, width = "50%"),
      numericInput("seuilDown", "Seuil échec :", 3, min = 1, max = 100, width = "50%"),
      actionButton("deOuvert", "Dé anima"),
      
      
      ## 3 : Caprices du Destin
      h4("3) Etat négatif "),
      h6("pour 'Caprices du Destin' , Chaos 14"),
      
      actionButton("neg3", "Go"),
      
      
      ## 4 : Random
      
      h4("4) Sorts aléatoires"),
      h6("pour 'Random' , Chaos 34"),
      numericInput("nbSorts", "Nombre de sorts :", 2, min = 1, max = 10, width = "50%"),
      sliderInput("lvlMax",
                  "Niveau max des sorts :",
                  min = 50,
                  max = 70,
                  value = 70,
                  step = 10),
      
      
      # sliderInput("rangeSl", "Range", min = 0, 
      #             max = 100, value = c(40, 60)
      # ),

      actionButton("bouton4", "Sorts")
    ),
    
    
    
    # Sorties des commandes 
    mainPanel(
      ## 1 : dé normal
      h4("1) jet de dé normal"),
      verbatimTextOutput("sortie1"),
      
      
      ## 2 : dé ouvert
      h4("2) jet de dé anima"),
      verbatimTextOutput("sortie2"),
      
      
      ## 3 : dé ouvert
      h4("3) neg"),
      verbatimTextOutput("sortie3"),
      
      
      ## 4 : sort random
      h4("4) Sort Random"),
      verbatimTextOutput("sortie4")
    )
  )
))
