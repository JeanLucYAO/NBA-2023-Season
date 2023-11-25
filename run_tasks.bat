@echo off

REM Run the Python script
python "%USERPROFILE%\Documents\NBA-2023-Season\script.py" > "%USERPROFILE%\Documents\NBA-2023-Season\python_log.txt" 2>&1

REM locate in repository
cd /d "%USERPROFILE%\Documents\NBA-2023-Season"

REM Add all changes to git
git add .

REM Commit the changes
git commit -m "Automated commit for data document update"

REM Push the changes to GitHub
git push