library(shinythemes)
library(shiny)

# Define UI for application
navbarPage(title = "Facts are Fierce", id = "mainNav", theme = shinytheme("cyborg"),

           includeCSS("lewk.css"),

           tabPanel("Meet the Queens", value = "home",
                    # Sidebar with a slider input for number of bins
                    sidebarLayout(
                        sidebarPanel(
                            varSelectInput(inputId = "season",
                                           label = "Season of Drag Race",
                                           data = mtcars$cyl,
                                           multiple = FALSE,
                                           selectize = TRUE,
                                           width = NULL,
                                           size = NULL
                            ),
                            actionButton(inputId = "refresh", label = "Refresh", icon = icon("refresh"), width = NULL)
                        ),

                        # Show a plot of the generated distribution
                        mainPanel(
                            imageOutput(
                                outputId = "queen1",
                                width = "100%",
                                height = "400px",
                                click = NULL,
                                dblclick = NULL,
                                hover = NULL,
                                brush = NULL,
                                inline = FALSE
                            )
                        )
                    )
           )
)

