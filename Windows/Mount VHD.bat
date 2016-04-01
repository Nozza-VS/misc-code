@ECHO OFF
TITLE Mount VHD
ECHO Mount VHD
ECHO.
ECHO.

SETLOCAL

SET DiskPartScript="%TEMP%DiskpartScript.txt"

ECHO SELECT VDISK FILE="%~1" > %DiskPartScript%
ECHO ATTACH VDISK >> %DiskPartScript%

DiskPart /s %DiskPartScript%

ENDLOCAL