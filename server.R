library(shiny)

# Define server logic required for app
function(input, output, session) {

    isolate({updateNavbarPage(session, inputId = "mainNav", selected = "home")})

}
