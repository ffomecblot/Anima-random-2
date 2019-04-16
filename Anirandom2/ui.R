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

      actionButton("bouton4", "Sorts"),
      
      
      ## 5 : Rejeton du Chaos
      h4("5) Créature aléatoire"),
      h6("pour 'Rejeton du Chaos' , Chaos 54"),
      
      
      ## 6 : Ogham loot
      h4("6) Ogham loot"),
      numericInput("nbOgham6", "Nombre de runes :", 4, min = 1, max = 50, width = "80%"),
      actionButton("bouton6", "Loot"),
      
      
      ## 7 : PNJ 5 tribes
      h4("7) PNJ (style 5 tribes)"),
      actionButton("bouton7", "Spawn")
      
    ),
    
    
    
    # Sorties des commandes 
    mainPanel(
      ## 1 : dé normal
      h4("1) Jet de dé normal"),
      verbatimTextOutput("sortie1"),
      
      
      ## 2 : dé ouvert
      h4("2) Jet de dé anima"),
      verbatimTextOutput("sortie2"),
      
      
      ## 3 : dé ouvert
      h4("3) Effet négatif"),
      verbatimTextOutput("sortie3"),
      
      
      ## 4 : sort random
      h4("4) Sort Random"),
      verbatimTextOutput("sortie4"),
      
      
      ## 5 : Rejeton
      h4("5) Rejeton (en cours)"),
      #verbatimTextOutput("sortie5"),
      
      
      ## 6 : Ogham
      h4("6) Ogham"),
      verbatimTextOutput("sortie6"),
      
      
      ## 7 : PNJ
      h4("7) PNJ (en cours)"),
      verbatimTextOutput("sortie7")
      
    )
  )
))
