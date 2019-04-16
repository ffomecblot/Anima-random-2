#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
#require(rsconnect)


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
etatsNeg <- c("Peur : -60 TlA autres que fuir, sauf si passe un test 80 en Impassibilité",
              "Terreur : ne peut faire que fuir, sauf si passe un test 140 en Impassibilité",
              "Douleur : -40 TlA sauf si passe un test 80 en Résistance à la douleur",
              "Douleur extrême : -80 TlA sauf si passe un test 140 en Résistance à la douleur",
              "Faiblesse physique : -4 en Force, Dexterité, Agilité, Consitution",
              "Faiblesse mentale : -4 en Intelligence, Pouvoir, Volonté, Perception",
              "Paralysie partielle : -80 aux jets de combat, -30 aux autres actions et à l'initiative",
              "Paralysie complète : -200 TlA et initiative",
              "Berserk : attaque les cibles les plus proches le plus fort possible, sauf si passe un test 120 en Impassibilité",
              "Cécité : aveugle et -80 TlA ",
              "Surdité : ne peut plus entendre",
              "Mutisme : ne peut plus parler",
              "Fascination : aucune action active ni se deplacer, sauf si passe un test 120 en Impassibilité",
              "Dégats égaux à la marge d'échec",
              "Dégats égaux au double de la marge d'échec",
              "Inconscience",
              "Hallucinations, sauf si passe un test 140 en Impassibilité",
              "Folie passagère, sauf si passe un test 140 en Impassibilité",
              "Danse incontrolable, sauf si passe un test 200 en Impassibilité",
              "Petit coup de barre : malus de -20 TlA",
              "Exténuation : perd 5 points de fatigue (ne reviennent pas à la fin du sort)",
              "Nausée et mal de crane cinglant : malus de -50 TlA")

## 4
# # Une voie
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

## 6
resultatOgham <- function(nb) {
  # Noms
  Noms <- c("  El"," Eld"," Tir"," Nef"," Eth"," Ith"," Tal"," Ral"," Ort","Thul"," Amn"," Sol",
            "Shael"," Dol"," Hel"," Io"," Lum"," Ko"," Fal"," Lem"," Pul","  Um"," Mal"," Ist",
            " Gul"," Vex"," Ohm","  Lo"," Sur"," Ber"," Jah","Cham"," Zod")
  
  # Proba
  loot <- function(n=1) {
    u <- integer(n)
    for (i in 1:n) {
      u[i] <- min(floor(runif(3,0,33))+1)
    }
    return(u)
  }
  
  # Réalisation
  monLoot <- loot(nb)
  monLoot <- monLoot[order(monLoot)]
  
  a <- table(monLoot)
  names(a) <- Noms[as.integer(names(a))]
  
  print(ifelse(nb >1, "Oghams obtenus :", "Ogham obtenu :"))
  print(a)
  
}

## 7
pnj5tribes <- function() {
  
  # Catégories
  categories <- c("Vizirs","Sages","Marchands","Travailleurs","Assassins")
  
  # Détails
  c1 <- c("Chef", "Magicien", "Sensei", "Entrepreneur")
  c2 <- c("Prêtre", "Vieux", "Lettré", "Juriste", "Bibliothécaire","Traducteur")
  c3 <- c("Commerçant", "Artisan")
  c4 <- c("Mineur", "Agriculteur", "Pêcheur")
  c5 <- c("Barbare", "Mercenaire", "Assassin", "Viking", "Sauvageons")
  
  
  # Réalisation
  maCat <- sample(1:5,1)
  print(paste0("Catégorie : ", categories[maCat]))
  monGars <- sample(get(paste0("c",maCat)),1)
  print(monGars)
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
  
  ## 5
  
  ## 6
  output$sortie6 <- renderPrint({ 
    if (input$bouton6 > 0 ) 
      isolate(
        resultatOgham(input$nbOgham6)
      )
  })
  
  ## 7
  output$sortie7 <- renderPrint({ 
    if (input$bouton7 > 0 ) 
      isolate(
        pnj5tribes()
      )
  })
  
})
