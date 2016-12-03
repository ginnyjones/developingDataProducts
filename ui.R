## This shiny app uses the ChickWeight dataset that comes with the R installation

library(shiny)
shinyUI(fluidPage(
    titlePanel("Weights (in gms) of chicks on 4 different diets from birth to 21 days old"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderX", "Chose a day", 0, 21, 0, step =2)
            
        ),
        mainPanel(
            tabsetPanel(type = "tabs", 
                        tabPanel("Time series",
                                 plotOutput("plot1"),
                                 h3("Mean Weight by Diet"),
                                 verbatimTextOutput("means")
                                 ), 
                        tabPanel("Box plots", plotOutput("plot2")), 
                        tabPanel("Statistical tests", 
                                 h3("ANOVA"),
                                 verbatimTextOutput("summary"),
                                 h3("Tukey HSD"),
                                 verbatimTextOutput("Tukey"))
            )
        )
    )
))