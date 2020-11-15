# Facts are Fierce

This app has been developed as part of a group project for a statistics module at the University of St Andrews in Scotland.

The inspiration for which comes from the legendary reality television competition [**RuPaul's Drag Race**](https://www.facebook.com/rupaulsdragrace/). Data from the show is displayed in the app using the sickening [**No Key No Shade** API](https://drag-race-api.readme.io/docs).

The published app is hosted at: <https://percivalspencer.shinyapps.io/facts-are-fierce/>

## Main features

_**Note that some of these features require javascript to be enabled.**_

Running the app will open the "Meet the Queens" tab where you are able to visually explore the queens from the available seasons and their placements in the competition. Queens are ranked in order of elimination (except in the case of disqualification, in which case those queens appear first). The sidebar on the left allows users to select the season they would like to explore, as well as to refresh or download the data being displayed.

Users can then navigate to either the "Challenges" or "Lipsyncs" tabs using the links on the navigation bar at the top of the page. These tabs allow users to see a barchart summarising the number of wins for each queen, or a descriptive table with more information about the challenges or lipsyncs which took place during a season. The preferred display format can be selected on the left sidebar, as can an option to include/exclude the information relating to individual queens in the tables. The tables also have options for ordering rows by columns, filtering columns by user input, and searching all entries in the dataset.

## File Structure

- ui.R - defines the user interface (UI) elements
- server.R - retrieves the data from the API and displays it in the UI elements
- global.R - loads libraries, and defines functions and variables which are needed in both ui.R and server.R
- lewk.css - provides custom styling
- README.md - (this file) describes the app
- DESCRIPTION - provides developer information and controls display mode
- www folder - stores custom font

## Licencing

References to all the resources used to produce this app are included in the project report available in the **private** repository on GitHub at: <https://github.com/csheehan10/MT5763_ProperJob>. Requests for access or for a copy of the references can be sent to <https://github.com/percivalspencer>. 

An extra special mention goes to iFonts where the [Aerokids Script font](https://ifonts.xyz/aerokids-script.html) which is used for the app name was obtained, and to [Online Font Converter](https://onlinefontconverter.com) which produced the necessary formats for it to be used.

The app is made available under the Modified BSD licence for personal use with or without modification.
