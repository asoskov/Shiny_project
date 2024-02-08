library(shiny)

ui <- fluidPage(
  titlePanel("Prediction of Diamond's price"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("slider_carats",
                  "What is the carat of a diamond?",
                  min = 0,
                  max = 10,
                  value = 0.5,
                  step = 0.1),
      checkboxInput("show_model", "Show / Hide Model", value = TRUE)
    ),
    mainPanel(
      plotOutput("lm_plot"),
      h3("Predicted Diamond Price from our Model:"),
      textOutput("prediction")
    )
  )
)