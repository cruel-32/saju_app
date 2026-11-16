@echo off
setlocal

cd /d "%~dp0"

set "DEVICE=%~1"
if "%DEVICE%"=="" set "DEVICE=windows"

if exist "C:\flutter\bin\flutter.bat" (
    set "FLUTTER=C:\flutter\bin\flutter.bat"
) else (
    set "FLUTTER=flutter"
)

echo [run.bat] Using "%FLUTTER%" on device "%DEVICE%"

call "%FLUTTER%" pub get
if errorlevel 1 goto :eof

call "%FLUTTER%" run -d %DEVICE%
