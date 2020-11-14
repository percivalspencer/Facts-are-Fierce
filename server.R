# Define server logic required for app
function(input, output, session) {

  # Set a timer to refresh the app data every hour
  autoInvalidate <- reactiveTimer(3600000)

  # Make data being displayed available to all server functions
  tab1data <- NULL
  tab2data <- NULL
  tab3data <- NULL

  # Code for first tab (Meet the Queens)
  observeEvent(c(input$seasonTab1, input$refreshTab1, autoInvalidate()), {
    # Get data for selected season
    tab1data <<- getData(paste0("seasons/", input$seasonTab1, "/queens"))

    # Display error for season data that is unavailable
    if (length(tab1data) <= 1 | class(tab1data) == "list") {
      output$images <- renderUI({tags$h2("The data you requested is not available from the No Key No Shade API for this season yet")})
    }
    else {
      # Unpack placing information and rank queens
      tab1data <<- tab1data %>%
        unnest(cols = c(seasons), names_sep = "_") %>%
        filter(seasons_id == input$seasonTab1) %>%
        arrange(seasons_place)

      output$images <- renderUI({
        # Create a list of images to display in UI output
        image_output_list <- lapply(1:dim(tab1data)[1], function(i) {
          # Set column width to 4 (max 12) so that 3 images are displayed in a row
          column(width = 4,
                 # capture.output prevents variable data from randomly displaying in UI
                 # Set default figure style elements
                 capture.output(style <- "border: 2px solid #e83e8c;
                              padding: 2px 0px 2px 0px; "),
                 # Set information for how queen placed in competition
                 capture.output(place <- tab1data$seasons_place[i]),
                 # Label Winner of season and add green border
                 if (tab1data$winner[i]) {
                   style <- "border: 4px solid green; color: green; "
                   capture.output(place <- "Winner")
                 } # Label Miss Congeniality of season and add yellow border
                 else if (tab1data$missCongeniality[i]) {
                   style <- "border: 4px solid yellow; color: yellow; "
                   capture.output(place <- "Miss Congeniality")
                 } # Label Disqualified queens of season and add brown border
                 else if (tab1data$seasons_place[i] == 0) {
                   style <- "border: 4px solid brown; color: brown; "
                   capture.output(place <- "Disqualified")
                 },
                 # Compose figure
                 tags$figure(style = paste0(style, "text-align: center;
                                          float: center;
                                          margin: 5px 5px 5px 5px"),
                             tags$h5(place),
                             tags$img(src = tab1data[i,"image_url"],
                                      width = 190, height = 280,
                                      alt = tab1data[i, "name"],
                                      align = "center"),
                             tags$figcaption(tags$h5(tab1data[i, "name"]))
                 ),
          )
        })
      })
    }
  })

  # Code to download data for first tab (Meet the Queens) in csv format
  output$downloadTab1 <- downloadHandler(
    filename = function() {
      paste0("Queens of season ", getSeasonName(input$seasonTab1), ".csv")
    },
    content = function(file) {
      write.csv2(tab1data, file)
    }
  )

  # Code for second tab (Challenges)
  observeEvent(c(input$seasonTab2, input$outputTypeTab2, input$showQueensTab2,
                 input$refreshTab2, autoInvalidate()), {
     # Get data for selected season
    tab2data <<- getData(paste0("seasons/", input$seasonTab2, "/challenges"))

     # Display error for season data that is unavailable
     if (length(tab2data) <= 1 | class(tab2data) == "list") {
       output$challengesOutTitle <- renderText("The data you requested is not available from the No Key No Shade API for this season yet")
       hide("challengesPlot")
       hide("challengesTbl")
     }
    else {
       if (input$outputTypeTab2 == "Plot") {
         hide("challengesTbl")

         # Summarise challenge wins per queen and rank accordingly
         tab2data <<- tab2data %>%
           unnest(cols = c(queens), names_sep = "_") %>%
           group_by(Queen = queens_name) %>%
           summarise(Wins = sum(queens_won), .groups = "rowwise") %>%
           arrange(desc(Wins))

         output$challengesOutTitle <- renderText(paste0("Barchart summarising the total number of challenges won by each queen\n in ", getSeasonName(input$seasonTab2, TRUE)))
         output$challengesPlot <- renderPlot({
           ggplot(tab2data, mapping = aes(x = Queen, y = Wins, fill = Queen)) +
             geom_bar(stat = "identity", show.legend = FALSE) +
             coord_flip()
         })
         show("challengesPlot")
       }
       else if (input$outputTypeTab2 == "Table") {
         hide("challengesPlot")

         # Remove challenge ID, rename columns, and move episode ID to beginning
         tab2data <<- tab2data %>%
           select(!id) %>%
           rename(`Episode ID` = episodeId, `Challenge Type` = type,
                  Description = description, Prize = prize) %>%
           relocate(`Episode ID`)

         # Show information for specific queens if selected
         if (input$showQueensTab2) {
           # Unpack winning information for queens and remove unnecessary ID
           tab2data <<- tab2data %>%
             unnest(cols = c(queens), names_sep = "_") %>%
             select(!queens_id) %>%
             rename(`Queen Name` = queens_name, `Queen Won` = queens_won)
         }
         else {
           # Remove queen data from table
           tab2data <<- tab2data %>%
             select(!queens)
         }

         output$challengesOutTitle <- renderText(paste0("Table showing details of challenges from ",
                                                        getSeasonName(input$seasonTab2, TRUE)))
         output$challengesTbl <- renderDataTable(tab2data)
         show("challengesTbl")
       }
     }

   })

  # Code to download data for second tab (Challenges) in csv format
  output$downloadTab2 <- downloadHandler(
    filename = function() {
      if (input$outputTypeTab2 == "Plot") {
        paste0("Num challenges won by queens in season ",
               getSeasonName(input$seasonTab2), ".csv")
      }
      else if (input$outputTypeTab2 == "Table") {
        paste0("Challenge details from season ",
               getSeasonName(input$seasonTab2), ".csv")
      }
    },
    content = function(file) {
      write.csv2(tab2data, file)
    }
  )

  # Code for third tab (Lipsyncs)
  observeEvent(c(input$seasonTab3, input$outputTypeTab3, input$showQueensTab3,
                 input$refreshTab3, autoInvalidate()), {
     # Get data for selected season
     tab3data <<- getData(paste0("seasons/", input$seasonTab3, "/lipsyncs"))

     # Display error for season data that is unavailable
     if (length(tab3data) <= 1 | class(tab3data) == "list") {
       output$lipsyncsOutTitle <- renderText("The data you requested is not available from the No Key No Shade API for this season yet")
       hide("lipsyncsPlot")
       hide("lipsyncsTbl")
     }
     else {
       if (input$outputTypeTab3 == "Plot") {
         hide("lipsyncsTbl")

         # Summarise lipsync wins per queen and rank accordingly
         tab3data <<- tab3data %>%
           unnest(cols = c(queens), names_sep = "_") %>%
           group_by(Queen = queens_name) %>%
           summarise(Wins = sum(queens_won), .groups = "rowwise") %>%
           arrange(desc(Wins))

         output$lipsyncsOutTitle <- renderText(paste0("Barchart summarising the total number of lipsyncs won by each queen\n in ", getSeasonName(input$seasonTab3, TRUE)))
         output$lipsyncsPlot <- renderPlot({
           ggplot(tab3data, mapping = aes(x = Queen, y = Wins, fill = Queen)) +
             geom_bar(stat = "identity", show.legend = FALSE) +
             coord_flip()
         })
         show("lipsyncsPlot")
       }
       else if (input$outputTypeTab3 == "Table") {
         hide("lipsyncsPlot")

         # Remove lipsync ID, rename columns, and move episode ID to beginning
         tab3data <<- tab3data %>%
           select(!id) %>%
           rename(`Episode ID` = episodeId, `Song` = name,
                  Artist = artist) %>%
           relocate(`Episode ID`)

         # Show information for specific queens if selected
         if (input$showQueensTab3) {
           # Unpack winning information for queens and remove unnecessary ID
           tab3data <<- tab3data %>%
             unnest(cols = c(queens), names_sep = "_") %>%
             select(!queens_id) %>%
             rename(`Queen Name` = queens_name, `Queen Won` = queens_won)
         }
         else {
           # Remove queen data from table
           tab3data <<- tab3data %>%
             select(!queens)
         }

         output$lipsyncsOutTitle <- renderText(paste0("Table showing details of lipsyncs from ",
                                                        getSeasonName(input$seasonTab3, TRUE)))
         output$lipsyncsTbl <- renderDataTable(tab3data)
         show("lipsyncsTbl")
       }
     }

    })

  # Code to download data for third tab (Lipsyncs) in csv format
  output$downloadTab3 <- downloadHandler(
    filename = function() {
      if (input$outputTypeTab3 == "Plot") {
        paste0("Num lipsyncs won by queens in season ",
               getSeasonName(input$seasonTab3), ".csv")
      }
      else if (input$outputTypeTab3 == "Table") {
        paste0("Lipsync details from season ",
               getSeasonName(input$seasonTab3), ".csv")
      }
    },
    content = function(file) {
      write.csv2(tab3data, file)
    }
  )

  updateNavbarPage(session, inputId = "mainNav", selected = "tab1")
}
