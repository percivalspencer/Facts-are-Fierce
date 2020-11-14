# Load libraries required for UI
library(shinythemes)
library(shinyWidgets)

# Define UI for application
navbarPage(title = "Facts are Fierce", id = "mainNav", theme = shinytheme("cyborg"),

           # Tab displaying queens from each season
           tabPanel("Meet the Queens", value = "tab1",
                    sidebarLayout(
                      sidebarPanel(
                        # Dropdown list with all available seasons
                        selectInput(inputId = "seasonTab1",
                                    label = "Season of Drag Race",
                                    choices = seasonNumbers,
                                    multiple = FALSE,
                                    selectize = TRUE),
                        # Button to refresh data
                        actionButton(inputId = "refreshTab1",
                                     label = "Refresh",
                                     icon = icon("refresh")),
                        # Button to download data
                        downloadButton(outputId = "downloadTab1",
                                     label = "Download Data"),
                      ),

                      mainPanel(
                        fluidRow(
                          # UI element which will be populated with pictures of queens
                          uiOutput("images")
                        )
                      )
                    )
           ),

           # Tab displaying challenges from each season
           tabPanel("Challenges", value = "tab2",
                    sidebarLayout(
                      sidebarPanel(
                        # Dropdown list with all available seasons
                        selectInput(inputId = "seasonTab2",
                                    label = "Season of Drag Race",
                                    choices = seasonNumbers,
                                    multiple = FALSE,
                                    selectize = TRUE),
                        # Buttons to display either a barchart or table
                        radioButtons(inputId = "outputTypeTab2",
                                     label = "Display format",
                                     choices = c("Barchart summarising challenges won" = "Plot",
                                                 "Table detailing challenge information" = "Table")),
                        # Switch for whether info about individual queens should be included
                        materialSwitch(inputId = "showQueensTab2",
                                       label = "Show queens in table",
                                       value = TRUE),
                        # Button to refresh data
                        actionButton(inputId = "refreshTab2",
                                     label = "Refresh",
                                     icon = icon("refresh")),
                        # Button to download data
                        downloadButton(outputId = "downloadTab2",
                                       label = "Download Data"),
                      ),

                      mainPanel(
                        useShinyjs(),
                        # Title of barchart or table
                        h4(textOutput("challengesOutTitle")),
                        plotOutput(outputId = "challengesPlot"),
                        dataTableOutput(outputId = "challengesTbl")
                      )
                    )
           ),

           # Tab displaying lipsyncs from each season
           tabPanel("Lipsyncs", value = "tab3",
                    sidebarLayout(
                      sidebarPanel(
                        # Dropdown list with all available seasons
                        selectInput(inputId = "seasonTab3",
                                    label = "Season of Drag Race",
                                    choices = seasonNumbers,
                                    multiple = FALSE,
                                    selectize = TRUE),
                        # Buttons to display either a barchart or table
                        radioButtons(inputId = "outputTypeTab3",
                                     label = "Display format",
                                     choices = c("Barchart summarising lipsyncs won" = "Plot",
                                                 "Table detailing lipsync information" = "Table")),
                        # Switch for whether info about individual queens should be included
                        materialSwitch(inputId = "showQueensTab3",
                                       label = "Show queens in table",
                                       value = TRUE),
                        # Button to refresh data
                        actionButton(inputId = "refreshTab3",
                                     label = "Refresh",
                                     icon = icon("refresh")),
                        # Button to download data
                        downloadButton(outputId = "downloadTab3",
                                       label = "Download Data"),
                      ),

                      mainPanel(
                        useShinyjs(),
                        # Title of barchart or table
                        h4(textOutput("lipsyncsOutTitle")),
                        plotOutput(outputId = "lipsyncsPlot"),
                        dataTableOutput(outputId = "lipsyncsTbl")
                      )
                    )
           ),

           # Include custom CSS formatting
           includeCSS("lewk.css")
)

