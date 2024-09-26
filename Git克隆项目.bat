@echo off
setlocal enabledelayedexpansion
color 1F
title Git克隆项目

:menu
mode con cols=25 lines=10
cls
@echo *************************
@echo.
@echo 1. 克隆项目包含子模块
@echo 2. 已克隆项目没有子模块
@echo.
@echo *************************
@echo.
set /p user_choice="请输入选项 (1或2): "

if "!user_choice!"=="1" (
    call :clone_with_submodules
) else if "!user_choice!"=="2" (
    call :update_submodules
) else (
    echo 选择无效，请重新输入。
    timeout /t 3 >nul
)

goto menu

:clone_with_submodules
mode con cols=120 lines=30
set /p repo_url="请输入Git仓库的URL (以.git结尾): "

if "!repo_url!"=="" (
    echo 错误：URL不能为空。
    pause
    goto :eof
)

:: 检查URL是否以.git结尾
if /i "!repo_url:~-4!" NEQ ".git" (
    echo 错误：URL必须以.git结尾。
    pause
    goto :eof
)

echo 克隆项目: "!repo_url!"
git clone --recurse-submodules "!repo_url!"
pause
goto :eof

:update_submodules
mode con cols=120 lines=30
set /p cloned_repo_path="请输入已克隆项目的路径: "

if "!cloned_repo_path!"=="" (
    echo 错误：路径不能为空。
    pause
    goto :eof
)

:: 检查路径是否有效
if not exist "!cloned_repo_path!" (
    echo 错误：指定的路径不存在，请检查路径。
    pause
    goto :eof
)

cd /d "!cloned_repo_path!" || (
    echo 无法访问该路径，请检查路径是否正确。
    pause
    goto :eof
)

echo 正在初始化和更新子模块...
git submodule update --init --recursive
pause
goto :eof