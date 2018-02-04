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
      # Data table
      #
      DT::dataTableOutput("anthroTable"),
      #
      # z-scores table
      #
      DT::dataTableOutput("zScoreTable")
    )
  ),
  tabPanel(title = "About", value = 2,
    #div(class = "outer",
    #    tags$head(includeCSS("styles.css"))
    #),
    sidebarPanel(width = 3,
      HTML("
        <h4>Contents</h4>
        <h5><a href='#HEAD1'>Introduction</a></h5>
        <h5><a href='#HEAD2'>Installation</a></h5>
        <h5><a href='#HEAD3'>Usage</a></h5>
        <h5><a href='#HEAD4'>Authors</a></h5>
        <h5><a href='#HEAD5'>License</a></h5>
      ")
    ),
    mainPanel(width = 9,
      HTML("
        <a id='HEAD1'></a><h3>zscorer: Weight-for-age, height-for-age and weight-for-height z-score
        calculator</h3><img src='https://validmeasures.nyc3.digitaloceanspaces.com/logos/zscorer.png' style='float:right; margin-left:auto; margin-right:auto' />
        <br/>
        <p><code>zscorer</code> facilitates the calculation of <strong>z-scores</strong>
        (i.e. the number of standard deviations from the mean) for the three key
        anthropometric indices used to assess early childhood growth: <em>weight-for-age (WFA)</em>,
        <em>height-for-age (HFA)</em> and <em>weight-for-height (WFH)</em>. <code>zscorer</code>
        refers to the results of the <strong>WHO Multicentre Growth Reference Study</strong>
        as standard for calculating the <strong>z-scores</strong> hence it comes
        packaged with this reference data.</p>

        <p><code>zscorer</code> can be used to calculate the appropriate <strong>z-score</strong>
        for the corresponding anthropometric index for a single child to assess growth and
        nutritional status against the standard. It can also be used to calculate
        the <strong>z-scores</strong> for an entire cohort or sample of children
        (such as in nutrition surveys) to allow for assessing the nutritional status
        of the entire child population.</p>
        <br/>

        <a id='HEAD2'></a><h3>Installation</h3>
        <p>You can install <code>zscorer</code> from GitHub with:</p>
        <blockquote>
        <code># install.packages('devtools')<br/>
        devtools::install_github('nutriverse/zscorer')<br/>
        # load package<br/>
        library(zscorer)</code>
        </blockquote>
        <br/>

        <a id='HEAD3'></a><h3>Usage</h3>
        <p>To run <code>zscorer</code> Shiny app, use the following command in R:</p><br/>

        <blockquote>
        <code>> run_zscorer()</code>
        </blockquote>
        <br/>

        <a id='HEAD4'></a><h3>Authors</h3>
        <p>The R scripts on which this package was based on were written by Mark
        Myatt and Ernest Guevarra on the 20th of December 2012.</p>
        <p>Additional scripts that expand on previously written scripts to
        enhance utility and functionality, has been written by Ernest Guevarra</p>
        <p>Ernest Guevarra has packaged these scripts into an R standard format
        and is the maintainer of this package</p>
        <p>The <code>zscorer</code> Shiny app built into the package was created
        and maintained by Ernest Guevarra</p>
        <br/>

        <a id='HEAD5'></a><h3>License</h3>
        <p>This package and the built in Shiny app is licensed under the AGPL-3
        License.</p>
      ")
    )
  )
)
