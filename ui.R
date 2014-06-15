library(shiny)

# Define UI for application that predicts Iris Species
shinyUI(fluidPage(

  # Application title
  titlePanel("Iris Species Predictor"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
        helpText("This web site helps you identify the specices of an Iris."),
        helpText("You enter the metrics of your specimen below, and the metrics will be compared to an Iris database to predice the species of your specimen."),
        helpText("The charts will show how your specimen compares to the reference Iris in the database."),
        helpText("Your specimen is marked with an X."),
        sliderInput("Sepal_Length", "Sepal length in cm:", round=FALSE, step=0.01,
                    min = 4.0,  # 4.3
                    max = 8.0,  # 7.9
                    value = 6),
        sliderInput("Sepal_Width", "Sepal width in cm:", round=FALSE, step=0.01,
                    min = 1.0,  # 2.0
                    max = 5.0,  # 4.4
                    value = 3),
        sliderInput("Petal_Length", "Petal length in cm:", round=FALSE, step=0.01,
                    min = 0.0,  # 1.0
                    max = 7.0,  # 6.9
                    value = 3.5),
        sliderInput("Petal_Width", "Petal width in cm:", round=FALSE, step=0.01,
                    min = 0.0,  # 0.1
                    max = 3.0,  # 2.5
                    value = 1.5),
        imageOutput("imagePetalSepal")
    ),

    # Show a plot of the generated distribution
    mainPanel(
        plotOutput("chartsPlots"),
        verbatimTextOutput("predictedSpecies")
    )
  )
))
