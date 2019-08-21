# SAGE Path Participating Journals

library(shiny)
library(shinythemes)
library(tidyverse)
library(DT)

ui <- fluidPage(
  titlePanel("SAGE Path Participating Journals"),
  mainPanel(
    fluidRow(img(src = "logo.png", align = "left", width = "250")),
    fluidRow(p("example text"), column(1)),
    fluidRow(DTOutput("participatingjournals"))
    )
  ) 

server <- function(input, output) {
  participatingjournals <- read.csv("participatingjournals.csv")
  participatingjournals <- participatingjournals[participatingjournals$SAGE.Path.Status == "Included",]
  participatingjournals <- subset(participatingjournals, select = -c(TLA, 
                                                                     SPIN.Major.Disciplines.Combined,
                                                                     SAGE.Path.Status))
  colnames(participatingjournals) <- c("Journal", "Primary Discipline", "Impact Factor?", "Other Indexing",
                                       "Gold Open Access?","APC, IF OA")

  output$participatingjournals <- renderDT({
    datatable(participatingjournals,
              options = list(
                pageLength = nrow(participatingjournals), 
                  lengthChange = FALSE,
                columnDefs = list(list(searchable = FALSE, targets = 0))
                ),
              rownames = FALSE,
              escape = 2,
              filter = "top")
  })
  
}

shinyApp(ui, server)
