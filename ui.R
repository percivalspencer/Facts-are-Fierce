library(shinythemes)

# Define UI for application
navbarPage(title = "Facts are Fierce", id = "mainNav", theme = shinytheme("cyborg"),

           includeCSS("lewk.css"),

           tabPanel("Meet the Queens", value = "tab1",
                    # Sidebar with a slider input for number of bins
                    sidebarLayout(
                        sidebarPanel(
                            selectInput(inputId = "seasonTab1",
                                           label = "Season of Drag Race",
                                           choices = seasonNumbers,
                                           multiple = FALSE,
                                           selectize = TRUE,
                                           width = NULL,
                                           size = NULL),
                            actionButton(inputId = "refreshTab1", label = "Refresh", icon = icon("refresh"), width = NULL)
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

