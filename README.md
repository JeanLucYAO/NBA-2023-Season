# NBA-2023-Season
It's always good to know what is going on in the NBA once in a while. So I built a Shiny app to give some stats about the players.

## Structure
- [The python script](script.py) gets the data from the internet and save it to [Data](Data)
- [This R markdown](nba.Rmd) cleans and prepares the data, then saves it to [Clean](Clean)
- [This R markdown](data_cleaning.Rmd) uses the clean data and [helper functions](helpers.R) to build the shiny app
- [This Batch file](run_tasks.bat) automatically runs script.py and push the changes made to Data to Git Hub
- [This Batch file](deploy.bat) automatically deploys the shiny app [here](https://78luxg-jean0luc-yao.shinyapps.io/nba_stats/)

## Requirements
- **Python:** `requests_2.31.0`, `pandas_2.1.2`
- **R:** `dplyr_1.1.3`, `readr_2.1.4`, `shiny_1.7.5.1`, `flexdashboard_0.6.2`, `ggplot2_3.4.4`, `plotly_4.10.3`, `htmltools_0.5.6.1`

## Changes to come
- [x] Remove libraries that are unused
- [x] Add NBA logo to the header of the app
- [x] Add player picture and/or team picture
- [x] Fix `aes_string() was deprecated in ggplot2 3.0.0`
- [x] Update the Ranking bar graph with playoffs, play-in and eliminated
- [ ] Add a tab for team summary stat
- [ ] Add Verbose in sidebar to tell whether the player is a starter based on stats
- [ ] Fix [deploy Batch file](deploy.bat), it's not working well
- [ ] Create [a reprex](https://reprex.tidyverse.org/) and open an issue on Git Hub for `renderPlotly()` not being consistent
