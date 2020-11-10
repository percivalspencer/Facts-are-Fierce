library(shiny)

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
