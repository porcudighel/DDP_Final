#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application using airquality data
shinyUI(fluidPage(

    # Application title
    titlePanel("Ozone prediction from regressors"),

    # Sidebar with checkboxes to chose regressors
    sidebarLayout(
        sidebarPanel(
          h4("Build your model!"),
          h5("Choose the regressors"),
          checkboxInput("solR_ch", "Solar radiation", value = TRUE),
          checkboxInput("wind_ch", "Wind speed", value = TRUE),
          checkboxInput("temp_ch", "Temperature", value = TRUE),
          submitButton("Submit"),
          h4("Documentation"),
          h5("This app aims at showing how inclusion and exclusion of regressors 
             impacts the final prediction, making use of the dataset airquality."),
          h5("Under *Build your model!* tick one or more of the checkboxes. 
             When you are satisfied with the selection, press the button *Submit*.
             On the main panel on the results from the built model are displayed.")
        ),

        # Results
        mainPanel(
          h4("Built model"),
          textOutput("ModelFormula"),
          h4("Plot of original and predicted values"),
          plotOutput("ModelPlot"),
          h4("Resulting R squared"),
          textOutput("Rsq"),
          h4("Model's coefficients"),
          # fluidRow(column(5,
                   tableOutput('ModelCoeff')
            #   )
            # )
        )
        
    )
))
