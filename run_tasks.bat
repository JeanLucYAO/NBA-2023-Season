@echo off

REM Run the Python script
python "%USERPROFILE%\Documents\NBA-2023-Season\script.py" > "%USERPROFILE%\Documents\NBA-2023-Season\python_log.txt" 2>&1

REM Now run the R script
SET "RSTUDIO_PANDOC=C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools"
R --vanilla -e "rmarkdown::render('C:\\Users\\DELL\\Documents\\NBA-2023-Season\\nba.Rmd')" > "%USERPROFILE%\Documents\NBA-2023-Season\R_log.txt" 2>&1

REM locate in repository
cd /d "%USERPROFILE%\Documents\NBA-2023-Season"

REM Add all changes to git
git add .

REM Commit the changes
git commit -m "Automated commit for data document update"

REM Push the changes to GitHub
git push

pause