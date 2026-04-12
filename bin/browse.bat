@echo off
setlocal enabledelayedexpansion
set "CURRENT=%~d0\Folder"

:LOOP
echo.
echo  [!CURRENT!]

set "MENU=%TEMP%\fzfmenu.txt"
set "RESULT=%TEMP%\fzfresult.txt"

echo [OPEN]> "!MENU!"
echo ..>> "!MENU!"
dir /b /ad "!CURRENT!" >> "!MENU!"

type "!MENU!" | "%~dp0fzf.exe" --height 40%% --reverse --prompt="Browse: " > "!RESULT!"

set "SELECTED="
for /f "usebackq delims=" %%A in ("!RESULT!") do set "SELECTED=%%A"
del "!MENU!"
del "!RESULT!"

if "!SELECTED!"=="" goto :END
if "!SELECTED!"=="[OPEN]" (
    explorer "!CURRENT!"
    goto :END
)
if "!SELECTED!"==".." (
    for %%I in ("!CURRENT!\..") do set "CURRENT=%%~fI"
    goto :LOOP
)
set "CURRENT=!CURRENT!\!SELECTED!"
goto :LOOP

:END
endlocal
