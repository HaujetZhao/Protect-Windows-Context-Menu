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
echo off > Registry-Menu-Lock.txt

REM 文件右键，针对所有类型文件
echo HKEY_CLASSES_ROOT\*\shell [8 19] >> Registry-Menu-Lock.txt
echo HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers [8 19] >> Registry-Menu-Lock.txt
REM 快捷方式右键，OneDrive 钟爱
echo HKEY_CLASSES_ROOT\lnkfile\shellex\ContextMenuHandlers [8 19] >> Registry-Menu-Lock.txt
REM URL 快捷方式右键，OneDrive 钟爱
echo HKEY_CLASSES_ROOT\IE.AssocFile.URL\shellex\ContextMenuHandlers [8 19] >> Registry-Menu-Lock.txt
REM 目录右键
echo HKEY_CLASSES_ROOT\Directory\shell [8 19] >> Registry-Menu-Lock.txt
echo HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers [8 19] >> Registry-Menu-Lock.txt
REM 目录背景右键
echo HKEY_CLASSES_ROOT\Directory\Background\shell [8 19] >> Registry-Menu-Lock.txt
echo HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers [8 19] >> Registry-Menu-Lock.txt
REM 文件夹扩展菜单
echo HKEY_CLASSES_ROOT\Folder\shell [8 19] >> Registry-Menu-Lock.txt
echo HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers [8 19] >> Registry-Menu-Lock.txt
REM 桌面右键
echo HKEY_CLASSES_ROOT\DesktopBackground\Shell [8 19] >> Registry-Menu-Lock.txt
echo HKEY_CLASSES_ROOT\DesktopBackground\Shellex\ContextMenuHandlers [8 19] >> Registry-Menu-Lock.txt
REM 所有对象
echo HKEY_CLASSES_ROOT\AllFilesystemObjects\shell [8 19] >> Registry-Menu-Lock.txt
echo HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers [8 19] >> Registry-Menu-Lock.txt
REM 磁盘右键
echo HKEY_CLASSES_ROOT\Drive\shell [8 19] >> Registry-Menu-Lock.txt
echo HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers [8 19] >> Registry-Menu-Lock.txt

REM =======================================================================================================================
echo off > Registry-Menu-Unlock.txt

REM 系统部分
REM 文件右键，针对所有类型文件
echo HKEY_CLASSES_ROOT\*\shell [1 5 8 17] >> Registry-Menu-Unlock.txt
echo HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers [1 5 8 17] >> Registry-Menu-Unlock.txt
REM 快捷方式右键，OneDrive 钟爱
echo HKEY_CLASSES_ROOT\lnkfile\shellex\ContextMenuHandlers [1 5 8 17] >> Registry-Menu-Unlock.txt
REM URL 快捷方式右键，OneDrive 钟爱
echo HKEY_CLASSES_ROOT\IE.AssocFile.URL\shellex\ContextMenuHandlers [1 5 8 17] >> Registry-Menu-Unlock.txt
REM 目录右键
echo HKEY_CLASSES_ROOT\Directory\shell [1 5 8 17] >> Registry-Menu-Unlock.txt
echo HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers [1 5 8 17] >> Registry-Menu-Unlock.txt
REM 目录背景右键
echo HKEY_CLASSES_ROOT\Directory\Background\shell [1 5 8 17] >> Registry-Menu-Unlock.txt
echo HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers [1 5 8 17] >> Registry-Menu-Unlock.txt
REM 文件夹扩展菜单
echo HKEY_CLASSES_ROOT\Folder\shell [1 5 8 17] >> Registry-Menu-Unlock.txt
echo HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers [1 5 8 17] >> Registry-Menu-Unlock.txt
REM 桌面右键
echo HKEY_CLASSES_ROOT\DesktopBackground\Shell [1 5 8 17] >> Registry-Menu-Unlock.txt
echo HKEY_CLASSES_ROOT\DesktopBackground\Shellex\ContextMenuHandlers [1 5 8 17] >> Registry-Menu-Unlock.txt
REM 所有对象
echo HKEY_CLASSES_ROOT\AllFilesystemObjects\shell [1 5 8 17] >> Registry-Menu-Unlock.txt
echo HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers [1 5 8 17] >> Registry-Menu-Unlock.txt
REM 磁盘右键
echo HKEY_CLASSES_ROOT\Drive\shell [1 5 8 17] >> Registry-Menu-Unlock.txt
echo HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers [1 5 8 17] >> Registry-Menu-Unlock.txt

REM =======================================================================================================================

:: 列出选项并执行命令
:menu
cls
echo 请选择以下选项：
echo 1. 锁定右键菜单编辑
echo 2. 解锁右键菜单编辑
set /p choice=请输入选项的数字：
if "%choice%"=="1" (
  echo     锁定
  regini Registry-Menu-Lock.txt
  psexec -i -s cmd /c "cd /d ""%~dp0"" && regini Registry-Menu-Lock.txt"
) else if "%choice%"=="2" (
  echo     解锁
  psexec -i -s cmd /c "cd /d ""%~dp0"" && regini Registry-Menu-Unlock.txt"
  regini Registry-Menu-Unlock.txt
) else (
  goto menu
)

REM =======================================================================================================================

del Registry-Menu-Lock.txt
del Registry-Menu-Unlock.txt

pause