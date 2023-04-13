@echo off
cd /d "%~dp0"

:: 检查管理员权限
net session >nul 2>&1
if %errorLevel% neq 0 (
  echo 请以管理员权限运行此脚本。
  pause
  exit /b
)

REM 获取当前用户的安全标识符
for /f "tokens=1* delims= " %%a in ('whoami /user /nh') do set "userSID=%%b"

REM =======================================================================================================================
echo off > Registry-Explorer-Lock.txt

echo ; 资源管理器盘符图标 >> Registry-Explorer-Lock.txt
echo HKEY_USERS\%userSID%\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer [1 5 8 17] >> Registry-Explorer-Lock.txt
echo HKEY_USERS\%userSID%\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace [8 19] >> Registry-Explorer-Lock.txt
echo ; 选择文件夹窗口盘符图标 >> Registry-Explorer-Lock.txt
echo HKEY_USERS\%userSID%\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace [8 19] >> Registry-Explorer-Lock.txt

REM =======================================================================================================================
echo off > Registry-Explorer-Unlock.txt

echo ; 资源管理器盘符图标 >> Registry-Explorer-Lock.txt
echo HKEY_USERS\%userSID%\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer [1 5 8 17] >> Registry-Explorer-Unlock.txt
echo HKEY_USERS\%userSID%\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace [1 5 8 17] >> Registry-Explorer-Unlock.txt
echo ; 选择文件夹窗口盘符图标 >> Registry-Explorer-Lock.txt
echo HKEY_USERS\%userSID%\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace [1 5 8 17] >> Registry-Explorer-Unlock.txt

REM =======================================================================================================================

:: 列出选项并执行命令
:menu
cls
echo 请选择以下选项：
echo 1. 锁定 NameSpace
echo 2. 解锁 NameSpace
set /p choice=请输入选项的数字：
if "%choice%"=="1" (
  echo     锁定
  psexec -i -s cmd /c "cd /d ""%~dp0"" && regini Registry-Explorer-Lock.txt"
) else if "%choice%"=="2" (
  echo     解锁
  psexec -i -s cmd /c "cd /d ""%~dp0"" && regini Registry-Explorer-Unlock.txt"
) else (
  goto menu
)

REM =======================================================================================================================

del Registry-Explorer-Lock.txt
del Registry-Explorer-Unlock.txt

pause