@echo off
setlocal enabledelayedexpansion

echo ===============================
echo   Windows Service Editor Tool
echo ===============================

:: Ask for service name
set /p svcName=Enter the SERVICE NAME (not display name):

:: Check if service exists
sc query "%svcName%" >nul 2>&1
if %errorlevel% neq 0 (
echo.
echo  Service "%svcName%" not found!
pause
exit /b
)

:menu
echo.
echo What do you want to change?
echo 1. Change Display Name
echo 2. Change Description
echo 3. Change Both
echo 4. Exit
set /p choice=Enter choice (1-4):

if "%choice%"=="1" goto changeDisplay
if "%choice%"=="2" goto changeDesc
if "%choice%"=="3" goto changeBoth
if "%choice%"=="4" exit /b

echo Invalid choice!
goto menu

:changeDisplay
set /p newDisplay=Enter NEW Display Name:
sc config "%svcName%" DisplayName= "%newDisplay%"
echo Display Name updated.
goto end

:changeDesc
set /p newDesc=Enter NEW Description:
sc description "%svcName%" "%newDesc%"
echo Description updated.
goto end

:changeBoth
set /p newDisplay=Enter NEW Display Name:
set /p newDesc=Enter NEW Description:

sc config "%svcName%" DisplayName= "%newDisplay%"
sc description "%svcName%" "%newDesc%"

echo Display Name and Description updated.
goto end

:end
echo.
echo Restarting service to reflect changes...
net stop "%svcName%" >nul 2>&1
net start "%svcName%" >nul 2>&1

echo Done.
pause
