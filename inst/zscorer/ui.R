################################################################################
#
# UI
#
################################################################################
#
# Load dependencies
#
library(shiny)
library(shinythemes)
library(zscorer)
#
#
#
navbarPage(title = "zscorer", id = "chosenTab",
  tabPanel(title = "", value = 1, icon = icon(name = "home", class = "fa-lg"),
    div(class = "outer",
        tags$head(includeCSS("styles.css"))
    )
  ),
  tabPanel(title = "", value = 1, icon = icon(name = "question", class = "fa-lg")
  ),
  tabPanel(title = "", value = 1, icon = icon(name = "info", class = "fa-lg")
  )
)
