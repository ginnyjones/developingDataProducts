library(shiny)
library(ggplot2)
shinyServer(function(input, output) {
  
## Subset the chickWeight dataset for the day selected      
    day.df <- reactive({
        day.selected <- input$sliderX
        ChickWeight[ChickWeight$Time == day.selected, c(4,1)]
    })

## Calculate the mean weight for each diet on the selected day        
    day.means <- reactive({
        with(day.df(), tapply(weight, Diet, mean))
    })

## Create a dataframe of the mean weights for plotting in plot1        
    means.df <- reactive({
        day.selected <- input$sliderX
        data.frame(weight = as.numeric(day.means()), Time = as.numeric(day.selected), Diet = as.factor(1:4))
    })
 
## Time series with means for day selected highlighted    
    output$plot1 <- renderPlot({
        ggplot(ChickWeight, aes(Time, weight, color = Diet)) +
           geom_point() + 
           geom_smooth() +
           geom_point(data = means.df(), size = 10)
    })

## Display the means for that day    
    output$means <- renderPrint({
        round(day.means(),1)
    })

## Box plots        
    output$plot2 <- renderPlot({
        ggplot(day.df(), aes(x=Diet, y=weight, color = Diet)) + geom_boxplot()
    })

    
    
  
## ANOVA analysis for selected day 
   anova.fit <- reactive({
       with(day.df(), aov(weight ~ Diet))
    })
    
    output$summary <- renderPrint({
        summary(anova.fit())
    })

## Corresponding Tuky            
    output$Tukey <- renderPrint({
        TukeyHSD(anova.fit(), conf.level = 0.95)
    })    
        
})