@echo off > Registry.txt

REM 搜索注册表项 
for /f "delims=" %%a in ('reg query HKEY_CLASSES_ROOT /s /f "PlayTo" /k /c /e ^| find "HKEY_CLASSES_ROOT"') do (
  echo %%a [DELETE] >> Registry.txt
)

REM 删除注册表项 
regini Registry.txt
del Registry.txt

pause


