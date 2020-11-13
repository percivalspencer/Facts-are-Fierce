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
