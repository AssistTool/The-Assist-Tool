@echo off
        color f
        echo Please Wait...
                set mydir=%~dp0
                Powershell -Command "& { Start-Process \"%mydir%notAssistTool.bat\" -verb RunAs}"
