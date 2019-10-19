################################################################################
#
# UI
#
################################################################################
## Load dependencies
if(!require(shiny)) install.packages("shiny")
if(!require(shinythemes)) install.packages("shinythemes")
if(!require(zscorer)) install.package("zscorer")
##
navbarPage(title = "zscorer", id = "chosenTab", theme = shinytheme("sandstone"),
  tabPanel(title = "", value = 1, icon = icon(name = "home", class = "fa-lg"),
    div(class = "outer",
        tags$head(includeCSS("styles.css"))
    ),
    sidebarLayout(
      sidebarPanel(width = 3,
        h5(textOutput("header1")),
        ## Age input
        uiOutput(outputId = "age1"),
        ## sex input
        uiOutput(outputId = "sex1"),
        ## Weight input
        uiOutput(outputId = "weight1"),
        ## Height input
        uiOutput(outputId = "height1"),
        ## MUAC input
        uiOutput(outputId = "muac1"),
        ## Head circumference input
        uiOutput(outputId = "hc1"),
        ## Subscapular skinfold input
        uiOutput(outputId = "ss1"),
        ## Triceps skinfold
        uiOutput(outputId = "ts1"),
        ## Header 2 - input file with anthropometric data (dataType == 2)
        h5(textOutput("header2")),
        ## File input - anthro data
        uiOutput(outputId = "file1"),
        ## Anthropometric index input
        uiOutput(outputId = "index1"),
        ## Sex variable for cohort/sample
        uiOutput(outputId = "sex2"),
        ## Age variable for cohort/sample
        uiOutput(outputId = "age2"),
        ## Weight variable for cohort/sample
        uiOutput(outputId = "weight2"),
        ## Height variable for cohort/sample
        uiOutput(outputId = "height2"),
        ## mauc variable for cohort/sample
        uiOutput(outputId = "muac2"),
        ## head circumference variable for cohort/sample
        uiOutput(outputId = "hc2"),
        ## subscapular skinfold variable for cohort/sample
        uiOutput(outputId = "ss2"),
        ## Age variable for cohort/sample
        uiOutput(outputId = "ts2"),
        ## Action button to calculate single child z-scores
        uiOutput(outputId = "calculate1"),
        ## Action button to calculate cohort/sample z-scores
        uiOutput(outputId = "calculate2"),
        ## Action button to download cohort/sample z-scores
        uiOutput(outputId = "download")
      ),
      ## Main panel
      mainPanel(width = 9,
        tabsetPanel(id = "dataType", selected = 1,
          tabPanel(title = "Single", value = 1,
            conditionalPanel("input.calculate1",
              column(width = 3,
                wellPanel(h5("Weight-for-age z-score"),
                  hr(),
                  uiOutput(outputId = "waz")
                )
              ),
              column(width = 3,
                wellPanel(h5("Height-for-age z-score"),
                  hr(),
                  uiOutput(outputId = "haz")
                )
              ),
              column(width = 3,
                wellPanel(h5("Weight-for-height z-score"),
                  hr(),
                  uiOutput(outputId = "whz")
                  )
              ),
              column(width = 3,
                wellPanel(h5("BMI-for-age z-score"),
                  hr(),
                  uiOutput(outputId = "bfaz")
                )
              ),
              column(width = 3,
                wellPanel(h5("MUAC-for-age z-score"),
                  hr(),
                  uiOutput(outputId = "mfaz")
                )
              ),
              column(width = 3,
                wellPanel(h5("Head circumference-for-age z-score"),
                  hr(),
                  uiOutput(outputId = "hcz")
                )
              ),
              column(width = 3,
                wellPanel(h5("Subscapular skinfold-for-age z-score"),
                  hr(),
                  uiOutput(outputId = "ssaz")
                )
              ),
              column(width = 3,
                wellPanel(h5("Triceps skinfold-for-age z-score"),
                  hr(),
                  uiOutput(outputId = "tsaz")
                )
              )
            )
          ),
          tabPanel(title = "Cohort", value = 2,
            conditionalPanel("input.calculate2",
              ## z-scores table
              DT::dataTableOutput("zScoreTable")
            )
          )
        )
      )
    )
  ),
  tabPanel(title = "About", value = 2,
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
        <a id='HEAD1'></a><h3>zscorer: Weight-for-age, height-for-age, weight-for-height,
        BMI-for-age, head circumference-for-age, arm circumference-for-age, subscapular
        skinfold-for-age and triceps skinfold-for-age z-score calculator</h3>
        <br/>
        <p><code>zscorer</code> facilitates the calculation of <strong>z-scores</strong>
        (i.e. the number of standard deviations from the mean) and adds them to survey data:</p>

        <ul>
          <li><b>Weight-for-length (wfl)</b> z-scores for children with lengths between 45 and 110 cm

          <li><b>Weight-for-height (wfh)</b> z-scores for children with heights between 65 and 120 cm

          <li><b>Length-for-age (lfa)</b> z-scores for children aged less than 24 months

          <li><b>Height-for-age (hfa)</b> z-scores for children aged between 24 and 228 months

          <li><b>Weight-for-age (wfa)</b> z-scores for children aged between zero and 120 months

          <li><b>Body mass index-for-age (bfa)</b> z-scores for children aged between zero and 228 months

          <li><b>MUAC-for-age (mfa)</b> z-scores for children aged between 3 and 228 months

          <li><b>Triceps skinfold-for-age (tsa)</b> z-scores for children aged between 3 and 60 months

          <li><b>Sub-scapular skinfold-for-age (ssa)</b> z-scores for children aged between 3 and 60 months

          <li><b>Head circumference-for-age (hca)</b> z-scores for children aged between zero and 60 months
        </ul>

        <p>The <code>z-scores</code> are calculated using the <b>WHO Child Growth Standards</b> for
        children aged between zero and 60 months or the **WHO Growth References** for school-aged
        children and adolescents. MUAC-for-age (mfa) z-scores for children aged between 60 and 228
        months are calculated using the MUAC-for-age growth reference developed by Mramba et al. (2017)
        using data from the USA and Africa. This reference has been validated with African school-age
        children and adolescents. The <code>zscorer</code> comes packaged with the WHO Growth References
        data and the MUAC-for-age reference data.

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
        <code># install.packages('remotes')<br/>
        remotes::install_github('nutriverse/zscorer')<br/>
        # load package<br/>
        library(zscorer)</code>
        </blockquote>

        <p>or from CRAN with:</p>
        <blockquote>
        <code>install.packages('zscorer')<br/>
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
        enhance utility and functionality, has been written by Mark Myatt and
        Ernest Guevarra</p>
        <p>Ernest Guevarra has packaged these scripts into an R standard format
        and is the maintainer of this package</p>
        <p>The <code>zscorer</code> Shiny app built into the package was created
        and maintained by Ernest Guevarra</p>
        <br/>

        <a id='HEAD5'></a><h3>License</h3>
        <p>This package and the built in Shiny app is licensed under the AGPL-3
        License.</p>
        <br/>
      ")
    )
  )
)
