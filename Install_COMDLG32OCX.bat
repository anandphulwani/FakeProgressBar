@echo off
setlocal

:: Determine if the system is 64-bit or 32-bit
if defined ProgramFiles(x86) (
    set "sysdir=%windir%\SysWOW64"
) else (
    set "sysdir=%windir%\System32"
)

:: Check if the OCX file already exists
if not exist "%sysdir%\comdlg32.ocx" (
    :: Copy the OCX file to the appropriate system directory
    copy /Y "comdlg32.ocx" "%sysdir%"

    :: Register the OCX file
    regsvr32 /s "%sysdir%\comdlg32.ocx"
)

:: Run the executable
start "" "FakePB_Setup.exe"

endlocal
