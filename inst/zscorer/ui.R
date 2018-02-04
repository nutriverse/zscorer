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
#devtools::install_github("nutriverse/zscorer")
library(zscorer)
#
#
#
navbarPage(title = "zscorer", id = "chosenTab", #theme = shinytheme("cerulean"),
  tabPanel(title = "", value = 1, icon = icon(name = "home", class = "fa-lg"),
    div(class = "outer",
        tags$head(includeCSS("styles.css"))
    ),
    sidebarPanel(width = 3,
      #
      # Select type of data
      #
      radioButtons(inputId = "dataType",
                   label = h5("Type of child data to input"),
                   choices = list("Single child" = 1, "Cohort/sample of children" = 2),
                   selected = 1),
      #
      # Horizontal line
      #
      hr(),
      #
      # Header 1
      #
      h5(textOutput("header1")),
      #
      # Age input
      #
      uiOutput(outputId = "age1"),
      #
      # Weight input
      #
      uiOutput(outputId = "sex1"),
      #
      # Weight input
      #
      uiOutput(outputId = "weight1"),
      #
      # Height input
      #
      uiOutput(outputId = "height1"),
      #
      # Header 2 - input file with anthropometric data (dataType == 2)
      #
      h5(textOutput("header2")),
      #
      # File input - anthro data
      #
      uiOutput(outputId = "file1"),
      #
      # Sex variable for cohort/sample
      #
      uiOutput(outputId = "sex2"),
      #
      # Weight variable for cohort/sample
      #
      uiOutput(outputId = "weight2"),
      #
      # Height variable for cohort/sample
      #
      uiOutput(outputId = "height2"),
      #
      # Age variable for cohort/sample
      #
      uiOutput(outputId = "age2"),
      #
      # Action button to calculate single child z-scores
      #
      uiOutput(outputId = "calculate1"),
      #
      # Action button to calculate cohort/sample z-scores
      #
      uiOutput(outputId = "calculate2")
    ),
    #
    #
    #
    mainPanel(width = 9,
      #
      #
      #
      #fluidRow(
      #  column(width = 4, h4("Weight-for-height z-score"),
      #    wellPanel(textOutput("waz"))
      #  ),
      #  column(width = 4, h4("Height-for-age z-score"),
      #    wellPanel(textOutput("haz"))
      #  ),
      #  column(width = 4, h4("Weight-for-height z-score"),
      #    wellPanel(textOutput("whz"))
      #  )
      #),
      #
      # Data table
      #
      DT::dataTableOutput("anthroTable"),
      #
      # z-scores table
      #
      DT::dataTableOutput("zScoreTable")
    )
  ),
  tabPanel(title = "About", value = 2),
  tabPanel(title = "Help", value = 3)
)
