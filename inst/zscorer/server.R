################################################################################
#
# Server function
#
################################################################################
#
#
#
function(input, output, session) {
  #
  ##############################################################################
  #
  # INPUTS
  #
  ##############################################################################
  #
  # Header text for single child input
  #
  output$header1 <- renderText({
    #
    # If dataType == 1
    #
    if(input$dataType == 1){
      "Enter child's age, sex and anthropometric measurements"
    }
  })
  #
  # Input for sex
  #
  output$sex1 <- renderUI({
    #
    # If user selects "wfa" or "wfh" and "Single child" options...
    #
    if(input$dataType == 1){
      selectInput(inputId = "sex1",
                  label = "Sex",
                  choices = list("Select" = ".", "Male" = 1, "Female" = 2),
                  selected = ".")
    }
  })
  #
  # Input for weight
  #
  output$weight1 <- renderUI({
    #
    # If user selects "wfa" or "wfh" and "Single child" options...
    #
    if(input$dataType == 1){
      numericInput(inputId = "weight1",
                   label = "Weight (kg)",
                   value = 00.0,
                   min = 0,
                   max = 50,
                   step = 0.1)
    }
  })
  #
  # Input for height
  #
  output$height1 <- renderUI({
    #
    # If user selects "hfa" or "wfh" and "Single child" options...
    #
    if(input$dataType == 1){
      numericInput(inputId = "height1",
                   label = "Height (cm)",
                   value = 00.0,
                   min = 45,
                   max = 120,
                   step = 0.1)
    }
  })
  #
  # Input for age
  #
  output$age1 <- renderUI({
    #
    # If user selects "hfa" or "wfa" and "Single child" options...
    #
    if(input$dataType == 1){
      numericInput(inputId = "age1",
                   label = "Age (months)",
                   value = 00,
                   min = 0,
                   max = 60,
                   step = 0)
    }
  })
  #
  #
  #
  output$header2 <- renderText({
    #
    # If dataType == 2...
    #
    if(input$dataType == 2){
      "Upload anthropometric data from multiple children"
    }
  })
  #
  # File input
  #
  output$file1 <- renderUI({
    #
    # If user selects "Cohort/sample of children" option...
    #
    if(input$dataType == 2){
      fileInput(inputId = "file1",
                label = "Upload children cohort/sample data",
                accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv"),
                placeholder = "Select anthro data file")
    }
  })
  #
  # Input for sex variable
  #
  output$sex2 <- renderUI({
    #
    # If file1 is present...
    #
    if(!is.null(input$file1) & input$dataType == 2){
      #
      # Select UI
      #
      selectInput(inputId = "sex2",
                  label = "Select sex variable",
                  choices = names(anthroDF()),
                  selected = names(anthroDF())[names(anthroDF()) %in% c("sex", "SEX", "Sex", "Gender", "gender", "GENDER")])
    }
  })
  #
  # Input for weight variable
  #
  output$weight2 <- renderUI({
    #
    # If user selects "wfa" or "wfh" and "Cohort/sample data" and file1 is present...
    #
    if(input$dataType == 2 & !is.null(input$file1)){
      #
      # Select UI
      #
      selectInput(inputId = "weight2",
                  label = "Select weight variable",
                  choices = names(anthroDF()),
                  selected = names(anthroDF())[names(anthroDF()) %in% c("wt", "WT", "Wt", "weight", "Weight", "WEIGHT")])
    }
  })
  #
  # Input for height variable
  #
  output$height2 <- renderUI({
    #
    # If user selects "hfa" or "wfh" and "Cohort/sample data" and file1 is present...
    #
    if(input$dataType == 2 & !is.null(input$file1)){
      #
      # Select UI
      #
      selectInput(inputId = "height2",
                  label = "Select height variable",
                  choices = names(anthroDF()),
                  selected = names(anthroDF())[names(anthroDF()) %in% c("ht", "HT", "Ht", "height", "Height", "HEIGHT")])
    }
  })
  #
  # Input for age variable
  #
  output$age2 <- renderUI({
    #
    # If user selects "hfa" or "wfa" and "Cohort/sample data" and file1 is present...
    #
    if(input$dataType == 2 & !is.null(input$file1)){
      #
      # Select UI
      #
      selectInput(inputId = "age2",
                  label = "Select age variable",
                  choices = names(anthroDF()),
                  selected = names(anthroDF())[names(anthroDF()) %in% c("age", "AGE")])
    }
  })
  #
  # Calculate action button - cohort/sample
  #
  output$calculate2 <- renderUI({
    if(input$dataType == 2 & !is.null(input$file1)){
      #
      #
      #
      actionButton(inputId = "calculate2",
                   label = "Calculate",
                   class = "btn-primary",
                   icon = icon(name = "calculator", class = "fa-lg"))
    }
  })
  #
  # Calculate action button - single child
  #
  output$calculate1 <- renderUI({
    if(input$dataType == 1){
      #
      #
      #
      actionButton(inputId = "calculate1",
                   label = "Calculate",
                   class = "btn-primary",
                   icon = icon(name = "calculator", class = "fa-lg"))
    }
  })
  ##############################################################################
  #
  # OUTPUTS
  #
  ##############################################################################
  #
  # Read file1 data
  #
  anthroDF <- reactive({
    #
    # If user selects "Cohort/sample children"...
    #
    if(input$dataType == 2 & !is.null(input$file1)){
      #
      # Read anthro data
      #
      read.csv(input$file1$datapath, header = TRUE, sep = ",")
    }
  })
  #
  #
  #
  output$anthroTable <- DT::renderDataTable(anthroDF(),
    options = list(pageLength = 5)
  )
  ##############################################################################
  #
  # CALCULATIONS
  #
  ##############################################################################
  #
  #
  #
  observeEvent(input$calculate1, {
    #
    #
    #
    req(input$sex1, input$weight1, input$age1, input$height1)
    zScore <- getAllWGS(sex = as.numeric(input$sex1), weight = input$weight1,
      height = input$height1, age = input$age1, index = "all")
    #
    #
    #
    output$waz <- renderText({ zScore[ , "waz"] })
    output$haz <- renderText({ zScore[ , "haz"] })
    output$whz <- renderText({ zScore[ , "whz"]})
    #
    #
    #
    output$zScoreTable <- DT::renderDataTable(zScore)
  })
  #
  #
  #
  observeEvent(input$calculate2, {
    #
    #
    #
    zScoreDF <- getAllWGS(data = anthroDF(),
                          sex = input$sex2,
                          weight = input$weight2,
                          height = input$height2,
                          age = input$age2,
                          index = "all")
    #
    #
    #
    output$zScoreTable <- DT::renderDataTable(zScoreDF,
      options = list(pageLength = 15))
  })
}
