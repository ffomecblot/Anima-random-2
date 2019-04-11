#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


# # # Fonctions externes

## 2

# sample(1:100, 1) va plus vite que ceiling(runif(1,0,100))
jetPlus <- function(s=90, ec=3, relance=0, verbose=T) {
  jet <- sample(1:100, 1)
  if (jet <= ec & relance == 0) { # echec !
    if (verbose) {print(paste("Échec :", jet))}
    r <- -sample(1:100, 1)
  } else if (jet >= (s+relance) | jet == 100) { # crit !
    if (verbose) {print(paste("Crit :", jet))}
    r <- jet + jetPlus(s,0,relance+1,verbose) # suite du jet pas d'ec
  } else {
    r <- jet
  }
  return(r)
}

## 3
etatsNeg <- c('Peur : -60 TlA autres que fuir, sauf si passe un test 80 en Impassibilite',
              'Terreur : ne peut faire que fuir, sauf si passe un test 140 en Impassibilite',
              'Douleur : -40 TlA sauf si passe un test 80 de Resistance a la douleur',
              'Douleur extreme : -80 TlA sauf si passe un test 140 de Resistance a la douleur',
              'Faiblesse physique : -4 en Force, Dexterite, Agilite, Consitution',
              'Faiblesse mentale : -4 en Intelligence, Pouvoir, Volonte, Perception',
              'Paralysie partielle : -80 aux jets de combat, -30 aux autres actions et a l initiative',
              'Paralysie complete : -200 TlA et initiative',
              'Colere : attaque les cibles les plus proches le plus fort possible, sauf si passe un test 120 en Impassibilite',
              'Cecite : aveugle et -80 TlA ',
              'Surdite : ne peut plus entendre',
              'Mutisme : ne peut plus parler',
              'Fascination : aucune action active ni se deplacer, sauf si passe un test 120 en Impassibilite',
              'Degats egaux a la marge d echec',
              'Degats egaux au double de la marge d echec',
              'Inconscience',
              'Hallucinations, sauf si passe un test 140 en Impassibilite',
              'Folie, sauf si passe un test 140 en Impassibilite',
              'Petit coup de barre : malus de -20 TlA',
              'Extenuation : perd 5 points de fatigue (ne reviennent pas a la fin du sort)',
              'Nausse et mal de crane cinglant : malus de -50 TlA')

## 4
# # Fonctions
maVoie <- function (lv, selec = 1) {
  # def
  nomsPri <- c("Lumière","Obscurité","Création","Destruction","Nécro","Eau","Feu","Terre",
               "Air","Essence","Illusion")
  nomsSec <- c("Chaos","Connaissance","Guerre","Literae",
               "Mort","Musique","Noblesse","Paix","Péché","Rêve",
               "Sang","Secret","Temps","Vide")
  
  if (lv %% 10 == 4) {
    # tirer une secondaire
    voie <- sample(nomsSec,1)
  } else {
    # choisir la primaire
    voie <- nomsPri[selec]
  }
  return(voie)
}
sortAuHasard <- function(lvlMax = 40, nb = 1) {
  # def
  nomsRang <- c("basique", "intermediaire", "avancé", "arcane")
  
  for (i in 1:nb) {
    rang <- sample(nomsRang, 1)
    lv <- sample(1:(lvlMax/2), 1) *2
    
    minMaj <- sample(1:11, 1)
    if (minMaj < 6) {
      # Voie majeure
      voie <- maVoie(lv, minMaj)
      
    } else {
      # Voie mineure ; relancer pour ne pas tomber sur un 8
      while (lv %% 10 == 8) {
        lv <- sample(1:(lvlMax/2), 1) *2
      }
      
      voie <- maVoie(lv, minMaj)
    }
    print(paste0("Sort de niveau ", lv, ", de la voie ", voie, ", au rang ", rang, "."))
  }
}



# # # Exec
shinyServer(function(input, output) {
  
  ## 1
  output$sortie1 <- renderPrint({ 
    if (input$deNormal > 0 ) 
      isolate(
        sample(1:100, 1)
      )
  })
  
  ## 2
  output$sortie2 <- renderPrint({ 
    if (input$deOuvert > 0 ) 
      isolate(
        jetPlus(input$seuilUp,input$seuilDown)
      )
  })
  
  ## 3
  output$sortie3 <- renderPrint({ 
    if (input$neg3 > 0 ) 
      isolate(
        sample(etatsNeg, 1)
      )
  })
  
  ## 4
  output$sortie4 <- renderPrint({ 
    if (input$bouton4 > 0 ) 
      isolate(
        sortAuHasard(input$lvlMax, input$nbSorts)
      )
  })
  
  
})
