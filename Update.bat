@echo off
title Slay the Spire 2 Mod Auto Sync
mode con cols=80 lines=25

set "MOD_ZIP_URL=https://github.com/seemefly8/Slay2Spire2_modlibrary/raw/main/mods.zip"
set "MOD_DIR=%~dp0"
set "THIS_BAT=%~nx0"
set "TEMP_ZIP=%temp%\st2_mod.zip"
set "TEMP_UNZIP=%temp%\st2_unzip"

cls
echo ==============================================
echo  Slay the Spire 2 Mod Auto Sync Tool
echo ==============================================
echo  Mod Directory: %MOD_DIR%
echo  Keep this file: %THIS_BAT%
echo.

echo [1/3] Cleaning old mods...
for /d %%i in ("%MOD_DIR%*") do (rd /s /q "%%i" >nul 2>&1)
for %%i in ("%MOD_DIR%*.*") do (
    if /i not "%%~nxi"=="%THIS_BAT%" (
        del /f /q "%%i" >nul 2>&1
    )
)
echo Done.
echo.

echo [2/3] Downloading latest mod pack...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%MOD_ZIP_URL%', '%TEMP_ZIP%')"
if not exist "%TEMP_ZIP%" (
    echo Download failed. Check your network.
    pause >nul
    exit /b 1
)
echo Done.
echo.

echo [3/3] Extracting mods...
powershell -Command "Expand-Archive '%TEMP_ZIP%' '%TEMP_UNZIP%' -Force"
xcopy "%TEMP_UNZIP%\*" "%MOD_DIR%" /s /e /y /q >nul 2>&1

rd /s /q "%TEMP_UNZIP%" >nul 2>&1
del /f /q "%TEMP_ZIP%" >nul 2>&1

echo.
echo ==============================================
echo          Sync completed successfully!
echo ==============================================
echo All mods are up to date.
echo You can launch the game now.
echo.

pause >nul
exit /b 0