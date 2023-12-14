# NBA-2023-Season
It's always good to know what is going on in the NBA once in a while. So I built a Shiny app to give some stats about the players.

## Structure
- [The python script](script.py) gets the data from the internet and save it to [Data](Data)
- [This R markdown](nba.Rmd) cleans and prepares the data, then saves it to [Clean](Clean)
- [This R markdown](data_cleaning.Rmd) uses the clean data to build the shiny app
- [This Batch file](run_tasks.bat) automatically runs script.py and push the changes made to Data to Git Hub
- [This Batch file](deploy.bat) automatically deploys the shiny app [here](https://78luxg-jean0luc-yao.shinyapps.io/nba_stats/)

## Changes to come
- [x] Remove libraries that are unused
- [x] Add NBA logo to the header of the app
- [x] Add player picture and/or team picture
- [x] Fix `aes_string() was deprecated in ggplot2 3.0.0`
- [ ] Update the Ranking bar graph with playoff, play-in and out
- [ ] Add Verbose in sidebar to tell whether the player is a starter based on stats
- [ ] Fix [deploy Batch file](deploy.bat), it's not working well
