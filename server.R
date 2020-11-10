# Define server logic required for app
function(input, output, session) {

  isolate({updateNavbarPage(session, inputId = "mainNav", selected = "tab1")})

  # Code for first tab (Meet the Queens)
  observeEvent(c(input$seasonTab1, input$refreshTab1), {

  })

}
