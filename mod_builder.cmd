@echo off
set MOD_NAME=zm_t5_hud
set OAT_BASE=C:\Users\dhery\OneDrive\Desktop\!Personal\tools\OAT
set MOD_BASE=%cd%

"%OAT_BASE%\linker.exe" ^
-v ^
--base-folder "%OAT_BASE%" ^
--add-asset-search-path "%MOD_BASE%" ^
--source-search-path "%MOD_BASE%\zone_source" ^
--output-folder "%MOD_BASE%\zone" mod

set err=%ERRORLEVEL%

if %err% EQU 0 (
    if not exist "%LOCALAPPDATA%\Plutonium\storage\t6\mods\%MOD_NAME%" mkdir "%LOCALAPPDATA%\Plutonium\storage\t6\mods\%MOD_NAME%"

    XCOPY "%MOD_BASE%\zone\mod.ff" "%LOCALAPPDATA%\Plutonium\storage\t6\mods\%MOD_NAME%\mod.ff" /Y
    XCOPY "%MOD_BASE%\mod.json" "%LOCALAPPDATA%\Plutonium\storage\t6\mods\%MOD_NAME%\mod.json" /Y
    XCOPY "%MOD_BASE%\mod.iwd" "%LOCALAPPDATA%\Plutonium\storage\t6\mods\%MOD_NAME%\mod.iwd" /Y

    echo DONE!
) ELSE (
    COLOR C
    echo FAIL!
)

pause