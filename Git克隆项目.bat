@echo off
setlocal enabledelayedexpansion
color 1F
title Git��¡��Ŀ

:menu
mode con cols=25 lines=10
cls
@echo *************************
@echo.
@echo 1. ��¡��Ŀ������ģ��
@echo 2. �ѿ�¡��Ŀû����ģ��
@echo.
@echo *************************
@echo.
set /p user_choice="������ѡ�� (1��2): "

if "!user_choice!"=="1" (
    call :clone_with_submodules
) else if "!user_choice!"=="2" (
    call :update_submodules
) else (
    echo ѡ����Ч�����������롣
    timeout /t 3 >nul
)

goto menu

:clone_with_submodules
mode con cols=120 lines=30
set /p repo_url="������Git�ֿ��URL (��.git��β): "

if "!repo_url!"=="" (
    echo ����URL����Ϊ�ա�
    pause
    goto :eof
)

:: ���URL�Ƿ���.git��β
if /i "!repo_url:~-4!" NEQ ".git" (
    echo ����URL������.git��β��
    pause
    goto :eof
)

echo ��¡��Ŀ: "!repo_url!"
git clone --recurse-submodules "!repo_url!"
pause
goto :eof

:update_submodules
mode con cols=120 lines=30
set /p cloned_repo_path="�������ѿ�¡��Ŀ��·��: "

if "!cloned_repo_path!"=="" (
    echo ����·������Ϊ�ա�
    pause
    goto :eof
)

:: ���·���Ƿ���Ч
if not exist "!cloned_repo_path!" (
    echo ����ָ����·�������ڣ�����·����
    pause
    goto :eof
)

cd /d "!cloned_repo_path!" || (
    echo �޷����ʸ�·��������·���Ƿ���ȷ��
    pause
    goto :eof
)

echo ���ڳ�ʼ���͸�����ģ��...
git submodule update --init --recursive
pause
goto :eof