@echo off
if defined CLAUDE_BASE (set "BASE_DIR=%CLAUDE_BASE%") else (set "BASE_DIR=D:\Folder")
dir /b /ad "%BASE_DIR%" | "%~dp0fzf.exe" --height 40%% --reverse --prompt="Open folder: " > "%TEMP%\fzfout.txt"
set /p SELECTED=<"%TEMP%\fzfout.txt"
del "%TEMP%\fzfout.txt"
if not "%SELECTED%"=="" (
    explorer "%BASE_DIR%\%SELECTED%"
)
