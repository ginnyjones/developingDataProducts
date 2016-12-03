## This shiny app uses the ChickWeight dataset that comes with the R installation

library(shiny)
shinyUI(fluidPage(
    titlePanel("Weights (in gms) of chicks on 4 different diets from birth to 21 days old"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderX", "Select a day", 0, 21, 0, step =2),
            h3("How to use this app"),
            "In order to use this app, select a day using the slider above. For any day selected, data about that day is available by clicking on each of the 3 tabs in the main panel.",
            br(),
            br(),
            "1. The Time Series tab shows the weights of chicks over the 21 day period from birth, and the mean weights for each of four protein diets.",
            br(),
            "2. The Box Plots tab allows comparison between each of the four diets on the selected day.",
            br(),
            "3. The Statistical Tests tab shows the results of a one-way ANOVA and asssociated Tukey HSD.",
           br(),
           br(),
           "By moving the slider and clicking on the different tabs you can explore the differences between the four diets at different points in time and whether these differences are statistically significant."
        ),
        mainPanel(
            tabsetPanel(type = "tabs", 
                        tabPanel("Time Series",
                                 plotOutput("plot1"),
                                 h3("Mean Weight by Diet"),
                                 verbatimTextOutput("means")
                                 ), 
                        tabPanel("Box Plots", plotOutput("plot2")), 
                        tabPanel("Statistical Tests", 
                                 h3("ANOVA"),
                                 verbatimTextOutput("summary"),
                                 h3("Tukey HSD"),
                                 verbatimTextOutput("Tukey"))
            )
        )
    )
))