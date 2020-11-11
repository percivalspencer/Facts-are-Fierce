# Define server logic required for app
function(input, output, session) {

  isolate({updateNavbarPage(session, inputId = "mainNav", selected = "tab1")})

  # Code for first tab (Meet the Queens)
  observeEvent(c(input$seasonTab1, input$refreshTab1), {
    # Get data for selected season
    data <- getData(paste0("seasons/", input$seasonTab1, "/queens"))

    output$images <- renderUI({
      # Create a list of images to display in UI output
      image_output_list <- lapply(1:dim(data)[1], function(i) {
        # Set column width to 4 (max 12) so that 3 images are displayed in a row
        column(width = 4,
               # capture.output prevents variable data from randomly displaying in UI
               # Set default figure style elements
               capture.output(style <- "border: 2px solid #e83e8c;
                              padding: 31px 0px 5px 0px; "),
               # Set information for how queen placed in competition
               capture.output(place <- " "),
               # Label Winner of season and add green border
               if (data$winner[i]) {
                 style <- "border: 4px solid green; color: green; "
                 capture.output(place <- "Winner")
               } # Label Miss Congeniality of season and add yellow border
               else if (data$missCongeniality[i]) {
                 style <- "border: 4px solid yellow; color: yellow; "
                 capture.output(place <- "Miss Congeniality")
               },
               # Compose figure
               tags$figure(style = paste0(style, "text-align: center;
                                          float: center;
                                          margin: 5px 5px 5px 5px"),
                           tags$h5(place),
                           tags$img(src = data[i,"image_url"],
                                    width = 190, height = 350,
                                    alt = data[i, "name"],
                                    align = "center"),
                           tags$figcaption(tags$h5(data[i, "name"]))
               ),
        )
      })
    })
  })
}
