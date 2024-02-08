library(shiny)
library(ggplot2)

server <- function(input, output, session) {
  data(diamonds)
  model <- reactive({
    if (input$show_model) {
      lm(price ~ carat, data = diamonds)
    } else {
      NULL
    }
  })
  
  model_pred <- reactive({
    if (!is.null(model())) {
      predict(model(), newdata = data.frame(carat = input$slider_carats))
    } else {
      NA
    }
  })
  
  output$lm_plot <- renderPlot({
    plot(diamonds$carat, diamonds$price, xlab = "Carats", ylab = "Price")
    if (!is.null(model())) {
      abline(model(), col = "red", lwd = 3)
      legend(25, 250, c("Model Prediction"), pch = 16, 
             col = c("blue"), bty = "n", cex = 1.2)
      points(input$slider_carats, model_pred(), col = "blue", pch = 16, cex = 2)
    }
  })
  
  output$prediction <- renderText({
    if (!is.null(model())) {
      paste("Predicted price:", round(model_pred(), 2))
    } else {
      "Model is hidden"
    }
  })
}