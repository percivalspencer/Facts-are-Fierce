library(shinythemes)

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
                        actionButton(inputId = "downloadTab1",
                                     label = "Download Data",
                                     icon = icon("file-download"),
                                     width = NULL),
                      ),

                      mainPanel(
                        fluidRow(
                          uiOutput("images")
                        )
                      )
                    )
           )
)

