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
navbarPage(title = "zscorer", id = "chosenTab", theme = shinytheme("cerulean"),
  tabPanel(title = "", value = 1, icon = icon(name = "home", class = "fa-lg"),
    div(class = "outer",
        tags$head(includeCSS("styles.css"))
    ),
    sidebarPanel(
      #
      # Select type of anthropometric index
      #
      radioButtons(inputId = "indexType",
        label = "Anthropometric index to calculate",
        choices = list("Weight-for-age" = "wfa",
                       "Height-for-age" = "hfa",
                       "Weight-for-height" = "wfh"),
        selected = "wfa"),
      #
      # Select type of data
      #
      radioButtons(inputId = "dataType",
        label = "Type of data to input",
        choices = list("Single child" = 1, "Cohort/sample of children" = 2),
        selected = 1),
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
      # Age input
      #
      uiOutput(outputId = "age1"),
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
      #
      #
      uiOutput(outputId = "calculate1"),
      #
      #
      #
      uiOutput(outputId = "calculate2")
    ),
    #
    #
    #
    mainPanel(
      #
      #
      #
      textOutput("zScore"),
      #
      # Data table
      #
      DT::dataTableOutput("anthroTable")
    )
  ),
  tabPanel(title = "About", value = 2),
  tabPanel(title = "Help", value = 3)
)
