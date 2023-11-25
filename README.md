# NBA-2023-Season
It's always good to know what is going on in the NBA once in a while. So I built a Shiny app to give some stats about the players.

## Structure
- [The python script](script.py) gets the data from the internet and save it to [Data](Data)
- [The R markdown](nba.Rmd) builds the shiny app using flexdashboard
- [The run Bash script](run_tasks.bat) automatically runs script.py and push the changes made to Data to Git Hub
- [The deploy Bash script](deploy.bat) automatically update the shiny app [here](https://78luxg-jean0luc-yao.shinyapps.io/nba_stats/)