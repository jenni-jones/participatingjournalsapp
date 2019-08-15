# SAGE Path Participating Journals

library(shiny)
library(tidyverse)
library(DT)


ui <- fluidPage(
  titlePanel(title = "SAGE Path Participating Journals"),
  img(src = "logo.png", align = "left", width = "250"),
  DTOutput("participatingjournals")
)

server <- function(input, output) {
  
  participatingjournals <- read.csv("participatingjournals.csv")
  participatingjournals <- participatingjournals[participatingjournals$SAGE.Path.Status == "Included",]
  participatingjournals <- subset(participatingjournals, select = -c(TLA, 
                                                                     SPIN.Major.Disciplines.Combined,
                                                                     SAGE.Path.Status))
  colnames(participatingjournals) <- c("Journal", "Primary Discipline", "Impact Factor?", "Other Indexing",
                                       "Open Access?","APC, IF OA")

  output$participatingjournals <- renderDT({
    datatable(participatingjournals, filter = "top", 
              options = list(pageLength = nrow(participatingjournals), 
                             lengthChange = FALSE), rownames = FALSE)
  })
  
}

shinyApp(ui, server)
