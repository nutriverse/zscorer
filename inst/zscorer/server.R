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
                  choices = list("Select" = ., "Male" = 1, "Female" = 2),
                  selected = .)
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
                   value = NULL,
                   min = 1,
                   max = 30,
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
                   value = NULL,
                   min = 45,
                   max = 120,
                   step = 0.1)
    }
  })
  #
  # Input for head circumference
  #
  output$hc1 <- renderUI({
    #
    # If user selects "hcfa"
    #
    if(input$dataType == 1){
      numericInput(inputId = "hc1",
                   label = "Head circumference (cm)",
                   value = NULL,
                   min = 30,
                   max = 60,
                   step = 0.1)
    }
  })
  #
  # Input for arm circumference
  #
  output$muac1 <- renderUI({
    #
    # If user selects "acfa"
    #
    if(input$dataType == 1){
      numericInput(inputId = "muac1",
                   label = "Mid-upper arm circumference (cm)",
                   value = NULL,
                   min = 10,
                   max = 25,
                   step = 0.1)
    }
  })
  #
  # Input for subscapular skinfold
  #
  output$ss1 <- renderUI({
    #
    # If user selects "ssfa"
    #
    if(input$dataType == 1){
      numericInput(inputId = "ss1",
                   label = "Subscapular skinfold (mm)",
                   value = NULL,
                   min = 3,
                   max = 20,
                   step = 0.1)
    }
  })
  #
  # Input for triceps skinfold
  #
  output$ts1 <- renderUI({
    #
    # If user selects "tsfa"
    #
    if(input$dataType == 1){
      numericInput(inputId = "ts1",
                   label = "Triceps skinfold (cm)",
                   value = NULL,
                   min = 3,
                   max = 23,
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
                   value = NULL,
                   min = 0,
                   max = 60,
                   step = 0)
    }
  })
  #
  #
  #
  index.list <- reactive({
    index.list <- NULL
    if(!is.null(input$weight1) & input$dataType == 1) { index.list <- c(index.list, "wfa") }
    if(!is.null(input$height1) & input$dataType == 1) { index.list <- c(index.list, "hfa") }
    if(!is.null(input$weight2) & input$dataType == 2) { index.list <- c(index.list, "wfa") }
    if(!is.null(input$height2) & input$dataType == 2) { index.list <- c(index.list, "hfa") }
    if(input$dataType == 2) { index.list <- c(index.list, "wfa", "hfa", "hcfa", "acfa", "ssfa", "tsfa") }

    if(!is.null(input$weight1) & !is.null(input$height1)) {
      index.list <- c(index.list, "wfh")
    }

    full.index.list <- c("wfa", "hfa", "wfh", "bfa", "hcfa", "acfa", "ssfa", "tsfa")
    names(full.index.list) <- c("Weight-for-age",
                                "Height-for-age",
                                "Weight-for-height",
                                "BMI-for-age",
                                "Head circumference-for-age",
                                "MUAC-for-age",
                                "Subscapular skinfold-for-age",
                                "Triceps skinfold-for-age")

    sub.index.list <- full.index.list[full.index.list %in% index.list]

    return(sub.index.list)
  })
  #
  # Input for index type
  #
  output$index1 <- renderUI({
    selectInput(inputId = "index1",
                label = "Select anthropometric index",
                choices = index.list(),
                multiple = TRUE,
                size = 8,
                selectize = FALSE)
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
    # For single calculations
    #
    if(input$dataType == 1) {
      #
      #
      #
      req(input$weight1, input$age1, input$height1)
      zScore <- getAllWGS(sex = as.numeric(input$sex1), weight = input$weight1,
        height = input$height1, age = input$age1, index = "all")
      #
      #
      #
      output$waz <- renderText({ zScore[ , "waz"] })
      output$haz <- renderText({ zScore[ , "haz"] })
      output$whz <- renderText({ zScore[ , "whz"] })
      #
      #
      #
      #output$zScoreTable <- DT::renderDataTable(zScore)
    }
  })
  #
  #
  #
  observeEvent(input$calculate2, {
    #
    # for cohort calculations
    #
    if(input$dataType == 2) {
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
    }
  })
}
