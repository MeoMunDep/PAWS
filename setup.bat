@echo off
title PAWS Bot by @MeoMunDep
color 0A

cd ..
if exist node_modules (
    echo Found node_modules in parent directory
    cd %~dp0
) else (
    cd %~dp0
    echo node_modules not found in parent directory
)

:MENU
cls
echo =================================================================
echo    PAWS BOT SETUP AND RUN SCRIPT by @MeoMunDep
echo =================================================================
echo.
echo Current directory: %CD%
echo Parent node_modules: %~dp0..\node_modules
echo.
echo 1. Install/Update Node.js Dependencies
echo 2. Create/Edit Configuration Files
echo 3. Run the Bot
echo 4. Exit
echo.
set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" goto INSTALL
if "%choice%"=="2" goto CONFIG
if "%choice%"=="3" goto RUN
if "%choice%"=="4" goto EXIT

:INSTALL
cls
echo Checking node_modules location...
if exist "..\node_modules" (
    cd ..
    echo Installing/Updating dependencies in parent directory...
    npm install user-agents axios colors p-limit https-proxy-agent socks-proxy-agent crypto-js ws uuid xlsx readline-sync
    cd %~dp0
) else (
    echo Installing dependencies in current directory...
    npm install user-agents axios colors p-limit https-proxy-agent socks-proxy-agent crypto-js ws uuid xlsx readline-sync
)
echo.
echo Dependencies installation completed!
pause
goto MENU

:CONFIG
cls
echo Creating configuration files...

if not exist datas.txt (
    type nul > datas.txt
    echo Created datas.txt
)

if not exist proxies.txt (
    type nul > proxies.txt
    echo Created proxies.txt
)

echo.
echo Configuration files have been created/checked.
echo Please edit the files with your data before running the bot.
echo.
pause
goto MENU

:RUN
cls
echo Starting the bot...
if exist "..\node_modules" (
    echo Using node_modules from parent directory
) else (
    echo Using node_modules from current directory
)
node meomundep

pause
goto MENU

:EXIT
exit
