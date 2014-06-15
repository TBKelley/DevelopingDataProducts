library(shiny)
library(lattice)
library(ggplot2)
library(grid)
library(gridExtra)
library(caret)
library(rpart)
library(e1071)
data(iris)

modFit <- train(Species ~ ., method="rpart", data=iris)
irisP <- data.frame(Sepal.Length=numeric(1), Sepal.Width=numeric(1), Petal.Length=numeric(1), Petal.Width=numeric(1), Species=character(1), stringsAsFactors=TRUE)

# Define server logic required to predict an Iris's Species
shinyServer(function(input, output) {

  # Predict Iris's Species from input slide bar settings
  # The prediction and plot will happen in real-time.
    
    output$chartsPlots <- renderPlot({
        irisP$Sepal.Length <- input$Sepal_Length
        irisP$Sepal.Width <- input$Sepal_Width
        irisP$Petal.Length <- input$Petal_Length
        irisP$Petal.Width <- input$Petal_Width
        irisP$Species <- predict(modFit, irisP)
        
        output$predictedSpecies <- renderPrint({ paste("Predicted species:", irisP$Species) })
        
        p1 <- qplot(Sepal.Width, Sepal.Length, col=Species, data=iris, xlab="Sepal width (cm)", ylab="Sepal length (cm)")
        p1 <- p1 + ggtitle("Sepal Length vs Width - X makes your sample")
        p1 <- p1 + geom_point(aes(x=Sepal.Width, y=Sepal.Length, col=Species), size=5, shape=4, data=irisP)
          
        p2 <- qplot(Petal.Width, Petal.Length, col=Species,data=iris, xlab="Petal width (cm)", ylab="Petal length (cm)")
        p2 <- p2 + ggtitle("Petal Length vs Width - X makes your sample")
        p2 <- p2 + geom_point(aes(x=Petal.Width, y=Petal.Length, col=Species), size=5, shape=4, data=irisP)
          
        p <- grid.arrange(p1, p2, nrow = 2)
        print(p)
    })

    output$imagePetalSepal <-  renderImage({
        filename <- "./images/PetalSepal.png"
        list(src = filename)
    }, deleteFile = FALSE)
    
})