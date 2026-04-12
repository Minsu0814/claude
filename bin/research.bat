@echo off
set "RESEARCH_DIR=%~d0\Folder\Research"
dir /b /ad "%RESEARCH_DIR%" | "%~dp0fzf.exe" --height 40%% --reverse --prompt="Select: " > "%TEMP%\fzfout.txt"
set /p SELECTED=<"%TEMP%\fzfout.txt"
del "%TEMP%\fzfout.txt"
if not "%SELECTED%"=="" (
    code "%RESEARCH_DIR%\%SELECTED%"
)
