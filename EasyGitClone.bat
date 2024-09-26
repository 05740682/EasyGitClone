@echo off
setlocal enabledelayedexpansion
color 1F
title Git Clone Project

:menu
mode con cols=45 lines=10
cls
@echo *********************************************
@echo.
@echo 1. Clone project with submodules
@echo 2. Already cloned project without submodules
@echo.
@echo *********************************************
@echo.
set /p user_choice="Please enter your choice (1 or 2): "

if "!user_choice!"=="1" (
    call :clone_with_submodules
) else if "!user_choice!"=="2" (
    call :update_submodules
) else (
    echo Invalid choice, please enter again.
    timeout /t 3 >nul
)

goto menu

:clone_with_submodules
mode con cols=120 lines=30
set /p repo_url="Please enter the Git repository URL (must end with .git): "

if "!repo_url!"=="" (
    echo Error: URL cannot be empty.
    pause
    goto :eof
)

:: Check if URL ends with .git
if /i "!repo_url:~-4!" NEQ ".git" (
    echo Error: URL must end with .git.
    pause
    goto :eof
)

echo Cloning project: "!repo_url!"
git clone --recurse-submodules "!repo_url!"
pause
goto :eof

:update_submodules
mode con cols=120 lines=30
set /p cloned_repo_path="Please enter the path of the already cloned project: "

if "!cloned_repo_path!"=="" (
    echo Error: Path cannot be empty.
    pause
    goto :eof
)

:: Check if path is valid
if not exist "!cloned_repo_path!" (
    echo Error: The specified path does not exist, please check the path.
    pause
    goto :eof
)

cd /d "!cloned_repo_path!" || (
    echo Unable to access the path, please check if it is correct.
    pause
    goto :eof
)

echo Initializing and updating submodules...
git submodule update --init --recursive
pause
goto :eof
