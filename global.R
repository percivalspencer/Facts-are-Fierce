# Load required global libraries
library(shiny)
library(shinyjs)
library(tidyverse)

# Function requesting data from API and returning response as a data frame
getData <- function(infoRequested) {
  # Load required libraries
  library(httr)
  library(jsonlite)

  # API call
  URL <- paste0("http://www.nokeynoshade.party/api/", infoRequested)

  # Send http request
  response <- httr::GET(URL)

  # Read / unpack a binary file
  dataJSON <- readBin(response$content, "text")

  # Parse JSON file
  data <- jsonlite::fromJSON(dataJSON)

  return(data)
}

# Gather numbers of all available seasons and sort them
seasonNumbers <- getData("seasons") %>%
  select(seasonNumber, id) %>%
  arrange(as.numeric(seasonNumber), seasonNumber) %>%
  pivot_wider(names_from = seasonNumber, values_from = id)

# Function which takes in season IDs and returns the corresponding names
# *** Relies on seasonNumbers dataset above to do conversion ***
getSeasonName <- function(seasonIDs, getFullName = FALSE) {
  # Check `seasonIDs` variable is present
  stopifnot(!missing(seasonIDs))
  # Check `seasonIDs` is a character vector
  stopifnot(is.character(seasonIDs))
  # Check `getFullName` is logical
  stopifnot(is.logical(getFullName))

  # Return longer season names
  if(getFullName) {
      sapply(seasonIDs, function(x) {
        seasonName <- names(seasonNumbers)[which(
          seasonNumbers == x, arr.ind = TRUE)[,"col"]]

        # Split All Stars from regular seasons
        if (startsWith(seasonName, "A")) {
          return(paste0("Season ", substring(seasonName, first = 2),
                        " of RuPaul's Drag Race (All Stars)"))
        }
        else {
          return(paste0("Season ", seasonName,
                        " of RuPaul's Drag Race"))
        }
      })
  } # Return shorter season names
  else {
    sapply(seasonIDs, function(x) {
      seasonName <- names(seasonNumbers)[which(
        seasonNumbers == x, arr.ind = TRUE)[,"col"]]

      # Split All Stars from regular seasons
      if (startsWith(seasonName, "A")) {
        return(paste0(substring(seasonName, first = 2), " (All Stars)"))
      }
      else {
        return(seasonName)
      }
    })
  }
}
