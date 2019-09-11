@echo off

REM build

set SRC_DIR=%~dp0
set BUILD_DIR=%~dp0\build-pysideqwt
set PKG_DIR=%~dp0\package
if x%1==xdebug goto SET_DEBUG
if x%1==xDebug goto SET_DEBUG
if x%1==xDEBUG goto SET_DEBUG
set CONFIGURATION=Release
goto :FINISH_SET_CONFIGURATION
:SET_DEBUG
set CONFIGURATION=Debug
:FINISH_SET_CONFIGURATION

REM Find JOM if it's available
set MAKE=nmake
for %%X in (jom.exe) do (set FOUND=%%~$PATH:X)
if defined FOUND set MAKE=jom

rm -rf %BUILD_DIR%
mkdir %BUILD_DIR%
set CURDIR=%CD%
cd %BUILD_DIR%
cmake -H%SRC_DIR% -B. -DQt5_DIR=C:\Qt\Qt5.12.4\5.12.4\msvc2017_64\lib\cmake\Qt5 -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=%CONFIGURATION%
if %ERRORLEVEL% NEQ 0 goto REPORTERR

set CL=/MP
%MAKE%
if %ERRORLEVEL% NEQ 0 goto REPORTERR
nmake install
if %ERRORLEVEL% NEQ 0 goto REPORTERR
cd %CURDIR%

echo Installing the package with PIP.
cd %PKG_DIR%
pip install . --upgrade --force-reinstall
if %ERRORLEVEL% NEQ 0 goto REPORTERR

goto END
:REPORTERR
echo ERROR! >&2
:END
cd %CURDIR%
