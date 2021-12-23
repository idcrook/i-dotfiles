@echo off  
Echo Install some tools  
REM OpenSCAD  
winget install OpenSCAD.OpenSCAD
if %ERRORLEVEL% EQU 0 Echo OpenSCAD installed successfully.  
REM GitHub Desktop  
winget install GitHub.GitHubDesktop
if %ERRORLEVEL% EQU 0 Echo GitHub Desktop installed successfully.   %ERRORLEVEL%

