@echo off

REM 搜索 OneDrive 的注册表项 
for /f  %%a in ('reg query HKCR\CLSID /s /f OneDrive /d /c /e ^| find "HKEY_CLASSES_ROOT\CLSID"') do (
  set key=%%a
)

REM 如果找到了注册表项，就写入新的值 
if defined key (
  echo %key% > OneDrive-registry.txt
  echo System.IsPinnedToNameSpaceTree = REG_DWORD 0 >> OneDrive-registry.txt
  regini OneDrive-registry.txt
  del OneDrive-registry.txt
  echo 成功修改注册表项 %key%
) else (
  echo 没有找到符合条件的注册表项
)

pause