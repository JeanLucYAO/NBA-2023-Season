@echo off
REM Batch script to deploy Shiny App to shinyapps.io

REM Get credentials file
set CREDENTIALS_FILE=credentials.txt

REM Set the path to the log file.
set LOGFILE=R_log.txt

REM Check if credentials file exists
if not exist "%CREDENTIALS_FILE%" (
    echo Credentials file not found >> %LOGFILE%
    exit /b
)

REM Load credentials into environment variables
for /f "delims=" %%i in (%CREDENTIALS_FILE%) do set %%i

REM Set the path to RScript executable
set RSCRIPT="C:\Program Files\R\R-4.3.1\bin\Rscript.exe"

REM Set the path to the directory of your R application
set APPDIR=C:\\Users\\DELL\\Documents\\NBA-2023-Season

REM Define the name of your application as deployed on shinyapps.io
set APP_NAME=nba_stats

REM Get the current date and time to timestamp the log entry
for /f "tokens=2 delims==" %%i in ('wmic OS Get localdatetime /value') do set datetime=%%i
set datetime=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2% %datetime:~8,2%:%datetime:~10,2%:%datetime:~12,2%

REM Add a header to the log file with the current date and time
echo [Deployment Start Time: %datetime%] >> %LOGFILE%

REM Deploy the app using Rscript and rsconnect, and append the output to the log file
%RSCRIPT% -e "rsconnect::setAccountInfo(name='%ACCOUNT_NAME%', token='%TOKEN%', secret='%SECRET%');rsconnect::deployApp(appName='%APP_NAME%', appDir='%APPDIR%')" >> %LOGFILE% 2>&1

echo [Deployment End Time: %datetime%] >> %LOGFILE%
echo. >> %LOGFILE%

echo Deployment script finished.
echo Check the log file (%LOGFILE%) for details.