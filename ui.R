# Load libraries required for UI
library(shinythemes)
library(shinyWidgets)

# Define UI for application
navbarPage(title = "Facts are Fierce", id = "mainNav", theme = shinytheme("cyborg"),
           # Include custom CSS formatting
           includeCSS("lewk.css"),

           tabPanel("Meet the Queens", value = "tab1",
                    sidebarLayout(
                      sidebarPanel(
                        selectInput(inputId = "seasonTab1",
                                    label = "Season of Drag Race",
                                    choices = seasonNumbers,
                                    multiple = FALSE,
                                    selectize = TRUE,
                                    width = NULL,
                                    size = NULL),
                        actionButton(inputId = "refreshTab1",
                                     label = "Refresh",
                                     icon = icon("refresh"),
                                     width = NULL),
                        downloadButton(outputId = "downloadTab1",
                                     label = "Download Data",
                                     width = NULL),
                      ),

                      mainPanel(
                        fluidRow(
                          uiOutput("images")
                        )
                      )
                    )
           ),

           tabPanel("Challenges", value = "tab2",
                    sidebarLayout(
                      sidebarPanel(
                        selectInput(inputId = "seasonTab2",
                                    label = "Season of Drag Race",
                                    choices = seasonNumbers,
                                    multiple = FALSE,
                                    selectize = TRUE,
                                    width = NULL,
                                    size = NULL),
                        radioButtons(inputId = "outputTypeTab2",
                                     label = "Display format",
                                     choices = c("Barchart summarising challenges won" = "Plot",
                                                 "Table detailing challenge information" = "Table")),
                        materialSwitch(inputId = "showQueensTab2",
                                       label = "Show queens in table",
                                       value = TRUE),
                        actionButton(inputId = "refreshTab2",
                                     label = "Refresh",
                                     icon = icon("refresh"),
                                     width = NULL),
                        downloadButton(outputId = "downloadTab2",
                                       label = "Download Data",
                                       width = NULL),
                      ),

                      mainPanel(
                        useShinyjs(),
                        h4(textOutput("challengesOutTitle")),
                        plotOutput(outputId = "challengesPlot"),
                        dataTableOutput(outputId = "challengesTbl")
                      )
                    )
           ),

           tabPanel("Lipsyncs", value = "tab3",
                    sidebarLayout(
                      sidebarPanel(
                        selectInput(inputId = "seasonTab3",
                                    label = "Season of Drag Race",
                                    choices = seasonNumbers,
                                    multiple = FALSE,
                                    selectize = TRUE,
                                    width = NULL,
                                    size = NULL),
                        radioButtons(inputId = "outputTypeTab3",
                                     label = "Display format",
                                     choices = c("Barchart summarising lipsyncs won" = "Plot",
                                                 "Table detailing lipsync information" = "Table")),
                        materialSwitch(inputId = "showQueensTab3",
                                       label = "Show queens in table",
                                       value = TRUE),
                        actionButton(inputId = "refreshTab3",
                                     label = "Refresh",
                                     icon = icon("refresh"),
                                     width = NULL),
                        downloadButton(outputId = "downloadTab3",
                                       label = "Download Data",
                                       width = NULL),
                      ),

                      mainPanel(
                        useShinyjs(),
                        h4(textOutput("lipsyncsOutTitle")),
                        plotOutput(outputId = "lipsyncsPlot"),
                        dataTableOutput(outputId = "lipsyncsTbl")
                      )
                    )
           )
)

