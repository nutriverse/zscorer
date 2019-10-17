################################################################################
#
# Server function
#
################################################################################
##
function(input, output, session) {
  #
  ##############################################################################
  ## INPUTS
  ##############################################################################
  ## Header text for single child input
  output$header1 <- renderText({
    ## If dataType == 1
    if(input$dataType == 1){
      "Enter child's age, sex and anthropometric measurements"
    }
  })
  ## Input for sex
  output$sex1 <- renderUI({
    ## If user selects "wfa" or "wfh" and "Single child" options...
    if(input$dataType == 1){
      selectInput(inputId = "sex1",
                  label = "Sex",
                  choices = list("Select" = "", "Male" = 1, "Female" = 2),
                  selected = "")
    }
  })
  ## Input for weight
  output$weight1 <- renderUI({
    ## If user selects "wfa" or "wfh" and "Single child" options...
    if(input$dataType == 1){
      numericInput(inputId = "weight1",
                   label = "Weight (kg)",
                   value = NULL,
                   min = 1,
                   max = 30,
                   step = 0.1)
    }
  })
  ## Input for height
  output$height1 <- renderUI({
    ## If user selects "hfa" or "wfh" and "Single child" options...
    if(input$dataType == 1){
      numericInput(inputId = "height1",
                   label = "Height (cm)",
                   value = NULL,
                   min = 45,
                   max = 120,
                   step = 0.1)
    }
  })
  ## Input for head circumference
  output$hc1 <- renderUI({
    ## If user selects "hcfa"
    if(input$dataType == 1){
      numericInput(inputId = "hc1",
                   label = "Head circumference (cm)",
                   value = NULL,
                   min = 30,
                   max = 60,
                   step = 0.1)
    }
  })
  ## Input for arm circumference
  output$muac1 <- renderUI({
    ## If user selects "acfa"
    if(input$dataType == 1){
      numericInput(inputId = "muac1",
                   label = "Mid-upper arm circumference (cm)",
                   value = NULL,
                   min = 10,
                   max = 25,
                   step = 0.1)
    }
  })
  ## Input for subscapular skinfold
  output$ss1 <- renderUI({
    ## If user selects "ssfa"
    if(input$dataType == 1){
      numericInput(inputId = "ss1",
                   label = "Subscapular skinfold (mm)",
                   value = NULL,
                   min = 3,
                   max = 20,
                   step = 0.1)
    }
  })
  ## Input for triceps skinfold
  output$ts1 <- renderUI({
    ## If user selects "tsfa"
    if(input$dataType == 1){
      numericInput(inputId = "ts1",
                   label = "Triceps skinfold (cm)",
                   value = NULL,
                   min = 3,
                   max = 23,
                   step = 0.1)
    }
  })
  ## Input for age
  output$age1 <- renderUI({
    ## If user selects "hfa" or "wfa" and "Single child" options...
    if(input$dataType == 1){
      numericInput(inputId = "age1",
                   label = "Age (months)",
                   value = NULL,
                   min = 0,
                   max = 60,
                   step = 0)
    }
  })
  ##
  index.list <- reactive({
    index.list <- NULL
    if(!is.null(input$weight1) & input$dataType == 1) { index.list <- c(index.list, "wfa") }
    if(!is.null(input$height1) & input$dataType == 1) { index.list <- c(index.list, "hfa") }
    if(input$dataType == 2) { index.list <- c(index.list, "wfh", "wfa", "hfa", "bfa", "hcfa", "acfa", "ssfa", "tsfa") }
    if(!is.null(input$weight1) & !is.null(input$height1) & input$dataType == 1) {
      index.list <- c(index.list, "wfh")
    }
    ##
    full.index.list <- c("wfa", "hfa", "wfh", "bfa", "hcfa", "acfa", "ssfa", "tsfa")
    names(full.index.list) <- c("Weight-for-age",
                                "Height-for-age",
                                "Weight-for-height",
                                "BMI-for-age",
                                "Head circumference-for-age",
                                "MUAC-for-age",
                                "Subscapular skinfold-for-age",
                                "Triceps skinfold-for-age")
    ##
    sub.index.list <- full.index.list[full.index.list %in% index.list]
    ##
    return(sub.index.list)
  })
  ## Input for index type
  output$index1 <- renderUI({
    selectInput(inputId = "index1",
                label = "Select anthropometric index",
                choices = index.list(),
                multiple = TRUE,
                size = 8,
                selectize = FALSE)
  })
  ##
  output$header2 <- renderText({
    ## If dataType == 2...
    if(input$dataType == 2){
      "Upload anthropometric data from multiple children"
    }
  })
  ## File input
  output$file1 <- renderUI({
    ## If user selects "Cohort/sample of children" option...
    if(input$dataType == 2){
      fileInput(inputId = "file1",
                label = "Upload children cohort/sample data",
                accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv"),
                placeholder = "Select anthro data file")
    }
  })
  ## Input for sex variable
  output$sex2 <- renderUI({
    ## If file1 is present...
    if(!is.null(input$file1) & input$dataType == 2){
      ## Select UI
      selectInput(inputId = "sex2",
                  label = "Select sex variable",
                  choices = names(anthroDF()),
                  selected = names(anthroDF())[names(anthroDF()) %in% c("sex", "SEX", "Sex", "Gender", "gender", "GENDER")])
    }
  })
  ## Input for weight variable
  output$weight2 <- renderUI({
    ## If user selects "wfa" or "wfh" and "Cohort/sample data" and file1 is present...
    if(input$dataType == 2 & !is.null(input$file1)){
      ## Select UI
      selectInput(inputId = "weight2",
                  label = "Select weight variable",
                  choices = names(anthroDF()),
                  selected = names(anthroDF())[names(anthroDF()) %in% c("wt", "WT", "Wt", "weight", "Weight", "WEIGHT")])
    }
  })
  ## Input for height variable
  output$height2 <- renderUI({
    ## If user selects "hfa" or "wfh" and "Cohort/sample data" and file1 is present...
    if(input$dataType == 2 & !is.null(input$file1)){
      ## Select UI
      selectInput(inputId = "height2",
                  label = "Select height variable",
                  choices = names(anthroDF()),
                  selected = names(anthroDF())[names(anthroDF()) %in% c("ht", "HT", "Ht", "height", "Height", "HEIGHT")])
    }
  })
  ## Input for age variable
  output$age2 <- renderUI({
    ## If user selects "hfa" or "wfa" and "Cohort/sample data" and file1 is present...
    if(input$dataType == 2 & !is.null(input$file1)){
      ## Select UI
      selectInput(inputId = "age2",
                  label = "Select age variable",
                  choices = names(anthroDF()),
                  selected = names(anthroDF())[names(anthroDF()) %in% c("age", "AGE")])
    }
  })
  ## Input for head circumference variable
  output$hc2 <- renderUI({
    ## If user selects "hcfa" and "Cohort/sample data" and file1 is present...
    if(input$dataType == 2 & !is.null(input$file1)){
      ## Select UI
      selectInput(inputId = "hc2",
                  label = "Select head circumference variable",
                  choices = names(anthroDF()),
                  selected = names(anthroDF())[names(anthroDF()) %in% c("hc", "headCircumference", "hcircumference", "headCirc", "hcirc")])
    }
  })
  ## Input for muac variable
  output$muac2 <- renderUI({
    ## If user selects "acfa" and "Cohort/sample data" and file1 is present...
    if(input$dataType == 2 & !is.null(input$file1)){
      ## Select UI
      selectInput(inputId = "muac2",
                  label = "Select MUAC variable",
                  choices = names(anthroDF()),
                  selected = names(anthroDF())[names(anthroDF()) %in% c("muac", "MUAC")])
    }
  })
  ## Input for sub-scapular skinfold variable
  output$ss2 <- renderUI({
    ## If user selects "ssfa" and "Cohort/sample data" and file1 is present...
    if(input$dataType == 2 & !is.null(input$file1)){
      ## Select UI
      selectInput(inputId = "ss2",
                  label = "Select subscapular skinfold variable",
                  choices = names(anthroDF()),
                  selected = names(anthroDF())[names(anthroDF()) %in% c("subscapularSkinfold",  "ss")])
    }
  })
  ## Input for triceps skinfold variable
  output$ts2 <- renderUI({
    ## If user selects "tsfa" and "Cohort/sample data" and file1 is present...
    if(input$dataType == 2 & !is.null(input$file1)){
      ## Select UI
      selectInput(inputId = "ts2",
                  label = "Select triceps skinfold variable",
                  choices = names(anthroDF()),
                  selected = names(anthroDF())[names(anthroDF()) %in% c("tricepsSkinfold", "ts")])
    }
  })
  ## Calculate action button - cohort/sample
  output$calculate2 <- renderUI({
    if(input$dataType == 2 & !is.null(input$file1)){
      ##
      div(style="display:inline-block; float:left;",
        actionButton(inputId = "calculate2",
                     label = "Calculate",
                     class = "btn-primary",
                     icon = icon(name = "calculator", class = "fa-lg"),
                     width = "100%")
      )
    }
  })
  ## Calculate action button - cohort/sample - download
  output$download <- renderUI({
    if(input$dataType == 2 & !is.null(input$file1)){
      ##
      div(style="display:inline-block; float:right",
        downloadButton(outputId = "downloadResults",
                       label = "Download",
                       class = "btn-primary",
                       icon = icon(name = "download", class = "fa-lg"))
      )
    }
  })
  ## Calculate action button - single child
  output$calculate1 <- renderUI({
    if(input$dataType == 1){
      ##
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
  ## Read file1 data
  anthroDF <- reactive({
    ## If user selects "Cohort/sample children"...
    if(input$dataType == 2 & !is.null(input$file1)){
      ## Read anthro data
      read.csv(input$file1$datapath, header = TRUE, sep = ",")
    }
  })
  ##############################################################################
  #
  # CALCULATIONS
  #
  ##############################################################################
  ##
  observeEvent(input$calculate1, {
    ## For single calculations
    if(input$dataType == 1 & !is.null(input$weight1) & !is.null(input$height1)) {
      ##
      req(input$sex1, input$weight1, input$age1, input$height1)

      age <- input$age1 * (365.25 / 12)

      waz <- getWGSR(sex = input$sex1, firstPart = input$weight1, secondPart = age, index = "wfa")
      haz <- getWGSR(sex = input$sex1, firstPart = input$height1, secondPart = age, index = "hfa")
      whz <- getWGSR(sex = input$sex1, firstPart = input$weight1, secondPart = input$height1, index = "wfh")
      bfaz <- getWGSR(sex = input$sex1, firstPart = input$weight1, secondPart = input$height1, thirdPart = age, index = "bfa")

      output$waz <- renderText({ waz })
      output$haz <- renderText({ haz })
      output$whz <- renderText({ whz })
      output$bfaz <- renderText({ bfaz })
    }
    ##
    if(input$dataType == 1 & !is.null(input$muac1)) {
      ##
      req(input$sex1, input$muac1, input$age1)

      age <- input$age1 * (365.25 / 12)

      mfaz <- getWGSR(sex = input$sex1, firstPart = input$muac1, secondPart = age, index = "mfa")

      output$mfaz <- renderText({ mfaz })
    }
    ##
    if(input$dataType == 1 & !is.null(input$hc1)) {
      ##
      req(input$sex1, input$hc1, input$age1)

      age <- input$age1 * (365.25 / 12)

      hcz <- getWGSR(sex = input$sex1, firstPart = input$hc1, secondPart = age, index = "hfa")

      output$hcz <- renderText({ hcz })
    }
    ##
    if(input$dataType == 1 & !is.null(input$ss1)) {
      ##
      req(input$sex1, input$ss1, input$age1)

      age <- input$age1 * (365.25 / 12)

      ssaz <- getWGSR(sex = input$sex1, firstPart = input$ss1, secondPart = age, index = "ssa")

      output$ssaz <- renderText({ ssaz })
    }
    ##
    if(input$dataType == 1 & !is.null(input$ts1)) {
      ##
      req(input$sex1, input$ts1, input$age1)

      age <- input$age1 * (365.25 / 12)

      ssaz <- getWGSR(sex = input$sex1, firstPart = input$ts1, secondPart = age, index = "tsa")

      output$ssaz <- renderText({ tsaz })
    }
  })
  ##
  observeEvent(input$calculate2, {
    ##
    zScoreDF <- anthroDF()
    ## for cohort calculations
    if(input$dataType == 2) {
      ## BMI-for-age
      if("bfa" %in% input$index1) {
        zScoreDF <- addWGSR(data = zScoreDF,
                            sex = input$sex2,
                            firstPart = input$weight2,
                            secondPart = input$height2,
                            thirdPart = input$age2,
                            index = "bfa",
                            output = "bfa")
      }
      ##
      if("wfa" %in% input$index1) {
        zScoreDF <- addWGSR(data = zScoreDF,
                            sex = input$sex2,
                            firstPart = input$weight2,
                            secondPart = input$age2,
                            index = "wfa",
                            output = "wfa")
      }
      ##
      if("hfa" %in% input$index1) {
        zScoreDF <- addWGSR(data = zScoreDF,
                            sex = input$sex2,
                            firstPart = input$height2,
                            secondPart = input$age2,
                            index = "hfa",
                            output = "hfa")
      }
      ##
      if("hcfa" %in% input$index1) {
        zScoreDF <- addWGSR(data = zScoreDF,
                            sex = input$sex2,
                            firstPart = input$hc2,
                            secondPart = input$age2,
                            index = "hfa",
                            output = "hfa")
      }
      ##
      if("acfa" %in% input$index1) {
        zScoreDF <- addWGSR(data = zScoreDF,
                            sex = input$sex2,
                            firstPart = input$muac2,
                            secondPart = input$age2,
                            index = "mfa",
                            output = "mfa")
      }
      ##
      if("ssfa" %in% input$index1) {
        zScoreDF <- addWGSR(data = zScoreDF,
                            sex = input$sex2,
                            firstPart = input$ss2,
                            secondPart = input$age2,
                            index = "ssfa",
                            output = "ssfa")
      }
      ##
      if("tsfa" %in% input$index1) {
        zScoreDF <- addWGSR(data = zScoreDF,
                            sex = input$sex2,
                            firstPart = input$ts2,
                            secondPart = input$age2,
                            index = "tsfa",
                            output = "tsfa")
      }
      ##
      if("wfh" %in% input$index1) {
        zScoreDF <- addWGSR(data = zScoreDF,
                            sex = input$sex2,
                            firstPart = input$weight2,
                            secondPart = input$height2,
                            index = "wfh",
                            output = "wfh")
      }
      ##
      output$zScoreTable <- DT::renderDataTable(zScoreDF,
        options = list(pageLength = 15))
    }
    ##
    output$downloadResults <- downloadHandler(
      filename <- function() {
        "zscoreResults.csv"
      },
      content <- function(file) {
        write.csv(zScoreDF, file)
      }
    )
  })
}
