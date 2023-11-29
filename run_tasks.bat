@echo off

REM Set the path to the log file.
set LOGFILE=python_log.txt

REM Get the current date and time to timestamp the log entry
for /f "tokens=2 delims==" %%i in ('wmic OS Get localdatetime /value') do set datetime=%%i
set datetime=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2% %datetime:~8,2%:%datetime:~10,2%:%datetime:~12,2%

REM Add a header to the log file with the current date and time
echo [Start Time: %datetime%] >> %LOGFILE%

REM Run the Python script
python "%USERPROFILE%\Documents\NBA-2023-Season\script.py" >> %LOGFILE% 2>&1

REM locate in repository
cd /d "%USERPROFILE%\Documents\NBA-2023-Season"

REM Add all changes to git
git add .

REM Remove some files
git rm --cached credentials.txt
git rm --cached -r rsconnect

REM Commit the changes
git commit -m "Automated commit for data document update"

REM Push the changes to GitHub
git push


echo [End Time: %datetime%] >> %LOGFILE%
echo. >> %LOGFILE%

echo Download finished.
echo Check the log file (%LOGFILE%) for details.