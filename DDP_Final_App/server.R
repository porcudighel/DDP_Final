#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to plot and model the ozone relationship with the regressors
shinyServer(function(input, output) {
  
  # Deal with inputs and fit the model
  final_formula <- reactive({
    # Set a check to deal with no inputs without errors appearing
    req(isTruthy(input$solR_ch) || 
          isTruthy(input$temp_ch) || 
          isTruthy(input$wind_ch)
      )
    # build the formula to pass to lm
    params <- NULL
    if (input$solR_ch){params <- c(params,"Solar.R")}
    if (input$temp_ch){params <- c(params,"Temp")}
    if (input$wind_ch){params <- c(params,"Wind")}
    form_mod <- paste0("Ozone ~ ",paste(params, collapse = " + "))
    # fit
    model <- lm(form_mod, data = airquality)
    pred_data <- predict(model, airquality)
    # pass as a list the formula, model and predicted data
    list(form_mod, model, pred_data)
    })

  # output the formula as text
  output$ModelFormula <- renderText({
    final_formula()[[1]]
  })

  # output the plot of both original and predicted data
  output$ModelPlot <- renderPlot({
    with(airquality, plot(Solar.R, Ozone, col = "blue", lwd =2,
                          xlab = "Solar radiation", ylab = "Ozone"))
    with(airquality, points(Solar.R, final_formula()[[3]], col = "red", lwd =2))
    legend("topleft", c("Original", "Predicted"), pch = 16, 
    col = c("blue", "red"), cex = 1.2)
  })

  # output the coefficients in a table
  output$ModelCoeff <- renderTable({
      coeff_tab <- summary(final_formula()[[2]])$coefficients
      colnames(coeff_tab)[2] <- "Std. Er."
      colnames(coeff_tab)[3] <- "t val."
      coeff_tab
    },
    digits = 5,
    rownames = TRUE,
    bordered = TRUE
    )
  
  # output the R squared
  output$Rsq <- renderText({
      round(summary(final_formula()[[2]])$r.squared,5)
  })
  
})
