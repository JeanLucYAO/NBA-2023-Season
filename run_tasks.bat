@echo off
REM Run the Python script
python "%USERPROFILE%\Documents\NBA-2023-Season\script.py"
REM Now run the R script
SET "RSTUDIO_PANDOC=C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools"
R --vanilla -e "rmarkdown::render('C:\\Users\\DELL\\Documents\\NBA-2023-Season\\nba.Rmd')" 
pause